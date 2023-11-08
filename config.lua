-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("^6[SHARED - DEBUG] ^0: "..filename()..".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

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
        {Label = "Kartoffeln", Value = "kartoffel", BlipLabel = "Kartoffelfeld", Anim = "world_human_gardener_plant", BlipNumber = 208, Time = 20000, Count = 5, coords = vec3(1956.4, 4797.42, 43.62)},
        {Label = "Salat", Value = "salat", BlipLabel = "Salatfeld", Anim = "world_human_gardener_plant", BlipNumber = 208, Time = 20000, Count = 5, coords = vec3(2212.57, 5056.86, 46.75)},  
        {Label = "Radieschen", Value = "radieschen", BlipLabel = "Radieschenfeld", Anim = "world_human_gardener_plant", BlipNumber = 208, Time = 20000, Count = 5, coords = vec3(357.18, 6615.18, 28.77)},  
        {Label = "Zucchini", Value = "zucchini", BlipLabel = "Zucchinifeld", Anim = "world_human_gardener_plant", BlipNumber = 208, Time = 20000, Count = 5, coords = vec3(267.89, 6651.04, 29.86)},  
        {Label = "Kräuter", Value = "krauter", BlipLabel = "Kräuterfeld", Anim = "world_human_gardener_plant", BlipNumber = 208, Time = 20000, Count = 5, coords = vec3(267.53, 6611.44, 30.01)},  
        {Label = "Orangen", Value = "orangen", BlipLabel = "Orangenfeld", Anim = "world_human_gardener_plant", BlipNumber = 208, Time = 20000, Count = 5, coords = vec3(252.34, 6514.29, 30.95)},  
        {Label = "Äpfel", Value = "apfel", BlipLabel = "Apfelfeld", Anim = "world_human_gardener_plant", BlipNumber = 208, Time = 20000, Count = 5, coords = vec3(347.77, 6517.16, 28.77)},  
        {Label = "Zwiebeln", Value = "zwiebeln", BlipLabel = "Zwiebelfeld", Anim = "world_human_gardener_plant", BlipNumber = 208, Time = 20000, Count = 5, coords = vec3(510.04, 6484.34, 30.79)},
        {Label = "Steckrüben", Value = "steckruben", BlipLabel = "Steckrübenfeld", Anim = "world_human_gardener_plant", BlipNumber = 208, Time = 20000, Count = 5, coords = vec3(659.9, 6474.57, 30.37)},
    }
}
 
-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Shop Configuration 
-- ════════════════════════════════════════════════════════════════════════════════════ --
 
Config.Shop = {
    Pos = {
        {BlipLabel = 'Händler', Coords = vec4(386.06, -326.16, 46.87,160.01)}, 
    }, 
    Items = {              
        {Label = "Kartoffeln", Value = "kartoffel", Price = 8},	
        {Label = "Salat", Value = "salat", Price = 8},
        {Label = "Radieschen", Value = "radieschen", Price = 8},
        {Label = "Zucchini", Value = "zucchini", Price = 8},
        {Label = "Kräuter", Value = "krauter", Price = 8},
        {Label = "Orangen", Value = "orangen", Price = 8},
        {Label = "Äpfel", Value = "apfel", Price = 8},
        {Label = "Zwiebeln", Value = "zwiebeln", Price = 8},
        {Label = "Steckrüben", Value = "steckruben", Price = 8},
        {Label = "Spagel", Value = "spagel", Price = 8},
        {Label = "Sellerie", Value = "sellerie", Price = 8},
        {Label = "Weizen", Value = "weizen", Price = 8},
        {Label = "Gerste", Value = "gerste", Price = 8},
        {Label = "Hafer", Value = "hafer", Price = 8},
        {Label = "Gurke", Value = "gurke", Price = 8},
        {Label = "Ananas", Value = "ananas", Price = 8},
        {Label = "Pfirsich", Value = "pfirsich", Price = 8},
    }
}
