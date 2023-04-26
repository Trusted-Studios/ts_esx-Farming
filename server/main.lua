-- ════════════════════════════════════════════════════════════════════════════════════ --
-- ESX Shared
-- ════════════════════════════════════════════════════════════════════════════════════ --

ESX = exports["es_extended"]:getSharedObject()

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("^6[SERVER - DEBUG] ^0: "..filename()..".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

RegisterServerEvent('gmw_sell:SellItem', function(item, reward, label)
    local xPlayer <const> = ESX.GetPlayerFromId(source)
    local xItem <const> = xPlayer.getInventoryItem(item)
    if not xItem then 
        print('^1[WARNUNG]^0 - Ein Fehler ist beim Abrufen eines Items aufgetreten. Stellen sie bitte sicher, dass diese existieren!')
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Ein Fehler ist aufgetreten, bitte melde dies dem Server-Team.')
        return
    end 
    if xItem.count <= 0 then 
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Es können nur Items verkauft werden, die auch in deinem Besitz sind.')
        return 
    end 
    xPlayer.removeInventoryItem(item, xItem.count)
    xPlayer.addMoney(reward * xItem.count)
    TriggerClientEvent('esx:showNotification', source, ("Du hast ~y~"..xItem.count.." x "..label.."~w~ für insgesamt ~g~"..reward.."$~w~ verkauft"))
end)

RegisterNetEvent("gmw_farm:giveItem", function(item, count)
    local xPlayer <const> = ESX.GetPlayerFromId(source) 
    if not xPlayer.canCarryItem(item, count) then 
        TriggerClientEvent('esx:showNotification', source, ("~r~Du kannst keine Items mehr sammlen!"))
        return 
    end
    xPlayer.addInventoryItem(item, count)
end) 