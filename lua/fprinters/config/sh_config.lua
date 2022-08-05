FPrinters = FPrinters or {}
FPrinters.Config = {
    Upgrades = {
        MaxTier = 10,
        StartTier = 1,
        Cost = 1000,
        CostMultiplier = 2, // (1 == 100%, no change || 2 == 200%, 2x price)
        SpeedIncrease = 0.25 // Speed = Speed - (SpeedIncrease * Tier) = 5 - (0.1 * 10) = 4
    },
    Printers = {
        ["Pink Cute Printer"] = {
            Class = "fprinters_pinky",
            HP = 100,
            Capacity = 10000,
            Speed = 5,
            PrintAmount = 100,
            Price = 100,
            MaxPrinters = 4,
            Color = Color(255,100,150)
        }
    }
}