QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    RequestModel(GetHashKey(Config.PedModel))
    while not HasModelLoaded(GetHashKey(Config.PedModel)) do
        Wait(500)
    end

    local spawnedPed = CreatePed(4, GetHashKey(Config.PedModel), Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 1.0, Config.PedCoords.w, false, true)
    FreezeEntityPosition(spawnedPed, true)
    SetEntityInvincible(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)
    if Config.TargetSystem == 'qb-target' and exports['qb-target'] then
        exports['qb-target']:AddTargetEntity(spawnedPed, {
            options = {
                {
                    type = "client",
                    event = "starterpack:client:claimStarterpack",
                    icon = "fas fa-box-open",
                    label = "Claim Starter Pack",
                },
            },
            distance = 2.5
        })
    elseif Config.TargetSystem == 'ox_target' and exports['ox_target'] then
        exports['ox_target']:AddTargetEntity(spawnedPed, {
            {
                name = "claimStarterpack",
                icon = "fas fa-box-open",
                label = "Claim Starter Pack",
                onSelect = function()
                    TriggerEvent('starterpack:client:claimStarterpack')
                end,
                distance = 2.5
            }
        })
    else
        print("Target system not configured or missing dependencies.")
    end
end)


RegisterNetEvent('starterpack:client:claimStarterpack', function()
    QBCore.Functions.TriggerCallback('starterpack:server:canClaim', function(canClaim)
        if canClaim then
            QBCore.Functions.Progressbar('claiming_starterpack', 'Claiming Starter Pack...', 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                TriggerServerEvent('starterpack:server:giveStarterPack')
            end)
            
            local ped = PlayerPedId()
            local animDict = "mp_common"
            local animName = "givetake1_a"
            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Wait(500)
            end

            TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
            Citizen.Wait(5000)
            ClearPedTasks(ped)
        else
            QBCore.Functions.Notify('You have already claimed your starter pack.', 'error')
        end
    end)
end)

RegisterNetEvent('starterpack:client:spawnVehicle')
AddEventHandler('starterpack:client:spawnVehicle', function(citizenid)
    local vehicleModel = Config.VehicleModel
    local vehicleHash = GetHashKey(vehicleModel)
    local coords = Config.VehicleSpawnCoords

    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
        Wait(500)
    end

    local vehicle = CreateVehicle(vehicleHash, coords.x, coords.y, coords.z, coords.w, true, false)
    if DoesEntityExist(vehicle) then
        print('Vehicle spawned successfully')
        local plate = QBCore.Functions.GetPlate(vehicle)
        SetVehicleNumberPlateText(vehicle, plate)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        TriggerServerEvent('starterpack:server:giveVehicleKey', plate)
        TriggerEvent('qb-vehiclekeys:client:AddKeys', plate)
    else
        print('Failed to spawn vehicle. The model may be invalid or the coordinates are incorrect.')
    end
end)
