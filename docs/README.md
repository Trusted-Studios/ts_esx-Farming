![image](https://media.discordapp.net/attachments/985134187600297986/1154892454550585374/trusted-banner.png?width=1440&height=465)
<p align="center">
    <a href="https://discord.overextended.dev">
        <img src="https://img.shields.io/discord/1068573047172374634?style=for-the-badge&logo=discord&labelColor=7289da&logoColor=white&color=2c2f33&label=Discord"/>
    </a>
</p>

---

# esx_GMW-Farming

![image](https://media.discordapp.net/attachments/1115373809483133008/1115373809793503323/Screenshot_488.png?width=1246&height=701)

### Informationen: 

Das Farming Script ist ein vielseitiges Tool, das für jeden Server geeignet ist. Es bietet zahlreiche Konfigurationsoptionen, die es dem Benutzer ermöglichen, das Script an seine spezifischen Bedürfnisse anzupassen. Das Script kann für verschiedene Arten von Farming-Aktivitäten verwendet werden, wie zum Beispiel das Sammeln von Ressourcen und der darauffolgende Verkauf. Das Farming Script ist ein unverzichtbares Script für jeden, der seine Farming-Aktivitäten automatisieren und optimieren möchte.

### Konfigurationen:

> Alle Konfigurationen befinden sich in der `config.lua`. Wer der Meinung ist die Anderen Dateien zu verändern, muss damit rechnen, dass er keinen Support mehr bekommt! 

**Position des Verkaufsmenüs**

Die Position des Menüs kann entweder auf die linke oder die rechte Seite des Bildschirms eingestellt werden. Hierbei kann man in der `config` folgende Änderungen treffen: 
```lua
Config.MenuPosition = "right"  -- "right" / "left"
```

**Anzeigen der Blips**
Wenn man nicht möchte, dass die Blips auf der Karte angezeigt werden, kann man diese folgendermaßen verändern: 
```lua
Config.BlipEnable = "true" -- "true" / "false"  
```

**Farming Ortschaften**
Die Farmingortschaften werden unter `Config.Farm` eingestellt und bieten zahlreiche Konfigurationsoptionen: 

- Label - `string`
    - Text der dem Spieler angezeigt wird. 
- Value - `string`
    - Item Name aus der Datenbank (oder aus einer Item Config, zB. bei ox_inventory)
- BlipLabel - `string`
    - Text der dem Spieler angezeigt wird, wenn dieser den Blip auswählt. 
- Anim - `string`
    - Name der Animation, welche abgespielt wird, wenn ein Spieler anfängt zu farmen. Hier befinden sich [weitere Animationen](https://pastebin.com/6mrYTdQv)
- BlipNumber - `int` 
    - [Blip id.](https://pastebin.com/6mrYTdQv)
- Time - `int` 
    - Die Zeit, die für das Sammlen gebraucht wird *(in ms)*
- Count - `int`
    - Die Anzahl an Items die man bekommt. 
- coords - `vec3`
    - Koordinaten an denen gefarmt werden kann. 

> Hier ein Beispiel, wie eine Farmingortschaft aussieht: 
```lua
{Label = "Kartoffeln", Value = "kartoffel", BlipLabel = "Kartoffelfeld", Anim = "world_human_gardener_plant", BlipNumber = 208, Time = 20000, Count = 5, coords = vector3(1956.4, 4797.42, 43.62)},
```

**Verkaufsshop**
Bei dem Verkaufsshop, können die gesammelten Itens verkauft werden. Hierbei können die Position der Shops und die Items, welche verkauft werden sollen eingestellt werden. 

*Position des Shops:*

- Pos - `table`
    - Coords - `vec4`
        - Koordinaten des Shops
    - Bliplabel - `string`
        - Text der dem Spieler angezeigt wird, wenn dieser den Blip auswählt. 
- Items - `table`
    - Label - `string`
        - Name des Items, welches dem Spieler angezeigt wird. 
    - Value - `string`
        - Item Name aus der Datenbank (oder aus einer Item Config, zB. bei ox_inventory)
    - Price - `int`
        - Belohnung, die man für jedes verkaufte Item bekommt *(in $)*

> Hier ein Beispiel für die Shop Konfigurationen: 
```lua
Pos = {
    {BlipLabel = 'Händler', Coords = vec4(386.06, -326.16, 46.87, 160.01)}, 
}, 
Items = {              
    {Label = "Kartoffeln", Value = "kartoffel", Price = 8},	
}
```

---

## Weitere Scripts: 

Weitere Scripts könnt ihr auf unserem Discord finden: [Trusted Scripts](https://discord.gg/hmmM89nCdX) 

