-- Initialize variable
local shell

-- Function to add circle target zones
local AddCircleZone = function(data)
    if Config.Target == 'ox_target' then
        exports.ox_target:addSphereZone(data)
    elseif Config.Target == 'qb-target' then
        exports['qb-target']:AddCircleZone(data.name, data.coords, data.radius, {
            name = data.name,
            debugPoly = data.debug}, {
            options = data.options,
            distance = 2,
        })
    elseif Config.Target == 'qtarget' then
        exports.qtarget:AddCircleZone(data.name, data.coords, data.radius, {
            name = data.name,
            debugPoly = data.debug}, {
            options = data.options,
            distance = 2,
        })
    elseif Config.Target == 'custom' then
        -- Add support for a custom target system here
    else
        print('No target system defined in the config file.')
    end
end

-- Function that spawns the shell(s)/object(s)
local SpawnShell = function()
    for i = 1, #Config.Shells do
        local shellName = Config.Shells[i].shellName
        lib.requestModel(shellName, 500)
        while not HasModelLoaded(shellName) do
            Wait(0)
        end
        local spawnPosition = Config.Shells[i].shellCoords.xyz - Config.Shells[i].offset
        shell = CreateObjectNoOffset(joaat(Config.Shells[i].shellName), spawnPosition.x, spawnPosition.y, spawnPosition.z, false, false, false)
        while not DoesEntityExist(shell) do
            Wait(0)
        end
        FreezeEntityPosition(shell, true)
    end
end

-- Function that teleports player from entry point to shell location
local EnterShell = function(coords, heading)
    if not shell then
        SpawnShell()
    end
    DoScreenFadeOut(1500)
    Wait(1000)
    if Config.WeatherSync then
        TriggerEvent('cd_easytime:PauseSync', true)
    end
    Wait(2000)
    SetEntityCoords(cache.ped, coords.x, coords.y, coords.z, false, false, false, false)
    SetEntityHeading(cache.ped, heading)
    DoScreenFadeIn(1500)
    Wait(2500)
end

-- Function that teleports player from shell to entry point
local ExitShell = function(coords, heading)
    if not shell then
        SpawnShell()
    end
    DoScreenFadeOut(1500)
    Wait(1000)
    if Config.WeatherSync then
        TriggerEvent('cd_easytime:PauseSync', false)
    end
    Wait(2000)
    SetEntityCoords(cache.ped, coords.x, coords.y, coords.z, false, false, false, false)
    SetEntityHeading(cache.ped, heading)
    DoScreenFadeIn(1500)
    Wait(2500)
end

-- Creates all the target zones
for i = 1, #Config.Shells do
    local enterData = {
        name = 'enter' ..Config.Shells[i].shellName,
        coords = Config.Shells[i].enterShell,
        radius = 0.75,
        debug = Config.Debug,
        options = {
            {
                label = Config.Shells[i].enterLabel,
                icon = Config.Shells[i].enterIcon,
                action = function()
                    EnterShell(Config.Shells[i].exitShell, Config.Shells[i].enterHeading)
                end,
                onSelect = function()
                    EnterShell(Config.Shells[i].exitShell, Config.Shells[i].enterHeading)
                end,
                distance = 2
            }
        }
    }
    AddCircleZone(enterData)
    local exitData = {
        name = 'exit' ..Config.Shells[i].shellName,
        coords = Config.Shells[i].exitShell,
        radius = 0.75,
        debug = Config.Debug,
        options = {
            {
                label = Config.Shells[i].exitLabel,
                icon = Config.Shells[i].exitIcon,
                action = function()
                    ExitShell(Config.Shells[i].enterShell, Config.Shells[i].exitHeading)
                end,
                onSelect = function()
                    ExitShell(Config.Shells[i].enterShell, Config.Shells[i].exitHeading)
                end,
                distance = 2
            }
        }
    }
    AddCircleZone(exitData)
end