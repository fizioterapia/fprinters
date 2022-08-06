FPrinters = FPrinters or {}

util.AddNetworkString("FPrinter_OpenPrinter")

util.AddNetworkString("FPrinter_AddPrinter")
util.AddNetworkString("FPrinter_UpdatePrinter")
util.AddNetworkString("FPrinter_RemovePrinter")

util.AddNetworkString("FPrinter_CollectMoney")
util.AddNetworkString("FPrinter_UpgradeSpeed")
util.AddNetworkString("FPrinter_UpgradeCapacity")
util.AddNetworkString("FPrinter_UpgradeCooler")
util.AddNetworkString("FPrinter_UpgradeHealth")

net.Receive("FPrinter_AddPrinter", function(len, ply)
    if !IsValid(ply) or !ply:IsSuperAdmin() then return end

    local printerData = net.ReadTable()

    table.insert(FPrinters.Config.Printers, printerData)

    FPrinters.SaveConfig()

    DarkRP.notify(ply, 0, 10, FPrinters.Phrases.Get('added'))
end)

net.Receive("FPrinter_UpdatePrinter", function(len, ply)
    if !IsValid(ply) or !ply:IsSuperAdmin() then return end

    local printerId = net.ReadInt(16)
    local printerData = net.ReadTable()

    FPrinters.Config.Printers[printerId] = printerData

    FPrinters.SaveConfig()

    DarkRP.notify(ply, 0, 10, FPrinters.Phrases.Get('updated'))
end)

net.Receive("FPrinter_RemovePrinter", function(len, ply)
    if !IsValid(ply) or !ply:IsSuperAdmin() then return end

    local printerId = net.ReadInt(16)

    table.remove(FPrinters.Config.Printers, printerId)

    FPrinters.SaveConfig()

    DarkRP.notify(ply, 0, 10, FPrinters.Phrases.Get('removed'))
end)

net.Receive("FPrinter_CollectMoney", function(len, ply)
    if !IsValid(ply) then return end

    local printer = net.ReadEntity()

    if !printer or !IsValid(printer) then return end

    printer:Collect(ply)
end)

net.Receive("FPrinter_UpgradeSpeed", function(len, ply)
    if !IsValid(ply) then return end

    local printer = net.ReadEntity()

    if !printer or !IsValid(printer) then return end

    printer:UpgradeSpeed(ply)
end)

net.Receive("FPrinter_UpgradeCapacity", function(len, ply)
    local printer = net.ReadEntity()

    if !printer or !IsValid(printer) then return end

    printer:UpgradeCapacity(ply)
end)

net.Receive("FPrinter_UpgradeCooler", function(len, ply)
    if !IsValid(ply) then return end

    local printer = net.ReadEntity()

    if !printer or !IsValid(printer) then return end

    printer:UpgradeCooler(ply)
end)

net.Receive("FPrinter_UpgradeHealth", function(len, ply)
    if !IsValid(ply) then return end

    local printer = net.ReadEntity()

    if !printer or !IsValid(printer) then return end

    printer:UpgradeHealth(ply)
end)