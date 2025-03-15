--[[
    ■■■■
    ■  ■ Sh1zok's Actions System
    ■■■  v2.1
]]--



--[[
    Initialization
]]--
stopingAnimsList = {} -- List of animations incompatible with actions
actionsList = {} -- List of actions lol
actionButtonCommonColor = "§8" -- This color will indicate items in the action list
actionButtonAccentColor = "§f" -- This color will indicate the selected action from the list of actions
actionButtonTitle = "Action" -- Standard localization of the word "Action"(eng)
actionButtonDescription = "Scroll down: Next action\n Scroll up: Previous action\n LMB: Play action\n RMB: Stop action\n\n Actions list:\n" -- Standard description of the action button
local selectedAction = 1 -- Action selection
activeAction = {"Нет", nil} -- Active action variable
actionsListDescriptionSize = 5 -- Standard length of actions list

-- Function to stop all actions
function stopAllActions()
    for _, action in ipairs(actionsList) do
        if action[2] ~= nil then
            action[2]:stop()
        end
    end

    activeAction = {"Нет", nil}
end

-- Function for prioritizing action animations
function prioritizeActionAnimations(priorityValue)
    for _, action in ipairs(actionsList) do
        if action[2] ~= nil then
            action[2]:setPriority(priorityValue)
        end
    end
end

-- Function for setting interpolation of action animations if there is GSAnimBlend among the scripts
function blendActionAnimations(blendValue)
    -- Finding GSAnimBlend
    local GSAnimBlendIsHere = false
    for _, key in ipairs(listFiles(nil,true)) do
        if key:find("GSAnimBlend$") then
            GSAnimBlendIsHere = true
            break
        end
    end

    -- If GSAnimBlend is found, then we set the interpolation of action animations
    if GSAnimBlendIsHere then
        for _, action in ipairs(actionsList) do
            if action[2] ~= nil then
                action[2]:setBlendTime(blendValue)
            end
        end
    end
end

-- Function that generates the button title
function updateActionButtonTitle()
    -- Button name and its description
    local title = actionButtonTitle .. ": " .. actionsList[selectedAction][1] .. "\n §7" .. actionButtonDescription

    -- Defining the lower and upper end of a list of actions
    local descriptionListTop = selectedAction - math.floor(actionsListDescriptionSize / 2)
    local descriptionListBottom = selectedAction + math.floor(actionsListDescriptionSize / 2)
    if descriptionListTop < 1 then
        descriptionListTop = 1 
        descriptionListBottom = actionsListDescriptionSize
    end
    if descriptionListBottom > #actionsList then
        descriptionListBottom = descriptionListBottom - (descriptionListBottom - #actionsList) + 1
        descriptionListTop = descriptionListBottom - actionsListDescriptionSize
    end

    -- Adding a list of actions to the button title
    for index, value in ipairs(actionsList) do
        if index >= descriptionListTop and index <= descriptionListBottom then
            if index == selectedAction then -- Highlighting the selected action with an accent color
                title = title .. "\n " .. actionButtonAccentColor .. index .. ". " .. value[1]
            else -- The rest are more dim
                title = title .. "\n " .. actionButtonCommonColor .. index .. ". " .. value[1]
            end
        end
    end

    return(title)
end

-- Сheck every tick for playback of animations incompatible with actions
function events.tick()
    for _, value in ipairs(stopingAnimsList) do
        if value:isPlaying() then
            stopAllActions()
        end
    end
end



--[[
    Pings
]]--
-- Ping what plays action
function pings.playAction(selection)
    stopAllActions() -- Stop all actions

    activeAction = actionsList[selection] -- Selecting an active action

    if activeAction[2] ~= nil then
        activeAction[2]:play() -- Play active action
    end
end

-- Ping stopping action
function pings.stopAction()
    stopAllActions()
end



--[[
    Action wheel button functions
]]--
-- Function to play actions
function actionButtonPlay()
    pings.playAction(selectedAction) -- Активируем действие
end

-- Function to stop action
function actionButtonStop()
    pings.stopAction()
end

-- Function for selecting an action
function actionButtonSelect(dir)
    if dir < 0 then -- When scrolling up
        if selectedAction ~= #actionsList then
            selectedAction = selectedAction + 1
        else -- Go to the end of the list if the selection is at the beginning of the list
            selectedAction = 1
        end
    else -- When scrolling down
        if selectedAction ~= 1 then
            selectedAction = selectedAction - 1
        else -- Jump to the top of the list if the selection is at the end of the list
            selectedAction = #actionsList
        end
    end
end
