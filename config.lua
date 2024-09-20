Config = {}

-- Coordinates for the ped used to claim the starter pack
Config.PedCoords = vector4(-1036.28, -2734.32, 20.17, 162.71) -- Adjust to desired location
Config.PedModel = 'u_m_m_jewelsec_01' -- Ped model

-- Coordinates for the vehicle to be spawned
Config.VehicleSpawnCoords = vector4(-1040.59, -2724.94, 20.13, 243.63)
Config.VehicleModel = 'adder' -- Vehicle model

-- Items given to the player
Config.StarterItems = {
    { item = 'water_bottle', count = 10 },
    { item = 'sandwich', count = 10 },
    { item = 'phone', count = 1 },
}

-- Amount of money given
Config.CashAmount = 1000 -- Cash amount
Config.BankAmount = 10000 -- Bank amount

-- Discord logging configuration
Config.DiscordWebhook = 'https://discord.com/api/webhooks/1284349336179703828/MjHRcV_tlc5QnxK6CwxZYxzAcUg5antf6fuuINDr-2a9qNngYzCSyleXpmnuDdoqqmd5'

-- Database table
Config.ClaimTable = 'player_starterpacks' -- Table to check if the player has already claimed the starter pack

-- Target System
Config.TargetSystem = 'qb-target' -- Options: 'qb-target', 'ox-target'

-- Inventory System
Config.InventorySystem = 'qb-inventory' -- Options: 'qb-inventory', 'ox_inventory'
