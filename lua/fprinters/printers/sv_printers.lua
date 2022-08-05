FPrinters = FPrinters or {}

util.AddNetworkString("FPrinter_OpenPrinter")

util.AddNetworkString("FPrinter_CollectMoney")
util.AddNetworkString("FPrinter_UpgradeSpeed")
util.AddNetworkString("FPrinter_UpgradeCapacity")
util.AddNetworkString("FPrinter_UpgradeCooler")
util.AddNetworkString("FPrinter_UpgradeHealth")

net.Receive("FPrinter_CollectMoney", function(len, ply)
    local printer = net.ReadEntity()

    if !printer or !IsValid(printer) then return end

    printer:Collect(ply)
end)

net.Receive("FPrinter_UpgradeSpeed", function(len, ply)
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
    local printer = net.ReadEntity()

    if !printer or !IsValid(printer) then return end

    printer:UpgradeCooler(ply)
end)

net.Receive("FPrinter_UpgradeHealth", function(len, ply)
    local printer = net.ReadEntity()

    if !printer or !IsValid(printer) then return end

    printer:UpgradeHealth(ply)
end)