Config = {}

Config.Debug = false
Config.CatchWebhook = ''
Config.BuySellWebhook = ''


Config.FishingZoneTime = { min = 13000, max = 32000 }
Config.NormalTime = { min = 13000, max = 22000 }
Config.DeepWaterTime = { min = 5000, max = 12000 }

Config.Depth = 100.0
Config.BigFish = 100

Config.SkillCheck = { 'easy', 'easy' }

Config.FishingShops = {
    ['SHOP_PALETO'] = {
        PedModel = `s_m_m_linecook`,
        PedCoords = vector4(-1600.6, 5195.69, 4.37, 294.37),
        TargetLabel = 'Open fishshop',
        TargetIcon = 'fa-solid fa-fish',
        MenuLabel = 'Fishingshop',
        Blip = { ShowBlip = true, Sprite = 356, Color = 3, Scale = 0.8, ShortRange = true, Name = 'Fishingshop' },
    }
}

Config.FishingSell = {
    ['SELL_PALETO'] = {
        PedModel = `s_m_m_linecook`,
        PedCoords = vector4(-1601.5081, 5197.6328, 4.3632, 304.9454),
        TargetLabel = 'Sell Fish',
        TargetIcon = 'fa-solid fa-dollar-sign',
        MenuLabel = 'Fishingshop',
        Blip = { ShowBlip = true, Sprite = 356, Color = 2, Scale = 0.8, ShortRange = true, Name = 'Fishingshop' },
    }
}

Config.FishingZones = {
    ['FISHINGZONE_1_PALETOBAY'] = {
        coords = vec3(-1593.0, 5227.0, 4.0),
        size = vec3(10.0, 73.0, 10.0),
        rotation = 25.0,
        Blip = {
            Enabled = true,
            Sprite = 68,
            Color = 3,
            Scale = 0.8,
            Name = "Fishing zone"
        },
    }
}

Config.Rods = {
    ['normal_rod'] = {
        CatchingMultiplier = 1.0,
        ChanceForRarity = 5,
        CatchingRarity = 'normal',
        Price = 1000,
        Name = 'Normal Fishingrod',
        Disc = 'A good beginner rod',
    },
    ['medium_rod'] = {
        CatchingMultiplier = 3.0,
        ChanceForRarity = 20,
        CatchingRarity = 'medium',
        Price = 2500,
        Name = 'Professionel Fishingrod',
        Disc = 'Better courghts, and faster rod',
    },
    ['rare_rod'] = {
        CatchingMultiplier = 5.0,
        ChanceForRarity = 80,
        CatchingRarity = 'rare',
        Price = 5000,
        Name = 'Premium Fishingrod',
        Disc = 'The ultimate rod',
    },
}

Config.Fish = {
    ['fish_tuna'] = {
        ItemRarity = 'rare',
        ItemPrice = 1000,
        ItemQuantity = { 1, 3 },
        ItemLabel = 'Tuna',
        ItemDisc = 'A good fish'
    },
    ['fish_salmon'] = {
        ItemRarity = 'rare',
        ItemPrice = 1500,
        ItemQuantity = { 1, 3 },
        ItemLabel = 'Salmon',
        ItemDisc = 'A good fish'
    },
    ['fish_trout'] = {
        ItemRarity = 'rare',
        ItemPrice = 1200,
        ItemQuantity = { 1, 3 },
        ItemLabel = 'Trout',
        ItemDisc = 'Fresh from the stream'
    },
    ['fish_cod'] = {
        ItemRarity = 'medium',
        ItemPrice = 500,
        ItemQuantity = { 1, 3 },
        ItemLabel = 'Cod',
        ItemDisc = 'A good fish'
    },
    ['fish_commonsole'] = {
        ItemRarity = 'medium',
        ItemPrice = 600,
        ItemQuantity = { 1, 3 },
        ItemLabel = 'Commonsole',
        ItemDisc = 'A flat and good fish'
    },
    ['fish_plaice'] = {
        ItemRarity = 'medium',
        ItemPrice = 500,
        ItemQuantity = { 1, 3 },
        ItemLabel = 'Plaice',
        ItemDisc = 'Perfect for the pan'
    },
    ['fish_herring'] = {
        ItemRarity = 'normal',
        ItemPrice = 300,
        ItemQuantity = { 1, 3 },
        ItemLabel = 'Herring',
        ItemDisc = 'Smelly smelly'
    },
    ['fish_mackerel'] = {
        ItemRarity = 'normal',
        ItemPrice = 300,
        ItemQuantity = { 1, 3 },
        ItemLabel = 'Mackerel',
        ItemDisc = 'A fast litle boy'
    },
    ['trash'] = {
        ItemRarity = 'normal',
        ItemPrice = 0,
        ItemQuantity = { 1, 2 },
        ItemLabel = 'Trash',
        ItemDisc = 'Old trash from bikini buttom'
    },
    ['WEAPON_SWITCHBLADE'] = {
        ItemRarity = 'normal',
        ItemPrice = 0,
        ItemQuantity = { 1, 1 },
        ItemLabel = 'Switchblade',
        ItemDisc = 'Dropped by a murderer'
    },
    ['WEAPON_KNUCKLE'] = {
        ItemRarity = 'medium',
        ItemPrice = 0,
        ItemQuantity = { 1, 1 },
        ItemLabel = 'Knucles',
        ItemDisc = 'Heavy metal'
    },
    ['WEAPON_MACHETE'] = {
        ItemRarity = 'rare',
        ItemPrice = 0,
        ItemQuantity = { 1, 1 },
        ItemLabel = 'Machete',
        ItemDisc = 'A rusty weapon'
    },
    ['money_normal'] = {
        itemName = 'money',
        ItemRarity = 'normal',
        ItemPrice = 0,
        ItemQuantity = { 100, 500 },
        ItemLabel = 'Cash money'
    },
    ['money_medium'] = {
        itemName = 'money',
        ItemRarity = 'medium',
        ItemPrice = 0,
        ItemQuantity = { 1000, 4000 },
        ItemLabel = 'Wet bag of money'
    },
    ['money_rare'] = {
        itemName = 'money',
        ItemRarity = 'rare',
        ItemPrice = 0,
        ItemQuantity = { 7000, 8000 },
        ItemLabel = 'Old money register'
    },
}

Config.Lang = {
    ['no_vehicle_fishing'] = "You can't fish while sitting in a vehicle!",
    ['no_svim_fishing'] = "You can't fish while swimming!",
    ['no_zone_found'] = "You need to be in water or a fishing zone to fish!",
    ['no_rod'] = "You don't have a fishing rod!",
    ['youre_in_deep_water'] = "You are now in deep water!",
    ['stop_fishing'] = "[X] Stop fishing",
    ['fishing_stop'] = "Fishing was interrupted!",
    ['fish_got_away'] = "The fish got away!",
    ['price'] = "Price:",
    ['currency'] = " $",
    ['currency_per_unit'] = " $ per unit",
    ['sell'] = "Sell ",
    ['bigfish'] = "A HUGE FISH IS PULLING YOU OVERBOARD!",

    ['not_enough_money'] = "You don't have enough money!",
    ['inventory_full'] = "Your inventory is full!",
    ['no_items_to_sell'] = "You have none of these on you!",
    ['bought_a'] = "You bought a ",
    ['for_total'] = " for a total of ",
    ['count_stk'] = " pcs.",
    ['you_caught'] = "You caught ",
    ['log_buy_title'] = "Store Purchase",
    ['log_buy_desc'] = " bought a ",
    ['log_catch_title'] = "Catch",
    ['log_catch_desc'] = " caught ",
    ['log_sell_title'] = "Fish Sale",
    ['log_sell_desc'] = " sold ",
}
