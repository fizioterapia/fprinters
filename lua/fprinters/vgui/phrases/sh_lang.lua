FPrinters = FPrinters or {}
FPrinters.Phrases = FPrinters.Phrases or {}

FPrinters.Phrases.Data = {
    ["pl"] = {

    },
    ["en"] = {
        cantafford = "You don't have enough money to purchase this upgrade.",
        maxupgrade = "You have already the biggest tier of this upgrade.",
        upgraded = "You have succesfully purchased this upgrade.",
        collectmoney = "You have succesfully collected $%d.",
        money = "Money",
        upgrades = "Upgrades",
        speed = "Speed (%d/%d)",
        speedDesc = "Increases speed of your printer.",
        capacity = "Capacity (%d/%d)",
        capacityDesc = "Increases capacity of your printer.",
        cooler = "Cooler (%d/%d)",
        coolerDesc = "Increases the performance of coolant in your printer.",
        health = "Health (%d/%d)",
        healthDesc = "Increases the health of your printer.",
        upgrade = "+ ($%d)",
        max = "MAX",
        collect = "Collect ($%d)",
        printed = "Money printed\n$%d",
        totalprinted = "Total Printed\n%d",
        totalcapacity = "Total Capacity\n%d",
        rate = "Rate\n$%d/min",
        editprinter = "Edit Printer - %s",
        createprinter = "Create a new printer",
        updateprinter = "Update Printer",
        removeprinter = "Remove Printer",
        printers = "Printers",
        name = "Printer's Name",
        nameAdminDesc = "example: amazing printer",
        price = "Price",
        priceAdminDesc = "Price in F4 Menu (example: 1000 = $1000)",
        healthMsg = "Health",
        healthAdminDesc = "Printer's Health",
        capacityMsg = "Capacity",
        capacityAdminDesc = "Max Capacity of $$$ (example: 1000 = can hold $1000)",
        speedMsg = "Speed",
        speedAdminDesc = "How often it prints (example: 5 = every 5 seconds)",
        cpsMsg = "Cash Per Print",
        cpsAdminDesc = "Cash Per Print (example: 1000 = $1000 every {speed} seconds.",
        colorMsg = "Printer Color",
        added = "You have added a new printer. It will be available after restart.",
        updated = "You have updated a printer.",
        removed = "You have removed a printer."
    }
}
FPrinters.Phrases.Fallback = "en"
FPrinters.Phrases.ErrorMessage = "ERROR! Check your phrases file!"

function FPrinters.Phrases.Get(phrase)
    if !phrase then return FPrinters.Phrases.ErrorMessage end
    if !FPrinters.Phrases.Data[FPrinters.Config.Phrases.Language] then
        FPrinters.Config.Phrases.Language = FPrinters.Phrases.Fallback
    end

    if !FPrinters.Phrases.Data[FPrinters.Config.Phrases.Language][phrase] and !FPrinters.Phrases.Data[FPrinters.Phrases.Fallback][phrase] then
        return FPrinters.Phrases.ErrorMessage
    elseif !FPrinters.Phrases.Data[FPrinters.Config.Phrases.Language][phrase] then
        return !FPrinters.Phrases.Data[FPrinters.Phrases.Fallback][phrase]
    end

    return FPrinters.Phrases.Data[FPrinters.Config.Phrases.Language][phrase]
end