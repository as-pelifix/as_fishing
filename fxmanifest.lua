fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Assured Studios - Pelifix'
description 'Advanced Fishing'
version '1.0.0'

shared_scripts {
	'config.lua',
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
}

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

dependencies {
    'oxmysql',
    'ox_lib',
    'ox_target',
    'ox_inventory',
}

--[[ DANSIH CONFIG
    Config = {}

Config.Debug = false 
Config.CatchWebhook = ''
Config.BuySellWebhook = ''


Config.FishingZoneTime = {min = 13000, max = 32000} 
Config.NormalTime = {min = 13000, max = 22000}
Config.DeepWaterTime = {min = 5000, max = 12000}

Config.Depth = 100.0 
Config.BigFish = 10 

Config.SkillCheck = {'easy', 'easy'}, {'e'}

Config.FishingShops = {
    ['SHOP_PALETO'] = {
        PedModel = `s_m_m_linecook`,
        PedCoords = vector4(-1600.6, 5195.69, 4.37, 294.37),
        TargetLabel = 'Åben Fiskeributik',
        TargetIcon = 'fa-solid fa-fish',
        MenuLabel = 'Fiskeributik',
        Blip = { ShowBlip = true, Sprite = 356, Color = 3, Scale = 0.8, ShortRange = true, Name = 'Fiskeributik' },
    }
}

Config.FishingSell = {
    ['SELL_PALETO'] = {
        PedModel = `s_m_m_linecook`,
        PedCoords = vector4(-1601.5081, 5197.6328, 4.3632, 304.9454),
        TargetLabel = 'Sælg fisk',
        TargetIcon = 'fa-solid fa-dollar-sign',
        MenuLabel = 'Fiskehandler',
        Blip = { ShowBlip = true, Sprite = 356, Color = 2, Scale = 0.8, ShortRange = true, Name = 'Fiskehandler' },
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
            Name = "Fiskerizone"
        },
    }
}

Config.Rods = {
    ['normal_rod'] = {
        CatchingMultiplier = 1.0,
        ChanceForRarity = 5,
        CatchingRarity = 'normal',
        Price = 1000,
        Name = 'Normal Fiskestang',
        Disc = 'En god starter fiskestang',
    },
    ['medium_rod'] = {
        CatchingMultiplier = 3.0,
        ChanceForRarity = 20,
        CatchingRarity = 'medium',
        Price = 2500,
        Name = 'Professionel Fiskestang',
        Disc = 'Bedre fangster og højere hastighed',
    },
    ['rare_rod'] = {
        CatchingMultiplier = 5.0,
        ChanceForRarity = 80,
        CatchingRarity = 'rare',
        Price = 5000,
        Name = 'Premium Fiskestang',
        Disc = 'Den ultimative stang til de største fisk',
    },
}

Config.Fish = {
  ['fish_tuna'] = { 
      ItemRarity = 'rare', 
      ItemPrice = 1000, 
      ItemQuantity = {1, 3}, 
      ItemLabel = 'Tun', 
      ItemDisc = 'En god og lækker fisk' 
  },
  ['fish_salmon'] = { 
      ItemRarity = 'rare', 
      ItemPrice = 1500, 
      ItemQuantity = {1, 3}, 
      ItemLabel = 'Laks', 
      ItemDisc = 'En eksklusiv spisefisk' 
  },
  ['fish_trout'] = { 
      ItemRarity = 'rare', 
      ItemPrice = 1200, 
      ItemQuantity = {1, 3}, 
      ItemLabel = 'Ørred', 
      ItemDisc = 'Frisk fra strømmen' 
  },
  ['fish_cod'] = { 
      ItemRarity = 'medium', 
      ItemPrice = 500, 
      ItemQuantity = {1, 3}, 
      ItemLabel = 'Torsk', 
      ItemDisc = 'En god og lækker fisk' 
  },
  ['fish_commonsole'] = { 
      ItemRarity = 'medium', 
      ItemPrice = 600, 
      ItemQuantity = {1, 3}, 
      ItemLabel = 'Tunge', 
      ItemDisc = 'En flad og lækker fisk' 
  },
  ['fish_plaice'] = { 
      ItemRarity = 'medium', 
      ItemPrice = 500, 
      ItemQuantity = {1, 3}, 
      ItemLabel = 'Rødspætte', 
      ItemDisc = 'Perfekt til panden' 
  },
  ['fish_herring'] = { 
      ItemRarity = 'normal', 
      ItemPrice = 300, 
      ItemQuantity = {1, 3}, 
      ItemLabel = 'Sild', 
      ItemDisc = 'Klassisk sølvfisk' 
  },
  ['fish_mackerel'] = { 
      ItemRarity = 'normal', 
      ItemPrice = 300, 
      ItemQuantity = {1, 3}, 
      ItemLabel = 'Makrel', 
      ItemDisc = 'En hurtig lille fætter' 
  },
  ['trash'] = { 
      ItemRarity = 'normal', 
      ItemPrice = 0, 
      ItemQuantity = {1, 2}, 
      ItemLabel = 'Affald', 
      ItemDisc = 'Gammelt lort fra bunden' 
  },
  ['WEAPON_SWITCHBLADE'] = { 
      ItemRarity = 'normal', 
      ItemPrice = 0, 
      ItemQuantity = {1, 1}, 
      ItemLabel = 'Springkniv', 
      ItemDisc = 'Tabt af en uheldig type' 
  },
  ['WEAPON_KNUCKLE'] = { 
      ItemRarity = 'medium', 
      ItemPrice = 0, 
      ItemQuantity = {1, 1}, 
      ItemLabel = 'Knojern', 
      ItemDisc = 'Noget tungt metal' 
  },
  ['WEAPON_MACHETE'] = { 
      ItemRarity = 'rare', 
      ItemPrice = 0, 
      ItemQuantity = {1, 1}, 
      ItemLabel = 'Machete', 
      ItemDisc = 'Et stort, rustent våben' 
  },
  ['money'] = { 
      itemName = 'money',
      ItemRarity = 'normal', 
      ItemPrice = 0, 
      ItemQuantity = {100, 500}, 
      ItemLabel = 'Lidt småmønter' 
  },
  ['money'] = { 
      itemName = 'money',
      ItemRarity = 'medium', 
      ItemPrice = 0, 
      ItemQuantity = {1000, 4000}, 
      ItemLabel = 'Våd pengepose' 
  },
  ['money'] = { 
      itemName = 'money',
      ItemRarity = 'rare', 
      ItemPrice = 0, 
      ItemQuantity = {7000, 8000}, 
      ItemLabel = 'Gammel pengeskrin' 
  },
}

Config.Lang = { 
    ['no_vehicle_fishing'] = 'Du kan ikke fiske, mens du sidder i et køretøj!',
    ['no_svim_fishing'] = 'Du kan ikke fiske, mens du svømmer!',
    ['no_zone_found'] = 'Du skal stå i vandet eller i en fiskezone for at fiske!',
    ['no_rod'] = 'Du har ingen fiskestang!',
    ['youre_in_deep_water'] = 'Du er nu på dybt vand!',
    ['stop_fishing'] = '[X] Stop fiskeri',
    ['fishing_stop'] = 'Fiskeriet blev afbrudt!',
    ['fish_got_away'] = 'Fisken slap væk!',
    ['price'] = 'Pris:',
    ['currency'] = ' kr',
    ['currency_per_unit'] = ' DKK pr. stk.',
    ['sell'] = 'Sælg ',
    ['bigfish'] = 'EN KÆMPE FISK TRÆKKER DIG OVER BORD!',

    ['not_enough_money'] = "Du har ikke nok penge!",
    ['inventory_full'] = "Din taske er fuld!",
    ['no_items_to_sell'] = "Du har ingen af disse på dig!",
    ['bought_a'] = "Du købte en ",
    ['for_total'] = " for i alt ",
    ['count_stk'] = " stk.",
    ['you_caught'] = "Du fangede ",
    ['log_buy_title'] = "Køb i butik",
    ['log_buy_desc'] = " købte en ",
    ['log_catch_title'] = "Fangst",
    ['log_catch_desc'] = " fangede ",
    ['log_sell_title'] = "Salg af fisk",
    ['log_sell_desc'] = " solgte ",
}
]]
