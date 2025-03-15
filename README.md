# **S**h1zok's **A**ctions **Sys**tem

# Hi Internet! I am Sh1zok("1" pronounced as "i"), the author of this script.
Now I'll tell you what and how.

# What is this?
This is my [Figura mod](https://github.com/FiguraMC/Figura) avatar action management system.

# SASys.lua
The script itself. It controls the actions described in config.lua, makes the code cleaner and more readable for the avatar developer and provides simple control of actions for the avatar user.

# config.lua(any file of .lua format)
This is where the script's localization and settings are stored, and actions and their animations are described.

# How to use it?
1. Hover over the action wheel button, scroll the mouse wheel and select your action from the list.
2. Left-click to play the action.
3. Right-click to stop the action.

# How do I add this to my avatar?
1. Download the [latest release](https://github.com/Sh1zok/Shizok-s_Actions_System/releases/tag/Public).
2. Place SASys.lua in your avatar folder.
3. In another file(config), initialize it with ```require("SASys")```
4. Done.(●'◡'●)

# How to configure SASys?
## First of all, set up an action list
Example:
```
actionsList = {
    {"Action 1 name", animations.model.action1},
    {"Action 2 name", animations.model.action2},
    {"Action without animation", nil}
}
```

## Add animations that are not compatible with action animations
Example:
```
stopingAnimsList = {
    animations.model.swimming,
    animations.model.sprinting,
    animations.model.crouching
}
```
If animations from this list start playing, the current action will be terminated early to avoid incorrect intersection of animations.

## Adjust the priorities and interpolation of action animation transitions.
Example:
```
prioritizeActionAnimations(3) -- Now each animation will have a priority of 3
blendActionAnimations(7.5) -- Now the transition between actions and idle state will be smooth (need GSAnimBlend)
```

## Customize the look.
Use the game color code to change the common and accent color.
### ![MC color codes](https://xenolith.ru/uploads/posts/2021-12/1640426692_bezymjannyj.jpg)
Example:
```
actionButtonCommonColor = "§3"
actionButtonAccentColor = "§f"
```
### Also change the localization to suit your needs
Example:
```
actionButtonTitle = "AcTiOn ayo"
actionButtonDescription = "U know what to do yup\n\n My cool actions:\n"
```
### Set the list size if you have too many actions.
Example:
```
actionsListDescriptionSize = 5
```
## What does it look like now?
![Demonstartion](https://github.com/Sh1zok/Shizok-s_Actions_System/blob/stable/Demonstration.png)

# How do I add an action wheel button?
Example:
```
actions = newPage:newAction()
    :title(updateActionButtonTitle())
    :item("minecraft:light") -- You can use any item or texture
    :onLeftClick(function() -- LMB is playing action
        actionButtonPlay()
        actions:title(updateActionButtonTitle())
    end)
    :onRightClick(function() -- RMB is instantly stop action
        actionButtonStop()
        actions:title(updateActionButtonTitle())
    end)
    :onScroll(function(dir) -- Scrolling selects an action from a list
        actionButtonSelect(dir)
        actions:title(updateActionButtonTitle())
    end)
```
