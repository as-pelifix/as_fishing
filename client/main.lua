local ESX = exports["es_extended"]:getSharedObject()
local isFishing = false
local currentRod = nil
local activeRodObj = nil

local function debugPrint(msg)
    if Config.Debug then print("^2[Fishing Debug] ^7" .. msg) end
end

function GetCurrentZone()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    if IsPedInAnyVehicle(ped, false) then
        return nil, Config.Lang['no_vehicle_fishing']
    end

    if IsPedSwimming(ped) or IsPedSwimmingUnderWater(ped) then
        return nil, Config.Lang['no_svim_fishing']
    end

    for name, data in pairs(Config.FishingZones) do
        local zone = lib.zones.box({
            coords = data.coords,
            size = data.size,
            rotation = data.rotation
        })
        if zone:contains(coords) then return 'zone' end
    end
    
    local veh = GetVehiclePedIsUsing(ped)
    if veh ~= 0 and GetVehicleClass(veh) == 14 then
        debugPrint("Player is on boat.")
        return 'normal'
    end

    local water, waterZ = GetWaterHeight(coords.x, coords.y, coords.z)
    if water then
        local _, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, 0)
        local depth = waterZ - groundZ
        debugPrint("Vanddybde: " .. depth)
        if depth >= Config.Depth then return 'deep' end
        return 'normal'
    end

    return nil, Config.Lang['no_zone_found']
end

function GetPlayerRod()
    local rodTypes = {'rare_rod', 'medium_rod', 'normal_rod'}
    for _, rodName in ipairs(rodTypes) do
        local count = exports.ox_inventory:Search('count', rodName)
        if count and count > 0 then 
            debugPrint("Using rod: " .. rodName)
            return rodName, Config.Rods[rodName] 
        end
    end
    return nil, nil
end

function StopFishing()
    isFishing = false
    lib.hideTextUI()
    local ped = PlayerPedId()
    
    if activeRodObj and DoesEntityExist(activeRodObj) then 
        DetachEntity(activeRodObj, true, true)
        DeleteEntity(activeRodObj) 
        activeRodObj = nil
    end

    ClearPedTasksImmediately(ped)
    StopAnimTask(ped, 'amb@world_human_stand_fishing@idle_a', 'idle_b', 1.0)
    
    debugPrint("Fishing stoppet.")
end

RegisterNetEvent('as_fishing:start')
AddEventHandler('as_fishing:start', function()
    if isFishing then 
        StopFishing() 
        return 
    end
    
    local ped = PlayerPedId()
    
    local zoneType, errorMsg = GetCurrentZone()
    if not zoneType then
        return lib.notify({description = errorMsg, type = 'error'})
    end

    local rodName, rodData = GetPlayerRod()
    if not rodName then
        return lib.notify({description = Config.Lang['no_rod'], type = 'error'})
    end

    currentRod = rodData
    isFishing = true
    StartFishingCycle(zoneType)
end)

function StartFishingCycle(zoneType)
    local ped = PlayerPedId()
    
    lib.requestAnimDict('amb@world_human_stand_fishing@idle_a')
    TaskPlayAnim(ped, 'amb@world_human_stand_fishing@idle_a', 'idle_b', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
    
    local boneIndex = GetPedBoneIndex(ped, 60309)
    activeRodObj = CreateObject(`prop_fishing_rod_01`, GetEntityCoords(ped), true, false, false)
    AttachEntityToEntity(activeRodObj, ped, boneIndex, 0, 0, 0, 0, 0, 0, false, false, false, false, 2, true)

    local baseWait = 0
    if zoneType == 'zone' then 
        baseWait = math.random(Config.FishingZoneTime.min, Config.FishingZoneTime.max)
    elseif zoneType == 'deep' then 
        lib.notify({description = Config.Lang['youre_in_deep_water'], type = 'success'})
        baseWait = math.random(Config.DeepWaterTime.min, Config.DeepWaterTime.max)
    else 
        baseWait = math.random(Config.NormalTime.min, Config.NormalTime.max) 
    end

    local multiplier = (currentRod.CatchingMultiplier > 0) and currentRod.CatchingMultiplier or 1
    local finalWait = baseWait / multiplier
    
    lib.showTextUI(Config.Lang['stop_fishing'])
    
    CreateThread(function()
        local timer = 0
        while isFishing do
            Wait(0)
            timer = timer + (GetFrameTime() * 1000)

            if IsPedSwimming(ped) or IsPedInAnyVehicle(ped, false) then
                StopFishing()
                lib.notify({description = Config.Lang['fishing_stop'], type = 'error'})
                break
            end

            if IsControlJustPressed(0, 73) then 
                StopFishing()
                lib.notify({description = Config.Lang['fishing_stop'], type = 'inform'})
                break
            end
            
            if timer >= finalWait then
                debugPrint("Noget bed på!")
                local success = lib.skillCheck(Config.SkillCheck)
                
                if success then
                    TriggerServerEvent('as_fishing:server:catach', zoneType, currentRod)
                else
                    lib.notify({description = Config.Lang['fish_got_away'], type = 'error'})
                end

                if isFishing then
                    StopFishing()
                    Wait(1000)
                    TriggerEvent('as_fishing:start')
                end
                break
            end
        end
    end)
end

CreateThread(function()
    for name, data in pairs(Config.FishingZones) do
        if data.Blip and data.Blip.Enabled then
            local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
            SetBlipSprite(blip, data.Blip.Sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, data.Blip.Scale)
            SetBlipColour(blip, data.Blip.Color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(data.Blip.Name)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

CreateThread(function()
    for k, v in pairs(Config.FishingShops) do
        local blip = AddBlipForCoord(v.PedCoords.x, v.PedCoords.y, v.PedCoords.z)
        SetBlipSprite(blip, v.Blip.Sprite)
        SetBlipColour(blip, v.Blip.Color)
        SetBlipScale(blip, v.Blip.Scale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Blip.Name)
        EndTextCommandSetBlipName(blip)

        lib.requestModel(v.PedModel)
        local ped = CreatePed(4, v.PedModel, v.PedCoords.x, v.PedCoords.y, v.PedCoords.z - 1.0, v.PedCoords.w, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        
        exports.ox_target:addLocalEntity(ped, {
            {
                label = v.TargetLabel,
                icon = v.TargetIcon,
                onSelect = function() OpenShop(v.MenuLabel) end
            }
        })
    end

    for k, v in pairs(Config.FishingSell) do
        lib.requestModel(v.PedModel)
        local ped = CreatePed(4, v.PedModel, v.PedCoords.x, v.PedCoords.y, v.PedCoords.z - 1.0, v.PedCoords.w, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        
        exports.ox_target:addLocalEntity(ped, {
            {
                label = v.TargetLabel,
                icon = v.TargetIcon,
                onSelect = function() OpenSellMenu(v.MenuLabel) end
            }
        })
    end
end)

function OpenShop(label)
    local options = {}
    for k, v in pairs(Config.Rods) do
        table.insert(options, {
            title = v.Name,
            description = v.Disc .. "  \n" ..Config.Lang['price'] .. v.Price .. Config.Lang['currency'],
            onSelect = function() TriggerServerEvent('as_fishing:buyRod', k) end
        })
    end
    lib.registerContext({ id = 'fish_shop', title = label, options = options })
    lib.showContext('fish_shop')
end

function OpenSellMenu(label)
    local options = {}
    for k, v in pairs(Config.Fish) do
        if v.ItemPrice > 0 then
            table.insert(options, {
                title = Config.Lang['sell'] .. v.ItemLabel,
                description = Config.Lang['price'] .. v.ItemPrice .. Config.Lang['currency_per_unit'],
                onSelect = function() TriggerServerEvent('as_fishing:sellFish', k) end
            })
        end
    end
    lib.registerContext({ id = 'fish_sell', title = label, options = options })
    lib.showContext('fish_sell')
end

RegisterNetEvent('as_fishing:bigFish')
AddEventHandler('as_fishing:bigFish', function()
    local ped = PlayerPedId()
    StopFishing()
    Wait(200)
    lib.notify({description = Config.Lang['bigfish'], type = 'error'})
    SetPedToRagdoll(ped, 5000, 5000, 0, true, true, false)
    ApplyForceToEntity(ped, 1, GetEntityForwardVector(ped) * 90.0, 0.0, 40.0, 0.0, 0, false, true, true, false, true)
end)