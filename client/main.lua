---@diagnostic disable: missing-parameter, param-type-mismatch, trailing-space
-- ════════════════════════════════════════════════════════════════════════════════════ --
-- ESX Shared 
-- ════════════════════════════════════════════════════════════════════════════════════ --

ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("^6[CLIENT - DEBUG] ^0: "..filename()..".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

local MenuPosition = Config.MenuPosition

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Blips 
-- ════════════════════════════════════════════════════════════════════════════════════ --

Citizen.CreateThread(function()
    if Config.BlipEnable == "true" then
        for k, v in pairs(Config.Farm.Type) do 
            local x, y, z = table.unpack(v.coords)
            local blip = AddBlipForCoord(x, y, z)
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
            local x, y, z = table.unpack(v.coords)
            local distance = Vdist(playercoords, x, y, z)
            if distance < 12 then 
                ShowHelp("Drücke ~INPUT_CONTEXT~ um ~y~" ..v.Label.. "~w~ zu farmen", true)
                if IsControlJustPressed(0, 38) then
                    Notify("Du sammelts jetzt ~y~" ..v.Count.. "~w~ " ..v.Label)
                    local ped = PlayerPedId()
                    TaskStartScenarioInPlace(ped, v.Anim, 0, true)
                    Citizen.Wait(v.Time)
                    ClearPedTasksImmediately(ped)
                    PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                    PlaySoundFrontend(-1, "MEDAL_GOLD", "HUD_AWARDS", 0);
                    Notify("Du hast " ..v.Count.. " ~g~" ..v.Label.. "~w~ Gesammelt")
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

local rightPosition = {x = 1450, y = 0}
local leftPosition = {x = 0, y = 0}
local menuPosition = {x = 0, y = 0}

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
        RequestModel(hash)
        Citizen.Wait(20)
    end 
    for k, v in pairs(Config.Shop.Pos) do 
        local x, y, z, h = table.unpack(v.Coords)
        local ped <const> = CreatePed(-1, "mp_m_shopkeep_01", x, y, z - 1, h, false, true)
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
        end)
        RageUI.IsVisible(RMenu:Get("gmw_menu", 'verkauf'), true, true, true, function()
            for k, v in pairs(Config.Shop.Items) do 
                RageUI.ButtonWithStyle(v.Label, "Item Verkaufen", {RightLabel = "Preis: ~g~"..v.Price.."$~w~ / ~g~Item"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        RageUI.CloseAll()
                        local ItemValue = v.Value 
                        local ItemLabel = v.Label
                        local ItemPrice = v.Price
                        Anim()
                        TriggerServerEvent('gmw_sell:SellItem', ItemValue, ItemPrice, ItemLabel)
                    end
                end)
            end
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) 
        for k, v in pairs(Config.Shop.Pos) do  
            local playerPed = PlayerPedId()
            local playercoords = GetEntityCoords(playerPed)
            local x, y, z = table.unpack(v.Coords)
            local distance = Vdist(playercoords, x, y, z)
            if distance < 8 then 
                DrawMarker(1, x - 0.2, y - 0.8, z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.5, 0, 191, 255, 100, false, true, 2, false, nil, nil, false)
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
        local x, y, z = table.unpack(v.Coords)
        local blip = AddBlipForCoord(x, y, z)
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
function Notify(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringKeyboardDisplay(text)
    EndTextCommandThefeedPostTicker(true, true)
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

-- anim 
function Anim()
	RequestAnimDict("random@atmrobberygen")
	repeat Citizen.Wait(0) until HasAnimDictLoaded("random@atmrobberygen")
	TaskPlayAnim(PlayerPedId(), "random@atmrobberygen", "a_atm_mugging", 8.0, 3.0, 2000, 0, 1, false, false, false)
end

-- ════════════════════════════════════════════════════════════════════════════════════ --
--                          2023 © German.Warthog Development                           --
-- ════════════════════════════════════════════════════════════════════════════════════ --
