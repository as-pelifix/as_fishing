local ESX = exports["es_extended"]:getSharedObject()

local function sendLog(webhook, title, message)
    if not webhook or webhook == "" then return end
    local embed = {{
        ["color"] = 3447003,
        ["title"] = "**".. title .."**",
        ["description"] = message,
        ["footer"] = { ["text"] = "Fishing Logs" },
    }}
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Fishing", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('as_fishing:buyRod')
AddEventHandler('as_fishing:buyRod', function(rodKey)
    local src = source
    if type(rodKey) ~= 'string' then return end

    local xPlayer = ESX.GetPlayerFromId(src)
    local rod = Config.Rods[rodKey]

    if not rod then return end

    if xPlayer.getMoney() >= rod.Price then
        if exports.ox_inventory:CanCarryItem(src, rodKey, 1) then
            xPlayer.removeMoney(rod.Price)
            exports.ox_inventory:AddItem(src, rodKey, 1)

            local msg = Config.Lang['bought_a'] .. rod.Name .. Config.Lang['for_total'] .. rod.Price .. Config.Lang['currency']
            TriggerClientEvent('ox_lib:notify', src, { description = msg, type = 'success' })

            local logMsg = GetPlayerName(src) .. Config.Lang['log_buy_desc'] .. rod.Name .. Config.Lang['for_total'] .. rod.Price .. Config.Lang['currency']
            sendLog(Config.BuySellWebhook, Config.Lang['log_buy_title'], logMsg)
        else
            TriggerClientEvent('ox_lib:notify', src, { description = Config.Lang['inventory_full'], type = 'error' })
        end
    else
        TriggerClientEvent('ox_lib:notify', src, { description = Config.Lang['not_enough_money'], type = 'error' })
    end
end)

-- Rate limiting for catch events
local lastCatch = {}

RegisterServerEvent('as_fishing:server:catach')
AddEventHandler('as_fishing:server:catach', function(zoneType, rodKey)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    -- Rate limit: minimum 5 seconds between catches
    if lastCatch[src] and (os.time() - lastCatch[src]) < 5 then return end
    lastCatch[src] = os.time()

    -- Validate inputs
    if type(rodKey) ~= 'string' then return end
    if zoneType ~= 'zone' and zoneType ~= 'normal' and zoneType ~= 'deep' then return end

    -- Look up rod data server-side instead of trusting client
    local rodData = Config.Rods[rodKey]
    if not rodData then return end

    -- Verify the player actually has this rod
    local rodCount = exports.ox_inventory:Search(src, 'count', rodKey)
    if not rodCount or rodCount <= 0 then return end

    local pool = {}
    local mainRarity = 'normal'

    if zoneType == 'zone' then mainRarity = 'normal'
    elseif zoneType == 'normal' then mainRarity = 'medium'
    elseif zoneType == 'deep' then mainRarity = 'rare' end

    local rng = math.random(1, 100)
    if rng <= rodData.ChanceForRarity then
        mainRarity = rodData.CatchingRarity
    end

    if mainRarity == 'rare' and math.random(1, 100) <= Config.BigFish then
        TriggerClientEvent('as_fishing:bigFish', src)
        return
    end

    -- Only include fish matching the target rarity (no longer always including normal)
    for k, v in pairs(Config.Fish) do
        if v.ItemRarity == mainRarity then
            table.insert(pool, k)
        end
    end

    if #pool == 0 then return end

    local selectedFish = pool[math.random(1, #pool)]
    local fishData = Config.Fish[selectedFish]
    local amount = math.random(fishData.ItemQuantity[1], fishData.ItemQuantity[2])
    local label = fishData.ItemLabel or selectedFish

    -- Handle money catches separately (money is not an inventory item)
    if fishData.itemName == 'money' then
        xPlayer.addMoney(amount)
        local msg = Config.Lang['you_caught'] .. amount .. Config.Lang['currency']
        local logMsg = GetPlayerName(src) .. Config.Lang['log_catch_desc'] .. amount .. Config.Lang['currency']
        TriggerClientEvent('ox_lib:notify', src, { description = msg, type = 'success' })
        sendLog(Config.CatchWebhook, Config.Lang['log_catch_title'], logMsg)
    else
        if not exports.ox_inventory:CanCarryItem(src, selectedFish, amount) then
            TriggerClientEvent('ox_lib:notify', src, { description = Config.Lang['inventory_full'], type = 'error' })
            return
        end

        exports.ox_inventory:AddItem(src, selectedFish, amount)
        local msg = Config.Lang['you_caught'] .. amount .. Config.Lang['count_stk'] .. " " .. label
        local logMsg = GetPlayerName(src) .. Config.Lang['log_catch_desc'] .. amount .. "x " .. label .. " (Rarity: " .. mainRarity .. ")"
        TriggerClientEvent('ox_lib:notify', src, { description = msg, type = 'success' })
        sendLog(Config.CatchWebhook, Config.Lang['log_catch_title'], logMsg)
    end
end)

-- Rate limiting for sell events
local lastSell = {}

RegisterServerEvent('as_fishing:sellFish')
AddEventHandler('as_fishing:sellFish', function(fishKey)
    local src = source
    if type(fishKey) ~= 'string' then return end

    -- Rate limit: minimum 2 seconds between sells
    if lastSell[src] and (os.time() - lastSell[src]) < 2 then return end
    lastSell[src] = os.time()

    local xPlayer = ESX.GetPlayerFromId(src)
    local fishData = Config.Fish[fishKey]

    if not fishData then return end

    local count = exports.ox_inventory:Search(src, 'count', fishKey)
    local price = fishData.ItemPrice

    if count and count > 0 then
        local total = count * price
        exports.ox_inventory:RemoveItem(src, fishKey, count)
        xPlayer.addMoney(total)

        local msg = Config.Lang['sell'] .. count .. Config.Lang['count_stk'] .. Config.Lang['for_total'] .. total .. Config.Lang['currency']
        local logMsg = GetPlayerName(src) .. Config.Lang['log_sell_desc'] .. count .. "x " .. (fishData.ItemLabel or fishKey) .. Config.Lang['for_total'] .. total .. Config.Lang['currency']

        TriggerClientEvent('ox_lib:notify', src, { description = msg, type = 'success' })
        sendLog(Config.BuySellWebhook, Config.Lang['log_sell_title'], logMsg)
    else
        TriggerClientEvent('ox_lib:notify', src, { description = Config.Lang['no_items_to_sell'], type = 'error' })
    end
end)

-- Clean up rate limit tables when players disconnect
AddEventHandler('playerDropped', function()
    local src = source
    lastCatch[src] = nil
    lastSell[src] = nil
end)
