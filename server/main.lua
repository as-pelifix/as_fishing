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

RegisterServerEvent('as_fishing:server:catach')
AddEventHandler('as_fishing:server:catach', function(zoneType, rodData)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
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

    for k, v in pairs(Config.Fish) do
        if v.ItemRarity == mainRarity or v.ItemRarity == 'normal' then
            table.insert(pool, k)
        end
    end

    if #pool == 0 then return end

    local selectedFish = pool[math.random(1, #pool)]
    local fishData = Config.Fish[selectedFish]
    local amount = math.random(fishData.ItemQuantity[1], fishData.ItemQuantity[2])
    local label = fishData.ItemLabel or selectedFish

    if exports.ox_inventory:CanCarryItem(src, selectedFish, amount) then
        local msg = ""
        local logMsg = ""
        
        if fishData.itemName == 'money' or selectedFish == 'money' then
            xPlayer.addMoney(amount)
            msg = Config.Lang['you_caught'] .. amount .. Config.Lang['currency']
            logMsg = GetPlayerName(src) .. Config.Lang['log_catch_desc'] .. amount .. Config.Lang['currency']
        else
            exports.ox_inventory:AddItem(src, selectedFish, amount)
            msg = Config.Lang['you_caught'] .. amount .. Config.Lang['count_stk'] .. " " .. label
            logMsg = GetPlayerName(src) .. Config.Lang['log_catch_desc'] .. amount .. "x " .. label .. " (Rarity: " .. mainRarity .. ")"
        end
        
        TriggerClientEvent('ox_lib:notify', src, { description = msg, type = 'success' })
        sendLog(Config.CatchWebhook, Config.Lang['log_catch_title'], logMsg)
    else
        TriggerClientEvent('ox_lib:notify', src, { description = Config.Lang['inventory_full'], type = 'error' })
    end
end)

RegisterServerEvent('as_fishing:sellFish')
AddEventHandler('as_fishing:sellFish', function(fishKey)
    local src = source
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