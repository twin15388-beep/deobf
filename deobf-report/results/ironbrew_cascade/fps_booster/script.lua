local L1_1, L2_1, L3_1
arg = (settings()).Network
networkSettings = arg
arg = (settings()).Rendering
renderSettings = arg
arg = (settings())["Game Options"]
gameSettings = arg
arg = UserSettings()
L1_1 = arg
L2_1 = "UserGameSettings"
arg = arg.FindService(L1_1, L2_1)
if arg then
else
  arg = UserSettings()
  L1_1 = arg
  L2_1 = "UserGameSettings"
  arg = arg.GetService(L1_1, L2_1)
end
userGameSettings = arg
L1_1 = Enum.QualityLevel.Level01
L1_1 = Enum.SavedQualitySetting.QualityLevel1
L1_1 = Enum.VideoQualitySettings.LowResolution
arg = true
lagConfiguration = arg
function arg(...)
  local L1_2
  L1_2 = lagConfiguration.qualityLevel
  L1_2 = lagConfiguration.savedQualityLevel
  L1_2 = lagConfiguration.videoQualitySetting
  L1_2 = lagConfiguration.eagerBulkExecution
  L1_2 = lagConfiguration.incommingReplicationLag
  L1_2 = lagConfiguration.hasEverUsedVR
  arg = L1_2
end
boostAttempt = arg
arg = boostAttempt
arg()
