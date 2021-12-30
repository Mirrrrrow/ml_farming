ESX = nil
local amfarmen = false
local cooldown = false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

end)

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 1, 0, false, false, false)
	end)
end



function nearFarmingSpot()
    for k,v in pairs(Config.Farming) do
        local pos = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(v.position, pos, true)
        if dist <= v.radius then --1.5
            return {
                name = v.display,
                itemNeeded = v.itemNeeded,
                cooldowni = v.cooldown,
                items = v.items
            }
        end
    end
end



local farmingNotification = false
Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        if nearFarmingSpot() then
            local obj = nearFarmingSpot()
            if farmingNotification == false then
                farmingNotification = true
                sendFarmNotify(obj.name)

            end
            if IsControlJustPressed(0, 38) then
                if amfarmen then

                    amfarmen = false
                    cooldown = true
                    sendStopNotify()
                    ClearPedTasksImmediately(PlayerPedId())
                    Citizen.Wait(Config.WarteZeit)
                    cooldown = false

                else
                    if not cooldown then
                        amfarmen = true
                        anim()
                        sendStartNotify()
                        startFarming(obj)
                    end
                end
            end
        else
            farmingNotification = false
        end
    end
end)
function startFarming(obj)
    Citizen.CreateThread(function ()
        while amfarmen do
            Citizen.Wait(obj.cooldowni)
            TriggerServerEvent('farmingProcess', obj.itemNeeded, obj.items)
        end
    end)

end

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        if amfarmen then
            DisableAllControlActions(0)
            EnableControlAction(0, 18, true)
            EnableControlAction(0, 177, true)
            EnableControlAction(0, 174, true)
            EnableControlAction(0, 175, true)
            EnableControlAction(0, 27, true)
            EnableControlAction(0, 173, true)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 38, true)
            EnableControlAction(0, 2, true)
            EnableControlAction(0, 73, true)
            EnableControlAction(0, 288, true)
            EnableControlAction(0, 289, true)
            EnableControlAction(0, 245, true)
            EnableControlAction(0, 249, true)
        else
            EnableAllControlActions(0)
        end
    end
end)

RegisterNetEvent('notNeeded')
AddEventHandler('notNeeded', function(name)
    notNeededItem(name)
end)--]]


function anim()
    local ped = PlayerPedId()
    local AnimationLib = 'anim@mp_snowball'
    local AnimationStatus = 'pickup_snowball'

    startAnim(AnimationLib, AnimationStatus)
end