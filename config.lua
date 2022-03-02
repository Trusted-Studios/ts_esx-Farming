-- ════════════════════════════════════════════════════════ --
----                                                        ---- 
----                 Script by GMW                          ----
----                                                        ---- 
-- ════════════════════════════════════════════════════════ --

Config = {}

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Menu und Blip Configuration 
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config.MenuPosition = "right"  -- "right" / "left"
Config.BlipEnable = "true" -- "true" / "false"  

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Farm Configuration  
-- ════════════════════════════════════════════════════════════════════════════════════ --
 
Config.Farm = {
    Type = {
        {Label = "Kartoffeln", Value = "kartoffel", BlipLabel = "Kartoffelfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 1956.4, y = 4797.42, z = 43.62, },
        {Label = "Salat", Value = "salat", BlipLabel = "Salatfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 2212.57, y = 5056.86, z = 46.75, },  
        {Label = "Radieschen", Value = "radieschen", BlipLabel = "Radieschenfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 357.18, y = 6615.18, z = 28.77, },  
        {Label = "Zucchini", Value = "zucchini", BlipLabel = "Zucchinifeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 267.89, y = 6651.04, z = 29.86, },  
        {Label = "Kräuter", Value = "krauter", BlipLabel = "Kräuterfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 267.53, y = 6611.44, z = 30.01, },  
        {Label = "Orangen", Value = "orangen", BlipLabel = "Orangenfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 252.34, y = 6514.29, z = 30.95, },  
        {Label = "Äpfel", Value = "apfel", BlipLabel = "Apfelfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 347.77, y = 6517.16, z = 28.77, },  
        {Label = "Zwiebeln", Value = "zwiebeln", BlipLabel = "Zwiebelfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 510.04, y = 6484.34, z = 30.79, },
        {Label = "Steckrüben", Value = "steckruben", BlipLabel = "Steckrübenfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 659.9, y = 6474.57, z = 30.37, },
        {Label = "Spagel", Value = "spagel", BlipLabel = "Spagelfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 537.27, y = 6604.89, z = 19.53, },  
        {Label = "Sellerie", Value = "sellerie", BlipLabel = "Selleriefeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 2525.56, y = 4363.64, z = 39.57, },  
        {Label = "Weizen", Value = "weizen", BlipLabel = "Weizenfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 2602.18, y = 4396.64, z = 41.15, },  
        {Label = "Gerste", Value = "gerste", BlipLabel = "Gerstenfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 2641.97, y = 4462.97, z = 40.21, },  
        {Label = "Hafer", Value = "hafer", BlipLabel = "Haferfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 2672.92, y = 4543.33, z = 40.54, },  
        {Label = "Gurke", Value = "gurke", BlipLabel = "Gurkenfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 2641.83, y = 4697.54, z = 35.47, },  
        {Label = "Ananas", Value = "ananas", BlipLabel = "Ananasfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 2859.44, y = 4590.05, z = 47.68, },  
        {Label = "Pfirsich", Value = "pfirsich", BlipLabel = "Pfirsichfeld", Anim = "world_human_gardener_plant",BlipNumber = 208, Time = 20000, Count = 5, x = 2847.45, y = 4728.96, z = 47.46, },  

    }
}
 
-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Shop Configuration 
-- ════════════════════════════════════════════════════════════════════════════════════ --
 
Config.Shop = {
    Pos = {
        {x = 386.06, y = -326.16, z = 46.87, a = 160.01, BlipLabel = "Händler"}
    }, 
 
    Items = {              
        { Label = "Kartoffeln", Value = "kartoffel", Price = 8},	
        { Label = "Salat", Value = "salat", Price = 8},
        { Label = "Radieschen", Value = "radieschen", Price = 8},
        { Label = "Zucchini", Value = "zucchini", Price = 8},
        { Label = "Kräuter", Value = "krauter", Price = 8},
        { Label = "Orangen", Value = "orangen", Price = 8},
        { Label = "Äpfel", Value = "apfel", Price = 8},
        { Label = "Zwiebeln", Value = "zwiebeln", Price = 8},
        { Label = "Steckrüben", Value = "steckruben", Price = 8},
        { Label = "Spagel", Value = "spagel", Price = 8},
        { Label = "Sellerie", Value = "sellerie", Price = 8},
        { Label = "Weizen", Value = "weizen", Price = 8},
        { Label = "Gerste", Value = "gerste", Price = 8},
        { Label = "Hafer", Value = "hafer", Price = 8},
        { Label = "Gurke", Value = "gurke", Price = 8},
        { Label = "Ananas", Value = "ananas", Price = 8},
        { Label = "Pfirsich", Value = "pfirsich", Price = 8},
    }
}
 
 
 
-- ════════════════════════════════════════════════════════════════════════════════════ --
--                              WICHTIGE INFORMATIONEN 
-- ════════════════════════════════════════════════════════════════════════════════════ --

--[[
    
SQL Code um ein Item hinzuzufügen

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('', '', , 0, 1) -- Itemname, Itemlabel, Itemlimit, 0, 1 -- 
;
-------------------------------------------------------------------------------

Blip Nummer ändern | https://docs.fivem.net/docs/game-references/blips/ |
Animation ändern | https://pastebin.com/6mrYTdQv | 

-------------------------------------------------------------------------------

Sollte man nur bei einem Blip nicht wollen, dass dieser angezeigt wird muss man als BlipNumber -0 eintragen!

]]--
-------------------------------------------------------------------------------


-- ════════════════════════════════════════════════════════════════════════════════════ --
--                          2021 © German.Warthog Development                           --
-- ════════════════════════════════════════════════════════════════════════════════════ --