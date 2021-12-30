Config = {}

Config.InteractKey = 38 --E = 38
Config.WarteZeit = 15000 --Wie lange muss man warten um wieder farmen zu können?

Config.Farming = {
    {
        display = "Brot",
        position = vector3(774.0208, -236.1790, 66.1143), --Position
        radius = 20, -- Radius
        cooldown = 5000, -- Cooldown (Alle xy kriegt er die Items von unten)
        itemNeeded = "none", -- Item was benötigt wird ("none" = keins)
        items = { --Was wird dem Spieler gegeben?
            {
                item = "bread", --welches Item?
                count = 1 --wie oft?
            },
            --[[
            {
                item = "weed",
                count = 3
            }
            --]]
        }
    }
}


function sendFarmNotify(item) --Notification um das Farmen anzufangen
    TriggerEvent('notifications', "black", item, "Benutze E um zu Farmen")
end

function sendStartNotify()
    TriggerEvent('notifications', "black", "", "Farmen gestartet.")
end

function sendStopNotify()
    TriggerEvent('notifications', "black", "", "Farmen gestoppt.") 
end

function notNeededItem(name)
    TriggerEvent('notifications', "red", "", "Du benötigst " ..name.. " um zu Farmen.")
end