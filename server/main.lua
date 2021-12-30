ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('farmingProcess')
AddEventHandler('farmingProcess', function (need,give)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    print(need)
    if need == "none" then
        for k,v in pairs(give) do
            local currentItem = xPlayer.getInventoryItem(v.item)
            if currentItem then
                xPlayer.addInventoryItem(v.item, v.count)
            else
                print('['..GetCurrentResourceName().. '] ERROR! Es gibt das Item "' ..v.item.. '" nicht!')
            end
        end  
        return
    end
    local neededItem = xPlayer.getInventoryItem(need)
    if neededItem then
        if neededItem.count > 0 then
            for k,v in pairs(give) do
                local currentItem = xPlayer.getInventoryItem(v.item)
                if currentItem then
                        xPlayer.addInventoryItem(v.item, v.count)
                else
                    print('['..GetCurrentResourceName().. '] ERROR! Es gibt das Item "' ..v.item.. '" nicht!')
                end
            end
        else
            xPlayer.triggerEvent('notNeeded', xPlayer.getInventoryItem(need).label)
        end
    else    
        print('['..GetCurrentResourceName().. '] ERROR! Es gibt das Item "' ..need.. '" nicht!')
    end

end)