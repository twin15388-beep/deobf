"""Скачать текущую сборку из лоадера Ouroboros (github.com/joustingmatch/Ouroboros).

Лоадер раскладывает игры так:

    BASE = 'https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/games/'
    local file = places[game.PlaceId] or games[game.CreatorId]
    loadstring(game:HttpGet(BASE .. file))()

Оувленд (PlaceId 136406881576517) обслуживается файлом ``games/ps2.luau``.
Файл переписывается автором по нескольку раз в день, поэтому перед сверкой
клонов его всегда надо перекачивать.

Usage:
    python3 tools/fetch_build.py                     # games/ps2.luau -> artifacts/
    python3 tools/fetch_build.py --path games/ps2.luau --out artifacts
    python3 tools/fetch_build.py --list              # что вообще поменялось недавно

Пишет рядом sidecar ``<файл>.json``: коммит, дата, размер, md5, ссылка.
"""

import base64
import hashlib
import json
import os
import subprocess
import sys

REPO = "joustingmatch/Ouroboros"


def gh(*args):
    out = subprocess.run(["gh", "api", *args], capture_output=True, text=True)
    if out.returncode:
        raise SystemExit("gh api %s: %s" % (" ".join(args), out.stderr.strip()[:300]))
    return out.stdout


def gh_json(*args):
    return json.loads(gh(*args) or "null")


def last_commit(path):
    data = gh_json("repos/%s/commits" % REPO, "-X", "GET", "-f", "path=" + path, "-f", "per_page=1")
    if not data:
        raise SystemExit("нет коммитов для %s" % path)
    return data[0]


def blob_sha(commit_sha, path):
    tree = gh_json("repos/%s/git/trees/%s?recursive=1" % (REPO, commit_sha))
    for item in tree.get("tree", []):
        if item["path"] == path:
            return item["sha"]
    raise SystemExit("в дереве коммита нет %s" % path)


def fetch(path, out_dir):
    commit = last_commit(path)
    date = commit["commit"]["author"]["date"]
    sha = commit["sha"]
    blob = blob_sha(sha, path)
    meta = gh_json("repos/%s/git/blobs/%s" % (REPO, blob))
    data = base64.b64decode(meta["content"])
    os.makedirs(out_dir, exist_ok=True)
    base = os.path.basename(path)
    stem, ext = os.path.splitext(base)
    target = os.path.join(out_dir, "%s_%s%s" % (stem, date[:10], ext))
    with open(target, "wb") as fh:
        fh.write(data)
    digest = hashlib.md5(data).hexdigest()
    sidecar = {
        "repo": REPO,
        "path": path,
        "commit": sha,
        "date": date,
        "size": len(data),
        "md5": digest,
        "saved_as": target,
        "raw_url": "https://raw.githubusercontent.com/%s/main/%s" % (REPO, path),
    }
    with open(target + ".json", "w") as fh:
        json.dump(sidecar, fh, indent=1, ensure_ascii=False)
    print("дата:   %s\nкоммит: %s\nразмер: %d\nmd5:    %s\nфайл:   %s"
          % (date, sha, len(data), digest, target))
    return target, sidecar


def main(argv):
    path = "games/ps2.luau"
    out_dir = "artifacts"
    if "--path" in argv:
        path = argv[argv.index("--path") + 1]
    if "--out" in argv:
        out_dir = argv[argv.index("--out") + 1]
    if "--list" in argv:
        data = gh_json("repos/%s/commits" % REPO, "-X", "GET", "-f", "path=" + path,
                       "-f", "per_page=15")
        for item in data:
            print("%s  %s  %s" % (item["commit"]["author"]["date"], item["sha"][:10],
                                  item["commit"]["message"].split("\n")[0][:60]))
        return
    target, side = fetch(path, out_dir)
    # пул текущей сборки рядом (нужен для чтения кода)
    try:
        pool = os.path.join("data", "pool_index_%s.json" % side["date"][:10])
        subprocess.run([sys.executable, "tools/pool_map.py", target, pool,
                        "--alias", "fwe[164]"], check=True)
    except SystemExit as exc:
        print("не удалось собрать пул: %s" % exc)


if __name__ == "__main__":
    main(sys.argv[1:])
