FPrinters = FPrinters or {}

local closeButton = Material("fprinters/cancel.png", "noclamp mips smooth")

function FPrinters:CreateAdminMenu()
    FPrinters.printerMenu = vgui.Create("DFrame")
    FPrinters.printerMenu:SetSize(1024, 576)
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
            surface.SetDrawColor(255,143,47)
        end
        surface.DrawTexturedRect(8,8,32,32)
    end

    local navigationTitle = vgui.Create("DLabel", navigationBar)
    navigationTitle:Dock(FILL)
    navigationTitle:SetText("FPrinters v1.1")
    navigationTitle:SizeToContents()
    navigationTitle:SetTextColor(Color(255,255,255))
    navigationTitle:SetFont("FPrinters_Printer_18_Bold")
    navigationTitle:DockMargin(8,0,0,0)

    function closeBtn:DoClick()
        FPrinters.printerMenu:Close()
    end

    local container = vgui.Create("DPanel", FPrinters.printerMenu)
    container:DockMargin(8,8,8,8)
    container:Dock(FILL)
    container:InvalidateParent(true)

    function container:Paint()
        return 
    end

    local printersPanel = vgui.Create("DPanel", container)
    printersPanel:SetWide(printersPanel:GetParent():GetWide() / 3)
    printersPanel:Dock(LEFT)
    printersPanel:DockMargin(0,0,8,0)
    printersPanel:DockPadding(12,12,12,12)

    function printersPanel:Paint(w,h)
        surface.SetDrawColor(44,44,44,255)
        surface.DrawRect(0,0,w,h)
    end

    local optionPanel = vgui.Create("DPanel", container)
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
        btnsContainer:Dock(FILL)
        btnsContainer:DockPadding(0,16,0,0)

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
        btnsContainer:Dock(FILL)
        btnsContainer:DockPadding(0,16,0,0)

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

concommand.Add("fprinters_admin", function(ply)
    if !ply:IsSuperAdmin() then return end

    FPrinters:CreateAdminMenu()
end)