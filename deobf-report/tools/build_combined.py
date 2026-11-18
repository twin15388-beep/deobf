#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
build_combined.py — собрать единый файл результата деобфускации для каждого сэмпла.

ВНИМАНИЕ (2026-11-17): после дедупа `script.lua`/`PARTS.md` в репозитории НЕТ
(оба побайтово встроены в combined; первоисточники — в git-истории).
Скрипт сохранён как документация формата и для пересборки из истории;
повторный запуск по текущему дереву просто пропустит каталоги без script.lua.

Формат (соглашение 2026-11-17, утверждено пользователем): вариант «A» —
корректный Lua-файл, в котором восстановленный код лежит как есть, а вся
метаинформация (PARTS.md: механики, API, имена функций, парты) встроена
выше по файлу как комментарии. Один файл = один сэмпл.

Для обычных сэмплов (results/<игра>/<сэмпл>/script.lua существует):
  header-comment + PARTS.md (построчно как `-- `) + дословно script.lua
  → <сэмпл>/script.combined.lua

Для shindo_life/dogehub_v2_shindo (нет script.lua — финальный слой лежит в
recovered/):
  header-comment + PARTS.md + дословно recovered/dogehub_v2_shindo_payload_remote_plaintext.lua
  → <сэмпл>/script.combined.lua  (с пометкой о цепочке и RECOVERY.md)

Генератор детерминирован: повторный запуск без изменений во входных файлах
даёт байт-идентичный результат. После записи выполняется self-check:
секция кода в combined совпадает с исходником дословно.
"""
import hashlib
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))  # deobf-report/
RESULTS = os.path.join(ROOT, 'results')
DATE = '2026-11-17'


def sha256_bytes(b: bytes) -> str:
    return hashlib.sha256(b).hexdigest()


def header(game: str, sample: str, rel: str, components: list, note: str = None) -> str:
    lines = [
        '--======================================================================',
        '-- script.combined.lua — ЕДИНЫЙ ФАЙЛ результата деобфускации',
        f'-- Игра/тема: {game} · Сэмпл: {sample}',
        f'-- Каталог:   deobf-report/results/{rel}/',
        f'-- Дата сборки: {DATE} · Сгенерировано deobf-report/tools/build_combined.py',
        '--',
        '-- Состав (в этом порядке):',
    ]
    for c in components:
        lines.append(f'--   * {c}')
    lines += [
        '--',
        '-- Раздел 1/2 ниже — содержимое PARTS.md, построчно как Lua-комментарии.',
        '-- Раздел 2/2 — восстановленный код (script.lua) ДОСЛОВНО, без изменений.',
        '-- Комментарии в этом файле НЕ являются частью исходного кода игры.',
        '-- ВНИМАНИЕ: это чужой код (игровой скрипт/хаб). Не запускайте его в Roblox,',
        '-- не понимая, что он делает; результаты получены статической деобфускацией.',
    ]
    if note:
        for l in note.splitlines():
            lines.append('-- ' + l)
    lines.append('--======================================================================')
    lines.append('')
    return '\n'.join(lines)


def parts_as_comments(parts_md: bytes) -> bytes:
    out = [
        '--======================================================================',
        '-- РАЗДЕЛ 1/2: PARTS.md (инвентарь: механики / Roblox API / имена функций / парты)',
        '--======================================================================',
    ]
    for raw in parts_md.decode('utf-8', 'replace').splitlines():
        if raw.strip():
            out.append('-- ' + raw)
        else:
            out.append('--')
    out += [
        '--======================================================================',
        '-- КОНЕЦ PARTS.md',
        '--======================================================================',
        '-- РАЗДЕЛ 2/2: восстановленный код (дословно)',
        '--======================================================================',
        '',
    ]
    return ('\n'.join(out)).encode('utf-8')


def build_one(sample_dir: str, special_shindo: bool = False):
    rel = os.path.relpath(sample_dir, RESULTS)
    game, sample = rel.split(os.sep, 1) if os.sep in rel else (rel, '')
    parts_path = os.path.join(sample_dir, 'PARTS.md')
    if not os.path.isfile(parts_path):
        return None, f'SKIP {rel}: нет PARTS.md'
    parts_md = open(parts_path, 'rb').read()

    if special_shindo:
        code_path = os.path.join(sample_dir, 'recovered',
                                 'dogehub_v2_shindo_payload_remote_plaintext.lua')
        note = ('ОСОБЫЙ СЛУЧАЙ (shindo_life/dogehub_v2_shindo): локального script.lua нет —\n'
                'финальный исполняемый слой лежит в recovered/. Код ниже = публичный файл\n'
                'Kasep6720/Secret@DogeHubV2:Games/ShindoLife (plain Lua, скачан напрямую после\n'
                'трассировки HttpGet/loadstring в blackhole-песочнице). Цепочка лоадеров,\n'
                'IronBrew/AztupBrew-тела (не девиртуализированы) и все 14 модулей — каталог\n'
                'recovered/ + RECOVERY.md + SHA256SUMS. Внимание: mod_userlogs.lua постит\n'
                'внешний Discord-совместимый вебхук; в файле он НЕ вызывался.')
        components = [
            'PARTS.md (статический разбор контейнера) — ниже как комментарии',
            'recovered/dogehub_v2_shindo_payload_remote_plaintext.lua (506 964 B, plain Lua) — ниже дословно',
            'RECOVERY.md / SHA256SUMS / recovered/ — цепочка модулей и хеши',
        ]
    else:
        code_path = os.path.join(sample_dir, 'script.lua')
        note = None
        components = [
            'PARTS.md (механики / Roblox API / имена функций / парты) — ниже как комментарии',
            f'script.lua — ниже дословно (sha256 считается ниже в этом файле)',
        ]

    if not os.path.isfile(code_path):
        return None, f'SKIP {rel}: нет кода (ожидался {os.path.basename(code_path)})'

    code = open(code_path, 'rb').read()
    code_sha = sha256_bytes(code)
    components[-1] = components[-1].replace('sha256 считается ниже в этом файле',
                                            f'sha256={code_sha}')
    hdr = header(game, sample, rel.replace(os.sep, '/'), components, note).encode('utf-8')
    body = parts_as_comments(parts_md) + code
    out = hdr + body

    out_path = os.path.join(sample_dir, 'script.combined.lua')
    tmp = out_path + '.tmp'
    with open(tmp, 'wb') as f:
        f.write(out)
    # self-check: код внутри combined совпадает дословно с исходником
    written = open(tmp, 'rb').read()
    assert written.endswith(code), f'{rel}: code section mismatch'
    os.replace(tmp, out_path)
    return {
        'rel': rel.replace(os.sep, '/'),
        'game': game,
        'sample': sample,
        'code_src': os.path.relpath(code_path, RESULTS).replace(os.sep, '/'),
        'sha256': code_sha,
        'code_bytes': len(code),
        'out_bytes': len(out),
        'out_path': out_path,
    }, None


def iter_sample_dirs():
    for base, dirs, files in os.walk(RESULTS):
        if 'PARTS.md' in files:
            yield base


def main():
    results, skips = [], []
    for d in sorted(iter_sample_dirs()):
        rel = os.path.relpath(d, RESULTS).replace(os.sep, '/')
        special = (rel == 'shindo_life/dogehub_v2_shindo')
        r, skip = build_one(d, special_shindo=special)
        if r:
            results.append(r)
        else:
            skips.append(skip)
    for s in skips:
        print(s)
    print(f'WROTE {len(results)} script.combined.lua')
    # манифест для COMBINED.md
    with open(os.path.join(RESULTS, 'COMBINED.tsv'), 'w', encoding='utf-8') as f:
        f.write('rel\tgame\tsample\tcode_src\tsha256\tcode_bytes\tout_bytes\n')
        for r in results:
            f.write('\t'.join(str(r[k]) for k in
                    ('rel', 'game', 'sample', 'code_src', 'sha256', 'code_bytes', 'out_bytes')) + '\n')
    if not results:
        sys.exit(1)


if __name__ == '__main__':
    main()
