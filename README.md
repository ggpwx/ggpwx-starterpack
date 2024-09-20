# ggpwx-starterpack

The `ggpwx-starterpack` script for FiveM provides players with a starter pack that includes items, cash, and a vehicle when they interact with a specified ped.

## Features

- **Starter Pack**: Gives players items, cash, and bank money.
- **Vehicle**: Spawns a vehicle for the player.
- **Targeting**: Uses `qb-target` and `ox-target` for ped interaction.
- **Logging**: Logs claims to Discord.

## Requirements

- **QBCore**: Core framework for integration.
- **qb-target** and **ox-target**: For ped interactions.
- **qb-inventory** and **ox-inventory**: For item management.
- **MySQL**: For storing claim data.
- **Discord Webhook**: For logging.

## Setup

1. **Configuration**

   Edit `config.lua` to set up:

   ```lua
   Config = {}

   -- Ped coordinates for claiming starter pack
   Config.PedCoords = vector4(-1036.28, -2734.32, 20.17, 162.71)
   Config.PedModel = 'u_m_m_jewelsec_01'

   -- Vehicle spawn coordinates and model
   Config.VehicleSpawnCoords = vector4(-1040.59, -2724.94, 20.13, 243.63)
   Config.VehicleModel = 'adder'

   -- Items to give
   Config.StarterItems = {
       { item = 'water_bottle', count = 10 },
       { item = 'sandwich', count = 10 },
   }

   -- Money amounts
   Config.CashAmount = 500
   Config.BankAmount = 5000

   -- Discord logging
   Config.DiscordWebhook = 'https://discord.com/api/webhooks/your-webhook-url'

   -- Database table
   Config.ClaimTable = 'player_starterpacks'
