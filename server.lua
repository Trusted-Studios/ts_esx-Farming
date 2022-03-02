ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                              		Item Farmen 
-- ════════════════════════════════════════════════════════════════════════════════════ --

RegisterServerEvent('gmw_farm:giveItem')
AddEventHandler('gmw_farm:giveItem', function(item, ItemCount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, ItemCount)
    TriggerClientEvent('esx:showNotification', source, "~g~Items wurden erfolgreich gesammlt")
end) 


-- ════════════════════════════════════════════════════════════════════════════════════ --
--                              	Verkauf der Items
-- ════════════════════════════════════════════════════════════════════════════════════ --

RegisterServerEvent('gmw_sell:SellItem')
AddEventHandler('gmw_sell:SellItem', function(ItemValue, ItemPrice, ItemLabel)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local v = 0
    for i = 1, #xPlayer.inventory, 1 do
        local item = xPlayer.inventory[i]
        if item.name == ItemValue then
            v = item.count
        end
    end
    if v > 0 then
		local ItemPrice = v * ItemPrice
		xPlayer.removeInventoryItem(ItemValue, v)
		xPlayer.addMoney(ItemPrice)
		TriggerClientEvent('esx:showNotification', source, ("Du hast ~y~"..v.." x "..ItemLabel.."~w~ für insgesamt ~g~"..ItemPrice.."$~w~ verkauft"))
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Sie können nur Items verkaufen, die Sie besitzen.')
    end
end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- functions 
-- ════════════════════════════════════════════════════════════════════════════════════ --

function DoesItemExist()
	local xPlayer = ESX.GetPlayerFromId(source)
	local haveItem = false
	for i, v in ipairs(Config.Shop.Items) do
		if xPlayer.getInventoryItem(v.item).count > 0 then 
			haveItem = true 
		end
	end
	if haveItem then return true else return false end
end
