FPrinters = FPrinters or {}

local closeButton = Material("fprinters/cancel.png", "noclamp mips smooth")
local speedUpgrade = Material("fprinters/speed.png", "noclamp mips smooth")
local capacityUpgrade = Material("fprinters/money.png", "noclamp mips smooth")
local coolerUpgrade = Material("fprinters/fan.png", "noclamp mips smooth")
local healthUpgrade = Material("fprinters/armor.png", "noclamp mips smooth")

function FPrinters:CreatePrinterMenu(printer)
    local printerMenu = vgui.Create("DFrame")
    printerMenu:SetSize(1024, 576)
    printerMenu:Center()
    printerMenu:MakePopup()

    printerMenu:DockPadding(0,0,0,0)
    printerMenu:DockMargin(0,0,0,0)

    printerMenu:ShowCloseButton(false)
    printerMenu:SetTitle(" ")

    function printerMenu:Paint(w, h)
        surface.SetDrawColor(33,33,33,255)
        surface.DrawRect(0,0,w,h)

        return
    end

    local navigationBar = vgui.Create("DPanel", printerMenu)
    navigationBar:Dock(TOP)
    navigationBar:SetTall(48)

    function navigationBar:Paint(w, h)
        surface.SetDrawColor(44,44,44,255)
        surface.DrawRect(0,0,w,h)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawRect(0,h-4,w,4)
        return
    end

    local closeBtn = vgui.Create("DButton", navigationBar)
    closeBtn:Dock(RIGHT)
    closeBtn:SetSize(48,48)
    closeBtn:SetText("")
    function closeBtn:Paint(w, h)
        surface.SetMaterial(closeButton)
        if !self:IsHovered() then
            surface.SetDrawColor(255,255,255)
        else
            surface.SetDrawColor(printer.Defaults.Color)
        end
        surface.DrawTexturedRect(8,8,32,32)
    end

    local navigationTitle = vgui.Create("DLabel", navigationBar)
    navigationTitle:Dock(FILL)
    navigationTitle:SetText(printer.PrintName)
    navigationTitle:SizeToContents()
    navigationTitle:SetTextColor(Color(255,255,255))
    navigationTitle:SetFont("FPrinters_Printer_18_Bold")
    navigationTitle:DockMargin(8,0,0,0)

    function closeBtn:DoClick()
        printerMenu:Close()
    end

    local container = vgui.Create("DPanel", printerMenu)
    container:DockMargin(8,8,8,8)
    container:Dock(FILL)
    container:InvalidateParent(true)

    function container:Paint()
        return 
    end

    local moneyPanel = vgui.Create("DPanel", container)
    moneyPanel:SetWide(moneyPanel:GetParent():GetWide() / 3)
    moneyPanel:Dock(LEFT)
    moneyPanel:DockMargin(0,0,8,0)
    moneyPanel:DockPadding(12,12,12,12)

    function moneyPanel:Paint(w,h)
        surface.SetDrawColor(44,44,44,255)
        surface.DrawRect(0,0,w,h)
    end

    local moneyHeader = vgui.Create("DLabel", moneyPanel)
    moneyHeader:Dock(TOP)
    moneyHeader:SetText("Money")
    moneyHeader:SetTextColor(Color(255,255,255))
    moneyHeader:SetFont("FPrinters_Printer_24_Bold")
    moneyHeader:SizeToContents()

    local separator = vgui.Create("DPanel", moneyPanel)
    separator:Dock(TOP)
    separator:SetTall(2)
    separator:DockMargin(0,8,0,8)

    function separator:Paint(w, h)
        surface.SetDrawColor(180,180,180,255)
        surface.DrawRect(0,0,w,h)
    end

    local printerBalance = vgui.Create("DLabel", moneyPanel)
    printerBalance:Dock(TOP)
    printerBalance:SetFont("FPrinters_Printer_18")
    printerBalance:SetText("Money printed\n$" .. printer:GetMoney())
    printerBalance:SizeToContents()
    printerBalance:DockMargin(0,0,0,8)

    function printerBalance:Think()
        printerBalance:SetText("Money printed\n$" .. printer:GetMoney())
        printerBalance:SizeToContents()
    end

    local printerEarned = vgui.Create("DLabel", moneyPanel)
    printerEarned:Dock(TOP)
    printerEarned:SetFont("FPrinters_Printer_18")
    printerEarned:SetText("Total earned \n$" .. printer:GetTotalPrinted())
    printerEarned:SizeToContents()
    printerEarned:DockMargin(0,0,0,8)

    function printerEarned:Think()
        printerEarned:SetText("Total earned \n$" .. printer:GetTotalPrinted())
        printerEarned:SizeToContents()
    end

    local printerCapacity = vgui.Create("DLabel", moneyPanel)
    printerCapacity:Dock(TOP)
    printerCapacity:SetFont("FPrinters_Printer_18")
    printerCapacity:SetText("Total capacity\n$" .. printer:GetCapacity())
    printerCapacity:SizeToContents()
    printerCapacity:DockMargin(0,0,0,8)

    function printerCapacity:Think()
        printerCapacity:SetText("Total capacity\n$" .. printer:GetCapacity())
        printerCapacity:SizeToContents()
    end

    local printerRate = vgui.Create("DLabel", moneyPanel)
    printerRate:Dock(TOP)
    printerRate:SetFont("FPrinters_Printer_18")
    printerRate:SetText("Rate\n$500/min")
    printerRate:SizeToContents()
    printerRate:DockMargin(0,0,0,8)

    function printerRate:Think()
        printerRate:SetText("Rate\n$" .. (60 / printer:GetSpeed()) * printer:GetPrintAmount() .. "/min")
        printerRate:SizeToContents()
    end

    local printerCollect = vgui.Create("DButton", moneyPanel)
    printerCollect:Dock(BOTTOM)
    printerCollect:SetTall(48)
    printerCollect:SetText("")

    function printerCollect:Paint(w,h)
        if self:IsHovered() then
            surface.SetTextColor(0,0,0)
            surface.SetDrawColor(255,255,255)
        else
            surface.SetTextColor(255,255,255)
            surface.SetDrawColor(printer.Defaults.Color)
        end
        surface.DrawRect(0,0,w,h)
        surface.SetFont("FPrinters_Printer_18_Bold")
        local tw, th = surface.GetTextSize("Collect ($" .. printer:GetMoney() ..")")

        surface.SetTextPos(w / 2 - tw / 2, h / 2 - th / 2)

        surface.DrawText("Collect ($" .. printer:GetMoney() ..")")
    end

    function printerCollect:DoClick()
        net.Start("FPrinter_CollectMoney")
            net.WriteEntity(printer)
        net.SendToServer()
    end

    local upgradesPanel = vgui.Create("DPanel", container)
    upgradesPanel:Dock(FILL)
    upgradesPanel:InvalidateParent(true)
    upgradesPanel:DockPadding(12,12,12,12)

    function upgradesPanel:Paint(w,h)
        surface.SetDrawColor(44,44,44,255)
        surface.DrawRect(0,0,w,h)
    end

    local upgradesHeader = vgui.Create("DLabel", upgradesPanel)
    upgradesHeader:Dock(TOP)
    upgradesHeader:SetText("Upgrades")
    upgradesHeader:SetTextColor(Color(255,255,255))
    upgradesHeader:SetFont("FPrinters_Printer_24_Bold")
    upgradesHeader:SizeToContents()

    local separator = vgui.Create("DPanel", upgradesPanel)
    separator:Dock(TOP)
    separator:SetTall(2)
    separator:DockMargin(0,8,0,8)

    function separator:Paint(w, h)
        surface.SetDrawColor(180,180,180,255)
        surface.DrawRect(0,0,w,h)
    end

    local upgrade = vgui.Create("DPanel", upgradesPanel)
    upgrade:Dock(TOP)
    upgrade:SetTall(64)
    upgrade:DockPadding(8,8,8,8)
    upgrade:DockMargin(0,4,0,4)

    function upgrade:Paint(w, h)
        surface.SetDrawColor(33,33,33,255)
        surface.DrawRect(0,0,w,h)
    end

    local upgradeIcon = vgui.Create("DPanel", upgrade)
    upgradeIcon:Dock(LEFT)
    upgradeIcon:SetTall(48)
    upgradeIcon:SetWide(48)

    function upgradeIcon:Paint(w, h)
        surface.SetDrawColor(44,44,44,255)
        surface.DrawRect(0,0,w,h)

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(speedUpgrade)
        surface.DrawTexturedRect(4,4,w-8,h-8)
    end

    local upgradePurchase = vgui.Create("DButton", upgrade)
    upgradePurchase:Dock(RIGHT)
    upgradePurchase:SetTall(48)
    upgradePurchase:SetWide(96)
    local upgradeMoney = (printer:GetSpeedUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost
    upgradePurchase:SetText("+ ($" .. upgradeMoney .. ")")
    upgradePurchase:SetFont("FPrinters_Printer_18_Bold")

    function upgradePurchase:Paint(w, h)
        local upgradeMoney = (printer:GetSpeedUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost
        self:SetText("+ ($" .. upgradeMoney .. ")")

        if (printer:GetSpeedUpgrade() >= FPrinters.Config.Upgrades.MaxTier) then
            self:SetText("MAX")
        end

        if self:IsHovered() then
            self:SetTextColor(Color(0,0,0))
            surface.SetDrawColor(255,255,255)
        else
            self:SetTextColor(Color(255,255,255))
            surface.SetDrawColor(printer.Defaults.Color)
        end
        surface.DrawRect(0,0,w,h)
    end

    function upgradePurchase:DoClick()
        net.Start("FPrinter_UpgradeSpeed")
            net.WriteEntity(printer)
        net.SendToServer()
    end

    local upgradeDetails = vgui.Create("DPanel", upgrade)
    upgradeDetails:Dock(FILL)
    upgradeDetails:DockPadding(8,4,8,4)
    
    function upgradeDetails:Paint()
        return 
    end

    local upgradeHeader = vgui.Create("DLabel", upgradeDetails)
    upgradeHeader:Dock(TOP)
    upgradeHeader:SetFont("FPrinters_Printer_24_Bold")
    upgradeHeader:SetText("Speed (" .. printer:GetSpeedUpgrade() .. "/10)")
    upgradeHeader:SizeToContents()

    function upgradeHeader:Think()
        upgradeHeader:SetText("Speed (" .. printer:GetSpeedUpgrade() .. "/10)")
        upgradeHeader:SizeToContents()
    end

    local upgradeContent = vgui.Create("DLabel", upgradeDetails)
    upgradeContent:Dock(TOP)
    upgradeContent:SetFont("FPrinters_Printer_18")
    upgradeContent:SetText("Upgrade speed of your printer, bigger rate means bigger cash :)")
    upgradeContent:SizeToContents()

    local upgrade = vgui.Create("DPanel", upgradesPanel)
    upgrade:Dock(TOP)
    upgrade:SetTall(64)
    upgrade:DockPadding(8,8,8,8)
    upgrade:DockMargin(0,4,0,4)

    function upgrade:Paint(w, h)
        surface.SetDrawColor(33,33,33,255)
        surface.DrawRect(0,0,w,h)
    end

    local upgradeIcon = vgui.Create("DPanel", upgrade)
    upgradeIcon:Dock(LEFT)
    upgradeIcon:SetTall(48)
    upgradeIcon:SetWide(48)

    function upgradeIcon:Paint(w, h)
        surface.SetDrawColor(44,44,44,255)
        surface.DrawRect(0,0,w,h)

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(capacityUpgrade)
        surface.DrawTexturedRect(4,4,w-8,h-8)
    end

    local upgradePurchase = vgui.Create("DButton", upgrade)
    upgradePurchase:Dock(RIGHT)
    upgradePurchase:SetTall(48)
    upgradePurchase:SetWide(96)
    local upgradeMoney = (printer:GetCapacityUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost
    upgradePurchase:SetText("+ ($" .. upgradeMoney .. ")")
    upgradePurchase:SetFont("FPrinters_Printer_18_Bold")

    function upgradePurchase:Paint(w, h)
        local upgradeMoney = (printer:GetCapacityUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost
        self:SetText("+ ($" .. upgradeMoney .. ")")

        if (printer:GetCapacityUpgrade() >= FPrinters.Config.Upgrades.MaxTier) then
            self:SetText("MAX")
        end

        if self:IsHovered() then
            self:SetTextColor(Color(0,0,0))
            surface.SetDrawColor(255,255,255)
        else
            self:SetTextColor(Color(255,255,255))
            surface.SetDrawColor(printer.Defaults.Color)
        end
        surface.DrawRect(0,0,w,h)
    end

    function upgradePurchase:DoClick()
        net.Start("FPrinter_UpgradeCapacity")
            net.WriteEntity(printer)
        net.SendToServer()
    end

    local upgradeDetails = vgui.Create("DPanel", upgrade)
    upgradeDetails:Dock(FILL)
    upgradeDetails:DockPadding(8,4,8,4)
    
    function upgradeDetails:Paint()
        return 
    end

    local upgradeHeader = vgui.Create("DLabel", upgradeDetails)
    upgradeHeader:Dock(TOP)
    upgradeHeader:SetFont("FPrinters_Printer_24_Bold")
    upgradeHeader:SetText("Capacity (" .. printer:GetCapacityUpgrade() .. "/10)")
    upgradeHeader:SizeToContents()

    function upgradeHeader:Think()
        upgradeHeader:SetText("Capacity (" .. printer:GetCapacityUpgrade() .. "/10)")
        upgradeHeader:SizeToContents()
    end

    local upgradeContent = vgui.Create("DLabel", upgradeDetails)
    upgradeContent:Dock(TOP)
    upgradeContent:SetFont("FPrinters_Printer_18")
    upgradeContent:SetText("placeholder")
    upgradeContent:SizeToContents()

    local upgrade = vgui.Create("DPanel", upgradesPanel)
    upgrade:Dock(TOP)
    upgrade:SetTall(64)
    upgrade:DockPadding(8,8,8,8)
    upgrade:DockMargin(0,4,0,4)

    function upgrade:Paint(w, h)
        surface.SetDrawColor(33,33,33,255)
        surface.DrawRect(0,0,w,h)
    end

    local upgradeIcon = vgui.Create("DPanel", upgrade)
    upgradeIcon:Dock(LEFT)
    upgradeIcon:SetTall(48)
    upgradeIcon:SetWide(48)

    function upgradeIcon:Paint(w, h)
        surface.SetDrawColor(44,44,44,255)
        surface.DrawRect(0,0,w,h)

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(coolerUpgrade)
        surface.DrawTexturedRect(4,4,w-8,h-8)
    end

    local upgradePurchase = vgui.Create("DButton", upgrade)
    upgradePurchase:Dock(RIGHT)
    upgradePurchase:SetTall(48)
    upgradePurchase:SetWide(96)
    local upgradeMoney = (printer:GetCoolerUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost
    upgradePurchase:SetText("+ ($" .. upgradeMoney .. ")")
    upgradePurchase:SetFont("FPrinters_Printer_18_Bold")

    function upgradePurchase:Paint(w, h)
        local upgradeMoney = (printer:GetCoolerUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost
        self:SetText("+ ($" .. upgradeMoney .. ")")

        if (printer:GetCoolerUpgrade() >= FPrinters.Config.Upgrades.MaxTier) then
            self:SetText("MAX")
        end

        if self:IsHovered() then
            self:SetTextColor(Color(0,0,0))
            surface.SetDrawColor(255,255,255)
        else
            self:SetTextColor(Color(255,255,255))
            surface.SetDrawColor(printer.Defaults.Color)
        end
        surface.DrawRect(0,0,w,h)
    end

    function upgradePurchase:DoClick()
        net.Start("FPrinter_UpgradeCooler")
            net.WriteEntity(printer)
        net.SendToServer()
    end

    local upgradeDetails = vgui.Create("DPanel", upgrade)
    upgradeDetails:Dock(FILL)
    upgradeDetails:DockPadding(8,4,8,4)
    
    function upgradeDetails:Paint()
        return 
    end

    local upgradeHeader = vgui.Create("DLabel", upgradeDetails)
    upgradeHeader:Dock(TOP)
    upgradeHeader:SetFont("FPrinters_Printer_24_Bold")
    upgradeHeader:SetText("Cooler (" .. printer:GetCoolerUpgrade() .. "/10)")
    upgradeHeader:SizeToContents()

    function upgradeHeader:Think()
        upgradeHeader:SetText("Cooler (" .. printer:GetCoolerUpgrade() .. "/10)")
        upgradeHeader:SizeToContents()
    end

    local upgradeContent = vgui.Create("DLabel", upgradeDetails)
    upgradeContent:Dock(TOP)
    upgradeContent:SetFont("FPrinters_Printer_18")
    upgradeContent:SetText("placeholder")
    upgradeContent:SizeToContents()

    local upgrade = vgui.Create("DPanel", upgradesPanel)
    upgrade:Dock(TOP)
    upgrade:SetTall(64)
    upgrade:DockPadding(8,8,8,8)
    upgrade:DockMargin(0,4,0,4)

    function upgrade:Paint(w, h)
        surface.SetDrawColor(33,33,33,255)
        surface.DrawRect(0,0,w,h)
    end

    local upgradeIcon = vgui.Create("DPanel", upgrade)
    upgradeIcon:Dock(LEFT)
    upgradeIcon:SetTall(48)
    upgradeIcon:SetWide(48)

    function upgradeIcon:Paint(w, h)
        surface.SetDrawColor(44,44,44,255)
        surface.DrawRect(0,0,w,h)

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(healthUpgrade)
        surface.DrawTexturedRect(4,4,w-8,h-8)
    end

    local upgradePurchase = vgui.Create("DButton", upgrade)
    upgradePurchase:Dock(RIGHT)
    upgradePurchase:SetTall(48)
    upgradePurchase:SetWide(96)
    local upgradeMoney = (printer:GetHealthUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost
    upgradePurchase:SetText("+ ($" .. upgradeMoney .. ")")
    upgradePurchase:SetFont("FPrinters_Printer_18_Bold")

    function upgradePurchase:Paint(w, h)
        local upgradeMoney = (printer:GetHealthUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost
        self:SetText("+ ($" .. upgradeMoney .. ")")

        if (printer:GetHealthUpgrade() >= FPrinters.Config.Upgrades.MaxTier) then
            self:SetText("MAX")
        end

        if self:IsHovered() then
            self:SetTextColor(Color(0,0,0))
            surface.SetDrawColor(255,255,255)
        else
            self:SetTextColor(Color(255,255,255))
            surface.SetDrawColor(printer.Defaults.Color)
        end
        surface.DrawRect(0,0,w,h)
    end

    function upgradePurchase:DoClick()
        net.Start("FPrinter_UpgradeHealth")
            net.WriteEntity(printer)
        net.SendToServer()
    end

    local upgradeDetails = vgui.Create("DPanel", upgrade)
    upgradeDetails:Dock(FILL)
    upgradeDetails:DockPadding(8,4,8,4)
    
    function upgradeDetails:Paint()
        return 
    end

    local upgradeHeader = vgui.Create("DLabel", upgradeDetails)
    upgradeHeader:Dock(TOP)
    upgradeHeader:SetFont("FPrinters_Printer_24_Bold")
    upgradeHeader:SetText("Health (" .. printer:GetHealthUpgrade() .. "/10)")
    upgradeHeader:SizeToContents()

    function upgradeHeader:Think()
        upgradeHeader:SetText("Health (" .. printer:GetHealthUpgrade() .. "/10)")
        upgradeHeader:SizeToContents()
    end

    local upgradeContent = vgui.Create("DLabel", upgradeDetails)
    upgradeContent:Dock(TOP)
    upgradeContent:SetFont("FPrinters_Printer_18")
    upgradeContent:SetText("placeholder")
    upgradeContent:SizeToContents()
end

net.Receive("FPrinter_OpenPrinter", function()
    local printer = net.ReadEntity()

    if !IsValid(printer) then return false end

    FPrinters:CreatePrinterMenu(printer)
end)