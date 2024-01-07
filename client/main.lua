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
print("^6[CLIENT - DEBUG] ^0: "..filename()..".lua started");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

local MenuPosition = Config.MenuPosition

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Blips 
-- ════════════════════════════════════════════════════════════════════════════════════ --

CreateThread(function()
    if Config.EnableBlip == true then
        for k, v in pairs(Config.Farm.Type) do 
            local x, y, z = table.unpack(v.coords)

            AddBlip(x, y, z, v.BlipNumber, 0.7, 0, v.BlipLabel)
        end
    end
end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Farmen
-- ════════════════════════════════════════════════════════════════════════════════════ --

CreateThread(function()
    local isNearPoint = false
    while true do 
        Wait(0)
        for index, v in pairs(Config.Farm.Type) do 
            
            local ped = PlayerPedId()
            local playerCoords = GetEntityCoords(ped)
            local x, y, z = table.unpack(v.coords)
            local distance = Vdist(playerCoords, x, y, z)

            if distance > 12 then 
                goto continue
            end

            isNearPoint = true
            
            ShowHelp("Drücke ~INPUT_CONTEXT~ um ~y~" ..v.Label.. "~w~ zu farmen", true)
            
            if IsControlJustPressed(0, 38) then
                local item = v.Value
                local itemLabel = v.Label
                local count = v.Count

                Notify("Du sammelts jetzt ~y~" ..count.. "~w~ " ..itemLabel)
                
                TaskStartScenarioInPlace(ped, v.Anim, 0, true)
                Wait(v.Time)
                ClearPedTasksImmediately(ped)
                
                PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
                PlaySoundFrontend(-1, "MEDAL_GOLD", "HUD_AWARDS", 0);
                
                Notify("Du hast " ..count.. " ~g~" ..itemLabel.. "~w~ Gesammelt")
                
                TriggerServerEvent("gmw_farm:giveItem", item, count)
            end 

            if isNearPoint then
                break
            end
            
            ::continue::
        end

        if not isNearPoint then 
            Wait(1500)
        end

        isNearPoint = false
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

CreateThread(function()
    local hash = GetHashKey("mp_m_shopkeep_01")
    
    while not HasModelLoaded(hash) do 
        RequestModel(hash)
        Wait(20)
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

CreateThread(function()
    while true do 
        Wait(0)

        if not RageUI.Visible(RMenu:Get('gmw_menu', 'main')) and not RageUI.Visible(RMenu:Get('gmw_menu', 'verkauf')) then 
            Wait(250)
            goto continue
        end

        RageUI.IsVisible(RMenu:Get('gmw_menu', 'main'), true, true, true, function()
            RageUI.ButtonWithStyle("Items Verkaufen", "~b~Verkaufe Items", {RightLabel = "→→→"}, true, function() end, RMenu:Get('gmw_menu', 'verkauf'))
        end)

        RageUI.IsVisible(RMenu:Get("gmw_menu", 'verkauf'), true, true, true, function()
            for k, v in pairs(Config.Shop.Items) do 
                RageUI.ButtonWithStyle(v.Label, "Item Verkaufen", {RightLabel = "Preis: ~g~"..v.Price.."$~w~ / ~g~Item"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        RageUI.CloseAll()
                        Anim()
                        TriggerServerEvent('gmw_sell:SellItem', v.Value, v.Price, v.Label)
                    end
                end)
            end
        end)

        ::continue::
    end
end)

CreateThread(function()
    local isNearPoint = false
    while true do 
        Wait(0)
        for index, v in pairs(Config.Shop.Pos) do 
            
            local ped = PlayerPedId()
            local playerCoords = GetEntityCoords(ped)
            local x, y, z = table.unpack(v.Coords)
            local distance = Vdist(playerCoords, x, y, z)

            if distance > 12 then 
                goto continue
            end

            isNearPoint = true
            
            DrawMarker(1, x - 0.2, y - 0.8, z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.5, 0, 191, 255, 100, false, true, 2, false, nil, nil, false)
            
            if distance < 3 then 
                ShowHelp("Drücke ~INPUT_CONTEXT~ um mit dem ~y~Käufer~w~ zu interagieren", true)
                if IsControlJustReleased(0, 38) then -- [E]
                    RageUI.Visible(RMenu:Get('gmw_menu', 'main'), not RageUI.Visible(RMenu:Get('gmw_menu', 'main')))
                end
            end

            if isNearPoint then
                break
            end
            
            ::continue::
        end

        if not isNearPoint then 
            Wait(1500)
        end

        isNearPoint = false

    end
end)

CreateThread(function()
    for k, v in pairs(Config.Shop.Pos) do 
        local x, y, z = table.unpack(v.Coords)
        AddBlip(x, y, z, 280, 1.0, 0, v.BlipLabel)
    end
end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- functions 
-- ════════════════════════════════════════════════════════════════════════════════════ --

--- Displays a notifcation
---@param text string
function Notify(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringKeyboardDisplay(text)
    EndTextCommandThefeedPostTicker(true, true)
end

--- Displays the native help notification on the top-left side of the screen
---@param text string
---@param bleep boolean
function ShowHelp(text, bleep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, -1)
end

--- Loads animation dictionary
---@param dict string
function LoadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Wait(1)
		end
	end
end

--- Plays the farming animation 
function Anim()
	RequestAnimDict("random@atmrobberygen")
	repeat Wait(0) until HasAnimDictLoaded("random@atmrobberygen")
	TaskPlayAnim(PlayerPedId(), "random@atmrobberygen", "a_atm_mugging", 8.0, 3.0, 2000, 0, 1, false, false, false)
end

--- Adds a Blip
---@param x number
---@param y number
---@param z number
---@param id number
---@param scale number
---@param colour number
---@param label string
function AddBlip(x, y, z, id, scale, colour, label)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, id)
    SetBlipScale (blip, scale)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)
end