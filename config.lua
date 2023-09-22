Config = {}
Config.Debug = false -- Used to debug circle (target) zones

-- Target system, available options are: 'ox_target', 'qb-target', 'qtarget' & 'custom'
-- If 'custom', it needs to be added to client/functions.lua
Config.Target = 'ox_target'

-- WeatherSync provides default support for cd_easytime only.
-- Set to true if using cd_easytime to pause weather sync while inside shells
-- And resume upon exiting
Config.WeatherSync = false

-- Create as many shell locations as you want here, following the existing format
-- If you use K4MB1 shells, there is an included file with this resource that gives
-- You ALL K4MB1 shell names & offsets!
Config.Shells = {
    {
        shellName = 'shell_lester', -- The name of the shell
        offset = vec3(-1.606091, -5.912278, 1.2), -- The offset of the shell
        enterLabel = 'Enter', -- The target label used to enter at enterShell location
        enterIcon = 'fas fa-sign-out-alt', -- The target icon used for the enterLabel
        exitLabel = 'Exit', -- The target label used to exit at exitShell location
        exitIcon = 'fas fa-sign-out-alt', -- The target icon used for the exitLabel
        enterShell = vec3(-24.8487, -1556.9166, 30.6869), -- The location the target exists to enter the shell
        enterHeading = 0.0, -- The heading (direction) a player is facing when entering the shell
        exitShell = vec3(-26.3735, -1553.9272, -98.9566), -- The location the target exists to exit the shell
        exitHeading = 48.0, -- The heading (direction) a player is facing when exiting the shell
        shellCoords = vec3(-26.325, -1553.846, -97.387), -- The location at which the shell itself exists (set below the map)
    },
    {
        shellName = 'shell_michael',
        offset = vec3(-8.991788, 5.8, 10.190231),
        enterLabel = 'Enter',
        enterIcon = 'fas fa-sign-out-alt',
        exitLabel = 'Exit',
        exitIcon = 'fas fa-sign-out-alt',
        enterShell = vec3(-35.8366, -1555.1882, 30.6768),
        enterHeading = 0.0,
        exitShell = vec3(-127.7633, -1467.9712, -105.9730),
        exitHeading = 328.81,
        shellCoords = vec3(-127.0583, -1467.8815, -91.7926),
    },
    -- Create more locations here following the format above
}