FPrinters = FPrinters or {}

local closeButton = Material("fprinters/cancel.png", "noclamp mips smooth")

function FPrinters:CreateAdminMenu()
    FPrinters.printerMenu = vgui.Create("DFrame")
    FPrinters.printerMenu:SetSize(1024, 700)
    FPrinters.printerMenu:Center()
    FPrinters.printerMenu:MakePopup()

    FPrinters.printerMenu:DockPadding(0,0,0,0)
    FPrinters.printerMenu:DockMargin(0,0,0,0)

    FPrinters.printerMenu:ShowCloseButton(false)
    FPrinters.printerMenu:SetTitle(" ")

    function FPrinters.printerMenu:Paint(w, h)
        surface.SetDrawColor(33,33,33,255)
        surface.DrawRect(0,0,w,h)

        return
    end

    local navigationBar = vgui.Create("DPanel", FPrinters.printerMenu)
    navigationBar:Dock(TOP)
    navigationBar:SetTall(48)

    function navigationBar:Paint(w, h)
        surface.SetDrawColor(44,44,44,255)
        surface.DrawRect(0,0,w,h)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawRect(0,h-2,w,2)
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
            surface.SetDrawColor(255,143,47)
        end
        surface.DrawTexturedRect(8,8,32,32)
    end

    local navigationTitle = vgui.Create("DLabel", navigationBar)
    navigationTitle:Dock(FILL)
    navigationTitle:SetText("FPrinters v1.2.1")
    navigationTitle:SizeToContents()
    navigationTitle:SetTextColor(Color(255,255,255))
    navigationTitle:SetFont("FPrinters_Printer_18_Bold")
    navigationTitle:DockMargin(8,0,0,0)

    function closeBtn:DoClick()
        FPrinters.printerMenu:Close()
    end

    local tabs = vgui.Create("DPanel", FPrinters.printerMenu)
    tabs:Dock(TOP)
    tabs:SetTall(36)
    tabs:InvalidateParent(true)

    function tabs:Paint()
        return
    end

    FPrinters.container = vgui.Create("DPanel", FPrinters.printerMenu)
    FPrinters.container:DockMargin(8,8,8,8)
    FPrinters.container:Dock(FILL)
    FPrinters.container:InvalidateParent(true)

    function FPrinters.container:Paint()
        return 
    end

    local function openConfig()
        FPrinters.container:Clear()

        local configContainer = vgui.Create("DPanel", FPrinters.container)
        configContainer:Dock(FILL)
        configContainer:DockPadding(8,8,8,8)

        function configContainer:Paint(w, h)
            surface.SetDrawColor(44,44,44)
            surface.DrawRect(0,0,w,h)
        end

        local heading = vgui.Create("DLabel", configContainer)
        heading:SetFont("FPrinters_Printer_24_Bold")
        heading:SetText(FPrinters.Phrases.Get('config'))
        heading:SetColor(Color(255,255,255))
        heading:SizeToContents()
        heading:Dock(TOP)

        local separator = vgui.Create("DPanel", configContainer)
        separator:Dock(TOP)
        separator:SetTall(2)
        separator:DockMargin(0,8,0,8)

        function separator:Paint(w, h)
            surface.SetDrawColor(180,180,180,255)
            surface.DrawRect(0,0,w,h)
        end

        local heading = vgui.Create("DLabel", configContainer)
        heading:SetFont("FPrinters_Printer_18_Bold")
        heading:SetText(FPrinters.Phrases.Get('maxprinters'))
        heading:SetColor(Color(255,255,255))
        heading:DockMargin(0,0,0,8)
        heading:Dock(TOP)
        heading:SizeToContents()

        local maxprinters = vgui.Create( "DTextEntry", configContainer )
        maxprinters:Dock(TOP)
        maxprinters:SetPlaceholderText(FPrinters.Phrases.Get("maxprintersDesc"))
        maxprinters:SetValue(FPrinters.Config.MaxPrinters)
        maxprinters:SetTall(32)

        local heading = vgui.Create("DLabel", configContainer)
        heading:SetFont("FPrinters_Printer_18_Bold")
        heading:SetText(FPrinters.Phrases.Get('language'))
        heading:SetColor(Color(255,255,255))
        heading:DockMargin(0,8,0,8)
        heading:Dock(TOP)
        heading:SizeToContents()

        local languageSelector = vgui.Create( "DComboBox", configContainer )
        languageSelector:SetTall(32)
        languageSelector:Dock(TOP)
        languageSelector:SetValue( FPrinters.Config.Phrases.Language )

        for lang,_ in pairs( FPrinters.Phrases.Data ) do
            languageSelector:AddChoice(lang)
        end

        local heading = vgui.Create("DLabel", configContainer)
        heading:SetFont("FPrinters_Printer_18_Bold")
        heading:SetText(FPrinters.Phrases.Get('upgrades'))
        heading:SetColor(Color(255,255,255))
        heading:DockMargin(0,8,0,8)
        heading:Dock(TOP)
        heading:SizeToContents()

        local btnsContainer = vgui.Create("DPanel", configContainer)
        btnsContainer:Dock(BOTTOM)
        btnsContainer:DockPadding(0,0,0,0)
        btnsContainer:SetTall(36)

        function btnsContainer:Paint()
            return 
        end

        local saveConfigButton = vgui.Create("DButton", btnsContainer)
        saveConfigButton:Dock(RIGHT)
        saveConfigButton:SetText("")

        function saveConfigButton:Paint(w,h)
            if self:IsHovered() then
                surface.SetTextColor(0,0,0)
                surface.SetDrawColor(255,255,255)
            else
                surface.SetTextColor(255,255,255)
                surface.SetDrawColor(255,143,47)
            end
            surface.DrawRect(0,0,w,h)
            surface.SetFont("FPrinters_Printer_18_Bold")
            local tw, th = surface.GetTextSize(FPrinters.Phrases.Get('saveconfig'))
            self:SetWide(tw + 16)

            surface.SetTextPos(w / 2 - tw / 2, h / 2 - th / 2)
    
            surface.DrawText(FPrinters.Phrases.Get('saveconfig'))
        end

        local upgradesContainer = vgui.Create("DPanel", configContainer)
        upgradesContainer:Dock(FILL)
        upgradesContainer:DockPadding(8,0,8,8)

        function upgradesContainer:Paint()
            return 
        end

        local heading = vgui.Create("DLabel", upgradesContainer)
        heading:SetFont("FPrinters_Printer_18")
        heading:SetText(FPrinters.Phrases.Get('starttier'))
        heading:SetColor(Color(255,255,255))
        heading:DockMargin(0,8,0,8)
        heading:Dock(TOP)
        heading:SizeToContents()

        local starttier = vgui.Create( "DTextEntry", upgradesContainer )
        starttier:Dock(TOP)
        starttier:SetPlaceholderText(FPrinters.Phrases.Get("starttierDesc"))
        starttier:SetValue(FPrinters.Config.Upgrades.StartTier)
        starttier:SetTall(32)

        local heading = vgui.Create("DLabel", upgradesContainer)
        heading:SetFont("FPrinters_Printer_18")
        heading:SetText(FPrinters.Phrases.Get('maxtier'))
        heading:SetColor(Color(255,255,255))
        heading:DockMargin(0,8,0,8)
        heading:Dock(TOP)
        heading:SizeToContents()

        local maxtier = vgui.Create( "DTextEntry", upgradesContainer )
        maxtier:Dock(TOP)
        maxtier:SetPlaceholderText(FPrinters.Phrases.Get("maxtierDesc"))
        maxtier:SetValue(FPrinters.Config.Upgrades.MaxTier)
        maxtier:SetTall(32)

        local heading = vgui.Create("DLabel", upgradesContainer)
        heading:SetFont("FPrinters_Printer_18")
        heading:SetText(FPrinters.Phrases.Get('upgradecost'))
        heading:SetColor(Color(255,255,255))
        heading:DockMargin(0,8,0,8)
        heading:Dock(TOP)
        heading:SizeToContents()

        local upgradecost = vgui.Create( "DTextEntry", upgradesContainer )
        upgradecost:Dock(TOP)
        upgradecost:SetPlaceholderText(FPrinters.Phrases.Get("upgradecostDesc"))
        upgradecost:SetValue(FPrinters.Config.Upgrades.Cost)
        upgradecost:SetTall(32)

        local heading = vgui.Create("DLabel", upgradesContainer)
        heading:SetFont("FPrinters_Printer_18")
        heading:SetText(FPrinters.Phrases.Get('upgradecostmultiplier'))
        heading:SetColor(Color(255,255,255))
        heading:DockMargin(0,8,0,8)
        heading:Dock(TOP)
        heading:SizeToContents()

        local upgrademultiplier = vgui.Create( "DTextEntry", upgradesContainer )
        upgrademultiplier:Dock(TOP)
        upgrademultiplier:SetPlaceholderText(FPrinters.Phrases.Get("upgradecostmultiplierDesc"))
        upgrademultiplier:SetValue(FPrinters.Config.Upgrades.CostMultiplier)
        upgrademultiplier:SetTall(32)

        local heading = vgui.Create("DLabel", upgradesContainer)
        heading:SetFont("FPrinters_Printer_18")
        heading:SetText(FPrinters.Phrases.Get('speedmodifier'))
        heading:SetColor(Color(255,255,255))
        heading:DockMargin(0,8,0,8)
        heading:Dock(TOP)
        heading:SizeToContents()

        local speedmodifier = vgui.Create( "DTextEntry", upgradesContainer )
        speedmodifier:Dock(TOP)
        speedmodifier:SetPlaceholderText(FPrinters.Phrases.Get("speedmodifierDesc"))
        speedmodifier:SetValue(FPrinters.Config.Upgrades.SpeedIncrease)
        speedmodifier:SetTall(32)

        function saveConfigButton:DoClick()
            local cfg = FPrinters.Config

            cfg.MaxPrinters = maxprinters:GetInt()
            
            cfg.Phrases.Language = languageSelector:GetValue()

            cfg.Upgrades.StartTier = starttier:GetInt()
            cfg.Upgrades.MaxTier = maxtier:GetInt()
            cfg.Upgrades.Cost = upgradecost:GetFloat()
            cfg.Upgrades.CostMultiplier = upgrademultiplier:GetFloat()
            cfg.Upgrades.SpeedIncrease = speedmodifier:GetFloat()

            net.Start("FPrinter_UpdateConfig")
                net.WriteTable(cfg)
            net.SendToServer()
        end
    end

    local function openPrinters()
        FPrinters.container:Clear()

        local printersPanel = vgui.Create("DPanel", FPrinters.container)
        printersPanel:SetWide(printersPanel:GetParent():GetWide() / 3)
        printersPanel:Dock(LEFT)
        printersPanel:DockMargin(0,0,8,0)
        printersPanel:DockPadding(12,12,12,12)

        function printersPanel:Paint(w,h)
            surface.SetDrawColor(44,44,44,255)
            surface.DrawRect(0,0,w,h)
        end

        local optionPanel = vgui.Create("DPanel", FPrinters.container)
        optionPanel:Dock(FILL)
        optionPanel:InvalidateParent(true)
        optionPanel:DockPadding(12,12,12,12)

        function optionPanel:Paint(w,h)
            surface.SetDrawColor(44,44,44,255)
            surface.DrawRect(0,0,w,h)
        end

        local function createHeader(header, pnl)
            local optionHeader = vgui.Create("DLabel", pnl)

            optionHeader:Dock(TOP)
            optionHeader:SetText(header)
            optionHeader:SetTextColor(Color(255,255,255))
            optionHeader:SetFont("FPrinters_Printer_24_Bold")
            optionHeader:SizeToContents()

            return optionHeader
        end

        local function openEditor(pnl, printerId)
            pnl:Clear()
            pnl.printerId = pnl.printerId
            local printer = FPrinters.Config.Printers[printerId]

            local optionHeader = createHeader(string.format(FPrinters.Phrases.Get('editprinter'), printer.Name), pnl)

            local separator = vgui.Create("DPanel", pnl)
            separator:Dock(TOP)
            separator:SetTall(2)
            separator:DockMargin(0,8,0,8)
        
            function separator:Paint(w, h)
                surface.SetDrawColor(180,180,180,255)
                surface.DrawRect(0,0,w,h)
            end

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("name"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local nameEntry = vgui.Create( "DTextEntry", pnl )
            nameEntry:Dock(TOP)
            nameEntry:SetPlaceholderText(FPrinters.Phrases.Get("nameAdminDesc"))
            nameEntry:SetValue(printer.Name)
            nameEntry:SetTall(32)

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("healthMsg"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local healthEntry = vgui.Create( "DTextEntry", pnl )
            healthEntry:Dock(TOP)
            healthEntry:SetPlaceholderText(FPrinters.Phrases.Get("healthAdminDesc"))
            healthEntry:SetValue(printer.HP)
            healthEntry:SetTall(32)

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("price"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local priceEntry = vgui.Create( "DTextEntry", pnl )
            priceEntry:Dock(TOP)
            priceEntry:SetPlaceholderText(FPrinters.Phrases.Get("priceAdminDesc"))
            priceEntry:SetValue(printer.Price)
            priceEntry:SetTall(32)

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("capacityMsg"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local capacityEntry = vgui.Create( "DTextEntry", pnl )
            capacityEntry:Dock(TOP)
            capacityEntry:SetPlaceholderText(FPrinters.Phrases.Get("capacityAdminDesc"))
            capacityEntry:SetValue(printer.Capacity)
            capacityEntry:SetTall(32)

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("speedMsg"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local speedEntry = vgui.Create( "DTextEntry", pnl )
            speedEntry:Dock(TOP)
            speedEntry:SetPlaceholderText(FPrinters.Phrases.Get("speedAdminDesc"))
            speedEntry:SetValue(printer.Speed)
            speedEntry:SetTall(32)

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("cpsMsg"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local cashEntry = vgui.Create( "DTextEntry", pnl )
            cashEntry:Dock(TOP)
            cashEntry:SetPlaceholderText(FPrinters.Phrases.Get("cpsAdminDesc"))
            cashEntry:SetValue(printer.PrintAmount)
            cashEntry:SetTall(32)

            local colorLabel = vgui.Create("DLabel", pnl)
            colorLabel:Dock(TOP)
            colorLabel:SetFont("FPrinters_Printer_18")
            colorLabel:SetText(FPrinters.Phrases.Get("colorMsg"))
            colorLabel:SetTextColor(printer.Color)
            colorLabel:DockMargin(0,4,0,4)
            colorLabel:SizeToContents()

            local colors = vgui.Create( "DColorPalette", pnl )
            colors:Dock(TOP)
            colors:SetSize( 160, 50 )
            function colors:OnValueChanged(col)
                colorLabel:SetTextColor(col)
            end

            local btnsContainer = vgui.Create("DPanel", pnl)
            btnsContainer:Dock(BOTTOM)
            btnsContainer:DockPadding(0,16,0,0)
            btnsContainer:SetTall(48)

            function btnsContainer:Paint()
                return 
            end

            local updatePrinterButton = vgui.Create("DButton", btnsContainer)
            updatePrinterButton:Dock(RIGHT)
            updatePrinterButton:SetText("")
            updatePrinterButton:DockMargin(8,0,0,0)

            function updatePrinterButton:Paint(w,h)
                if self:IsHovered() then
                    surface.SetTextColor(0,0,0)
                    surface.SetDrawColor(255,255,255)
                else
                    surface.SetTextColor(255,255,255)
                    surface.SetDrawColor(colorLabel:GetTextColor())
                end
                surface.DrawRect(0,0,w,h)
                surface.SetFont("FPrinters_Printer_18_Bold")
                local tw, th = surface.GetTextSize(FPrinters.Phrases.Get('updateprinter'))
                self:SetWide(tw + 16)

                surface.SetTextPos(w / 2 - tw / 2, h / 2 - th / 2)
        
                surface.DrawText(FPrinters.Phrases.Get('updateprinter'))
            end

            function updatePrinterButton:DoClick()
                local printerData = {
                    Name = nameEntry:GetValue(),
                    HP = healthEntry:GetInt(),
                    Capacity = capacityEntry:GetInt(),
                    Speed = speedEntry:GetInt(),
                    PrintAmount = cashEntry:GetFloat(),
                    Price = priceEntry:GetFloat(),
                    Color = colorLabel:GetTextColor()
                }

                FPrinters.Config.Printers[printerId] = printerData

                net.Start("FPrinter_UpdatePrinter")
                    net.WriteInt(printerId, 16)
                    net.WriteTable(printerData)
                net.SendToServer()

                FPrinters.printerMenu:Close()
                FPrinters:CreateAdminMenu()
            end

            local removePrinterButton = vgui.Create("DButton", btnsContainer)
            removePrinterButton:Dock(RIGHT)
            removePrinterButton:SetText("")

            function removePrinterButton:Paint(w,h)
                if self:IsHovered() then
                    surface.SetTextColor(0,0,0)
                    surface.SetDrawColor(255,255,255)
                else
                    surface.SetTextColor(255,255,255)
                    surface.SetDrawColor(255,64,64)
                end
                surface.DrawRect(0,0,w,h)
                surface.SetFont("FPrinters_Printer_18_Bold")
                local tw, th = surface.GetTextSize(FPrinters.Phrases.Get('removeprinter'))
                self:SetWide(tw + 16)

                surface.SetTextPos(w / 2 - tw / 2, h / 2 - th / 2)
        
                surface.DrawText(FPrinters.Phrases.Get('removeprinter'))
            end

            function removePrinterButton:DoClick()
                table.remove(FPrinters.Config.Printers, printerId)

                net.Start("FPrinter_RemovePrinter")
                    net.WriteInt(printerId, 16)
                net.SendToServer()

                FPrinters.printerMenu:Close()
                FPrinters:CreateAdminMenu()
            end
        end

        local function createPrinter(pnl)
            pnl:Clear()

            local optionHeader = createHeader(FPrinters.Phrases.Get('createprinter'), pnl)

            local separator = vgui.Create("DPanel", pnl)
            separator:Dock(TOP)
            separator:SetTall(2)
            separator:DockMargin(0,8,0,8)
        
            function separator:Paint(w, h)
                surface.SetDrawColor(180,180,180,255)
                surface.DrawRect(0,0,w,h)
            end

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("name"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local nameEntry = vgui.Create( "DTextEntry", pnl )
            nameEntry:Dock(TOP)
            nameEntry:SetPlaceholderText(FPrinters.Phrases.Get("nameAdminDesc"))
            nameEntry:SetTall(32)

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("healthMsg"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local healthEntry = vgui.Create( "DTextEntry", pnl )
            healthEntry:Dock(TOP)
            healthEntry:SetPlaceholderText(FPrinters.Phrases.Get("healthAdminDesc"))
            healthEntry:SetTall(32)

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("price"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local priceEntry = vgui.Create( "DTextEntry", pnl )
            priceEntry:Dock(TOP)
            priceEntry:SetPlaceholderText(FPrinters.Phrases.Get("priceAdminDesc"))
            priceEntry:SetTall(32)

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("capacityMsg"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local capacityEntry = vgui.Create( "DTextEntry", pnl )
            capacityEntry:Dock(TOP)
            capacityEntry:SetPlaceholderText(FPrinters.Phrases.Get("capacityAdminDesc"))
            capacityEntry:SetTall(32)

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("speedMsg"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local speedEntry = vgui.Create( "DTextEntry", pnl )
            speedEntry:Dock(TOP)
            speedEntry:SetPlaceholderText(FPrinters.Phrases.Get("speedAdminDesc"))
            speedEntry:SetTall(32)

            local label = vgui.Create("DLabel", pnl)
            label:Dock(TOP)
            label:SetFont("FPrinters_Printer_18")
            label:SetText(FPrinters.Phrases.Get("cpsMsg"))
            label:DockMargin(0,4,0,4)
            label:SizeToContents()

            local cashEntry = vgui.Create( "DTextEntry", pnl )
            cashEntry:Dock(TOP)
            cashEntry:SetPlaceholderText(FPrinters.Phrases.Get("cpsAdminDesc"))
            cashEntry:SetTall(32)

            local colorLabel = vgui.Create("DLabel", pnl)
            colorLabel:Dock(TOP)
            colorLabel:SetFont("FPrinters_Printer_18")
            colorLabel:SetText(FPrinters.Phrases.Get("colorMsg"))
            colorLabel:SetTextColor(Color(255,143,47))
            colorLabel:DockMargin(0,4,0,4)
            colorLabel:SizeToContents()

            local colors = vgui.Create( "DColorPalette", pnl )
            colors:Dock(TOP)
            colors:SetSize( 160, 50 )
            function colors:OnValueChanged(col)
                colorLabel:SetTextColor(col)
            end

            local btnsContainer = vgui.Create("DPanel", pnl)
            btnsContainer:Dock(BOTTOM)
            btnsContainer:DockPadding(0,16,0,0)
            btnsContainer:SetTall(48)

            function btnsContainer:Paint()
                return 
            end

            local addPrinterButton = vgui.Create("DButton", btnsContainer)
            addPrinterButton:Dock(RIGHT)
            addPrinterButton:SetText("")

            function addPrinterButton:Paint(w,h)
                if self:IsHovered() then
                    surface.SetTextColor(0,0,0)
                    surface.SetDrawColor(255,255,255)
                else
                    surface.SetTextColor(255,255,255)
                    surface.SetDrawColor(colorLabel:GetTextColor())
                end
                surface.DrawRect(0,0,w,h)
                surface.SetFont("FPrinters_Printer_18_Bold")
                local tw, th = surface.GetTextSize(FPrinters.Phrases.Get('createprinter'))
                self:SetWide(tw + 16)

                surface.SetTextPos(w / 2 - tw / 2, h / 2 - th / 2)
        
                surface.DrawText(FPrinters.Phrases.Get('createprinter'))
            end

            function addPrinterButton:DoClick()
                local printerData = {
                    Name = nameEntry:GetValue(),
                    HP = healthEntry:GetInt(),
                    Capacity = capacityEntry:GetInt(),
                    Speed = speedEntry:GetInt(),
                    PrintAmount = cashEntry:GetFloat(),
                    Price = priceEntry:GetFloat(),
                    Color = colorLabel:GetTextColor()
                }

                table.insert(FPrinters.Config.Printers, printerData)

                net.Start("FPrinter_AddPrinter")
                    net.WriteTable(printerData)
                net.SendToServer()

                FPrinters.printerMenu:Close()
                FPrinters:CreateAdminMenu()
            end
        end

        local printersHeader = vgui.Create("DLabel", printersPanel)
        printersHeader:Dock(TOP)
        printersHeader:SetText(FPrinters.Phrases.Get('printers'))
        printersHeader:SetTextColor(Color(255,255,255))
        printersHeader:SetFont("FPrinters_Printer_24_Bold")
        printersHeader:SizeToContents()

        local separator = vgui.Create("DPanel", printersPanel)
        separator:Dock(TOP)
        separator:SetTall(2)
        separator:DockMargin(0,8,0,8)

        function separator:Paint(w, h)
            surface.SetDrawColor(180,180,180,255)
            surface.DrawRect(0,0,w,h)
        end

        local addPrinterButton = vgui.Create("DButton", printersPanel)
        addPrinterButton:Dock(BOTTOM)
        addPrinterButton:SetTall(48)
        addPrinterButton:SetText("")

        function addPrinterButton:DoClick()
            createPrinter(optionPanel)
        end

        function addPrinterButton:Paint(w,h)
            if self:IsHovered() then
                surface.SetTextColor(0,0,0)
                surface.SetDrawColor(255,255,255)
            else
                surface.SetTextColor(255,255,255)
                surface.SetDrawColor(255,143,47)
            end
            surface.DrawRect(0,0,w,h)
            surface.SetFont("FPrinters_Printer_18_Bold")
            local tw, th = surface.GetTextSize(FPrinters.Phrases.Get('createprinter'))

            surface.SetTextPos(w / 2 - tw / 2, h / 2 - th / 2)

            surface.DrawText(FPrinters.Phrases.Get('createprinter'))
        end

        local printersScrollPanel = vgui.Create("DScrollPanel", printersPanel)
        printersScrollPanel:Dock(FILL)

        for id, printerData in pairs(FPrinters.Config.Printers) do
            local printer = vgui.Create("DButton", printersScrollPanel)
            printer:SetTall(40)
            printer:Dock(TOP)

            printer:SetText(printerData.Name)
            printer:SetTextColor(Color(255,255,255))
            printer:SetFont("FPrinters_Printer_18")

            function printer:Paint(w,h)
                if !self:IsHovered() then
                    surface.SetDrawColor(printerData.Color)
                else
                    surface.SetDrawColor(printerData.Color.r - 16, printerData.Color.g - 16, printerData.Color.b - 16)
                end
                surface.DrawRect(0,0,w,h)
            end

            function printer:DoClick()
                openEditor(optionPanel, id)
            end
        end

        createPrinter(optionPanel)
    end


    local printersButton = vgui.Create("DButton", tabs)
    printersButton:SetWide(tabs:GetWide() / 2)
    printersButton:Dock(LEFT)

    printersButton:SetFont("FPrinters_Printer_18")
    printersButton:SetText("Printers")
    printersButton:SetColor(Color(255,255,255))

    function printersButton:Paint(w,h)
        if !self:IsHovered() then
            surface.SetDrawColor(55,55,55)
        else
            surface.SetDrawColor(66,66,66)
        end
        surface.DrawRect(0,0,w,h)
        surface.SetDrawColor(99,99,99)
        surface.DrawRect(0,h-2,w,2)
        surface.DrawRect(w-1,0,1,h)
    end

    function printersButton:DoClick()
        openPrinters()
    end

    local configButton = vgui.Create("DButton", tabs)
    configButton:SetWide(tabs:GetWide() / 2)
    configButton:Dock(LEFT)

    configButton:SetFont("FPrinters_Printer_18")
    configButton:SetText("Config")
    configButton:SetColor(Color(255,255,255))

    function configButton:Paint(w,h)
        if !self:IsHovered() then
            surface.SetDrawColor(55,55,55)
        else
            surface.SetDrawColor(66,66,66)
        end
        surface.DrawRect(0,0,w,h)
        surface.SetDrawColor(99,99,99)
        surface.DrawRect(0,h-2,w,2)
        surface.DrawRect(0,0,1,h)
    end

    function configButton:DoClick()
        openConfig()
    end

    openPrinters()
end

concommand.Add("fprinters_admin", function(ply)
    if !ply:IsSuperAdmin() then return end

    FPrinters:CreateAdminMenu()
end)