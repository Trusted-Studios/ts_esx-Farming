 -- ════════════════════════════════════════════════════════ --
----                                                        ---- 
----                 Script by GMW                          ----
----                                                        ---- 
 -- ════════════════════════════════════════════════════════ --

ESX = nil 

Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end)

print("Script:         esx_GMW-Tour\r\nGescripted von: German. Warthog\r\nStatus:         gestarted")

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Variablen 
-- ════════════════════════════════════════════════════════════════════════════════════ --

local MenuPosition = Config.MenuPosition

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Blips 
-- ════════════════════════════════════════════════════════════════════════════════════ --

Citizen.CreateThread(function()
    if Config.BlipEnable == "true" then
        for k, v in pairs(Config.Farm.Type) do 
            local blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(blip, v.BlipNumber)
            SetBlipScale (blip, 0.7)
            SetBlipColour(blip, 0)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.BlipLabel)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Farmen
-- ════════════════════════════════════════════════════════════════════════════════════ --

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        for k, v in pairs(Config.Farm.Type) do 
            local playerPed = PlayerPedId()
            local playercoords = GetEntityCoords(playerPed)
            local distance = Vdist(playercoords, v.x, v.y, v.z)
            if distance < 12 then 
                ShowHelp("Drücke ~INPUT_CONTEXT~ um ~y~" ..v.Label.. "~w~ zu farmen", true)
                if IsControlJustPressed(0, 38) then -- [E]
                    notify("Du sammelts jetzt ~y~" ..v.Count.. "~w~ " ..v.Label)
                    local ped = PlayerPedId(-1)
                    TaskStartScenarioInPlace(ped, v.Anim, 0, true)
                    Citizen.Wait(v.Time)
                    ClearPedTasksImmediately(ped)
                    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    PlaySoundFrontend(-1, "MEDAL_GOLD", "HUD_AWARDS", 0);
                    --notify("Du hast " ..v.Count.. " ~g~" ..v.Label.. "~w~ Gesammelt")
                    local item = v.Value 
                    local count = v.Count
                    TriggerServerEvent("gmw_farm:giveItem", item, count)
                end 
            end
        end
    end
end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Verkäufer (RageUI)
-- ════════════════════════════════════════════════════════════════════════════════════ --

rightPosition = {x = 1450, y = 0}
leftPosition = {x = 0, y = 0}
menuPosition = {x = 0, y = 0}
if MenuPosition then
    if MenuPosition == "left" then
        menuPosition = leftPosition
    elseif MenuPosition == "right" then
        menuPosition = rightPosition
    end
end

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    while not HasModelLoaded(hash) do 
        RequestModel(model)
        Citizen.Wait(20)
    end 
    for k, v in pairs(Config.Shop.Pos) do 
        ped = CreatePed("PED_TYPE_CIVMALE", "mp_m_shopkeep_01", v.x, v.y, v.z - 1, v.a, false, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
    end
end)

RMenu.Add('gmw_menu', 'main', RageUI.CreateMenu("Items verkaufen", "~b~Verkaufe deine Items", menuPosition["x"], menuPosition["y"]))
RMenu.Add('gmw_menu', 'verkauf', RageUI.CreateSubMenu(RMenu:Get('gmw_menu', 'main'), "Verkaufen", "~b~Verkaufe Items", menuPosition["x"], menuPosition["y"]))

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        RageUI.IsVisible(RMenu:Get('gmw_menu', 'main'), true, true, true, function()
            RageUI.ButtonWithStyle("Items Verkaufen", "~b~Verkaufe Items", {RightLabel = "→→→"}, true, function() end, RMenu:Get('gmw_menu', 'verkauf'))
        end, function()
        end)
        RageUI.IsVisible(RMenu:Get("gmw_menu", 'verkauf'), true, true, true, function()
            for k, v in pairs(Config.Shop.Items) do 
                RageUI.ButtonWithStyle(v.Label, "Item Verkaufen", {RightLabel = "Preis: ~g~"..v.Price.."$~w~ / ~g~Item"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        RageUI.CloseAll()
                        local ItemValue = v.Value 
                        local ItemLabel = v.Label
                        local ItemPrice = v.Price
                        anim()
                        TriggerServerEvent('gmw_sell:SellItem', ItemValue, ItemPrice, ItemLabel)
                        print(ItemValue, ItemPrice)
                    end
                end)
            end
        end, function()
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) 
        for k, v in pairs(Config.Shop.Pos) do  
            local playerPed = PlayerPedId()
            local playercoords = GetEntityCoords(playerPed)
            local distance = Vdist(playercoords, v.x, v.y, v.z)
            if distance < 8 then 
                DrawMarker(1, v.x - 0.2, v.y - 0.8, v.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.5, 0, 191, 255, 100, false, true, 2, false, nil, nil, false)
                if distance < 3.0 then 
                    ShowHelp("Drücke ~INPUT_CONTEXT~ um mit dem ~y~Käufer~w~ zu interagieren", true)
                    if IsControlJustReleased(0, 38) then -- [E]
                        if distance < 3.0 then
                            RageUI.Visible(RMenu:Get('gmw_menu', 'main'), not RageUI.Visible(RMenu:Get('gmw_menu', 'main')))
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.Shop.Pos) do 
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 280)
		SetBlipScale (blip, 1.0)
		SetBlipColour(blip, 0)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(v.BlipLabel)
		EndTextCommandSetBlipName(blip)
    end
end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- functions 
-- ════════════════════════════════════════════════════════════════════════════════════ --

-- notification
function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

-- Left corner help message
function ShowHelp(text, bleep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, -1)
end

-- Play Animation 
function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end
	end
end

-- Dialog
function CreateDialog(OnScreenDisplayTitle_shopmenu) --general OnScreenDisplay for KeyboardInput
	AddTextEntry(OnScreenDisplayTitle_shopmenu, OnScreenDisplayTitle_shopmenu)
	DisplayOnscreenKeyboard(1, OnScreenDisplayTitle_shopmenu, "", "", "", "", "", 32)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
	    result = GetOnscreenKeyboardResult()
	end
end

-- anim 
function anim()
	RequestAnimDict("random@atmrobberygen")
	while (not HasAnimDictLoaded("random@atmrobberygen")) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), "random@atmrobberygen", "a_atm_mugging", 8.0, 3.0, 2000, 0, 1, false, false, false)
end

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                          2021 © German.Warthog Development                           --
-- ════════════════════════════════════════════════════════════════════════════════════ --
