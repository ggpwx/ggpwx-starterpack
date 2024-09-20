QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('starterpack:server:giveStarterPack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Cek dan berikan item starter pack
    for _, item in pairs(Config.StarterItems) do
        local itemInfo = QBCore.Shared.Items[item.item:lower()]
        if itemInfo then
            Player.Functions.AddItem(item.item, item.count)
            TriggerClientEvent('inventory:client:ItemBox', src, itemInfo, "add")
        else
            print('Item '..item.item..' not found in shared items.')
        end
    end

    -- Berikan uang kepada pemain
    Player.Functions.AddMoney('cash', Config.CashAmount)
    Player.Functions.AddMoney('bank', Config.BankAmount)

    -- Spawn kendaraan untuk pemain
    TriggerClientEvent('starterpack:client:spawnVehicle', src, Player.PlayerData.citizenid)

    -- Simpan klaim starter pack ke database
    MySQL.Async.execute('INSERT INTO '..Config.ClaimTable..' (citizenid) VALUES (@citizenid)', {
        ['@citizenid'] = Player.PlayerData.citizenid
    })

    -- Log ke Discord
    TriggerEvent('starterpack:server:logToDiscord', Player.PlayerData.name .. " claimed their starter pack.")

    -- Tambahkan item ke inventory jika menggunakan ox_inventory
    if exports['ox_inventory'] then
        for _, item in pairs(Config.StarterItems) do
            exports['ox_inventory']:AddItem(src, item.item, item.count)
            TriggerClientEvent('ox_inventory:notify', src, 'Item added', item.item, item.count)
        end
        exports['ox_inventory']:AddMoney(src, 'cash', Config.CashAmount)
        exports['ox_inventory']:AddMoney(src, 'bank', Config.BankAmount)
    end
end)

RegisterNetEvent('starterpack:server:giveVehicleKey', function(plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        TriggerEvent('qb-vehiclekeys:addKey', plate, Player.PlayerData.citizenid)
    end
end)

QBCore.Functions.CreateCallback('starterpack:server:canClaim', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    MySQL.Async.fetchScalar('SELECT 1 FROM '..Config.ClaimTable..' WHERE citizenid = @citizenid', {
        ['@citizenid'] = Player.PlayerData.citizenid
    }, function(result)
        cb(result == nil) 
    end)
end)

RegisterNetEvent('starterpack:server:logToDiscord', function(message)
    local webhook = Config.DiscordWebhook
    if webhook and webhook ~= '' then
        PerformHttpRequest(webhook, function() end, 'POST', json.encode({
            username = 'Starter Pack',
            embeds = { {
                color = 65280,
                title = 'Starter Pack Claimed',
                description = message,
                footer = { text = os.date('%Y-%m-%d %H:%M:%S') }
            } },
        }), { ['Content-Type'] = 'application/json' })
    end
end)
