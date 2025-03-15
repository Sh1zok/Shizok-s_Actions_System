--[[
    Initialization
]]--
require("folderName.SASys")
stopingAnimsList = {
    animations.yourBBModel.anim1,
    animations.yourBBModel.anim2
}
actionsList = {
    {"Action 1 name", animations.model.action1},
    {"Action 2 name", animations.model.action2},
    {"Action without animation", nil}
}
prioritizeActionAnimations(3)
blendActionAnimations(7.5)



--[[
    Special actions: variables
]]--
local isSpclActionPlaying = false



--[[
    Special actions: functions
]]--
function events.render()
    if activeAction[1] == "Action without animation" then
        isSpclActionPlaying = true
    else
        isSpclActionPlaying = false
    end
end
