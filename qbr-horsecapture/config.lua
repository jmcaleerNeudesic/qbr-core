Config = {}

-- Distance to detect wild horses
Config.DetectionRadius = 10.0

-- Time in milliseconds to tame a horse
Config.TamingTime = 10000

-- Percentage of horse value when selling (0.5 = 50%)
Config.SellPercentage = 0.5

-- Wild horse models that can be captured
Config.WildHorseModels = {
    `A_C_Horse_Mustang_GoldenDun`,
    `A_C_Horse_Mustang_GrulloDun`,
    `A_C_Horse_Mustang_TigerStripedBay`,
    `A_C_Horse_Mustang_WildBay`,
    `A_C_Horse_Nokota_BlueRoan`,
    `A_C_Horse_Nokota_ReverseDappleRoan`,
    `A_C_Horse_Nokota_WhiteRoan`,
    `A_C_Horse_TennesseeWalker_BlackRabicano`,
    `A_C_Horse_TennesseeWalker_Chestnut`,
    `A_C_Horse_TennesseeWalker_DappleBay`,
    `A_C_Horse_TennesseeWalker_FlaxenRoan`,
    `A_C_Horse_TennesseeWalker_MahoganyBay`,
    `A_C_Horse_TennesseeWalker_RedRoan`
}

-- Sell locations (horse dealers)
Config.SellLocations = {
    {
        name = "Valentine Horse Dealer",
        coords = vector3(-365.9, 787.7, 116.2),
        blip = true
    },
    {
        name = "Blackwater Horse Dealer", 
        coords = vector3(-875.5, -1363.3, 43.5),
        blip = true
    },
    {
        name = "Rhodes Horse Dealer",
        coords = vector3(1298.8, -1279.5, 76.0),
        blip = true
    },
    {
        name = "Saint Denis Horse Dealer",
        coords = vector3(2508.0, -1450.0, 46.3),
        blip = true
    }
}

-- Prompt text
Config.Lang = {
    tame_prompt = "Tame Wild Horse",
    taming = "Taming horse...",
    tamed = "Horse successfully tamed!",
    failed = "Horse got away!",
    sell_prompt = "Sell Horse",
    sold = "Sold horse for $%s",
    no_horse = "You must be on a horse to sell it",
    not_wild_horse = "This horse cannot be sold",
    too_far = "You're too far from the horse dealer"
}
