include( "shared.lua" )

local x0 = -152
local y0 = -163
local x1 = 310
local y1 = 312

local fan = Material( "fprinters/fan.png", "noclamp smooth")
local id = Material( "fprinters/id-card.png", "noclamp smooth")
local temp = Material( "fprinters/thermometer.png", "noclamp smooth")

function surface.DrawTexturedRectRotatedPoint( x, y, w, h, rot, x0, y0 )
	local c = math.cos( math.rad( rot ) )
	local s = math.sin( math.rad( rot ) )
	
	local newx = y0 * s - x0 * c
	local newy = y0 * c + x0 * s
	
	surface.DrawTexturedRectRotated( x + newx, y + newy, w, h, rot )
end

function ENT:Draw()
    self:SetColor(self.Defaults.Color)
    self:DrawModel()

    local pos = self:LocalToWorld(
        Vector(0,0,11)
    )

    local angles = self:LocalToWorldAngles(
        Angle(0,90,0)
    )

    cam.Start3D2D(pos, angles, 0.1)
        surface.SetDrawColor(31,31,31)
        surface.DrawRect(x0,y0,x1,y1)

        surface.SetDrawColor(self.Defaults.Color)
        draw.NoTexture()
        surface.DrawPoly({
            { x = x0, y = y0 + y1 },
            { x = x0 + (x1 / 2), y = (y0 + y1) - 190},
            { x = x0 + x1, y = (y0 + y1) - 260},
            { x = x0 + x1, y = y0 + y1 },
        })

        surface.SetMaterial(id)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(x0 + 8, y0 + 8, 48, 40)
        local owner = self:CPPIGetOwner():Name() or "disconnected"
        draw.SimpleText(owner, "FPrinters_Printer_18", x0 + 64, y0 + 27, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        surface.SetMaterial(temp)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRect(x0 + 8, y0 + 48, 40, 40)
        draw.SimpleText(tostring(self:GetTemperature()) .. "°c", "FPrinters_Printer_18", x0 + 64, y0 + 66, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        draw.SimpleText(self.PrintName, "FPrinters_Printer_24_Bold", x0 + (x1 / 2), y0 + (y1 / 2) - 11, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("$" .. self:GetMoney(), "FPrinters_Printer_18", x0 + (x1 / 2), y0 + (y1 / 2) + 11, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        draw.RoundedBox(4, x0 + x1 - 88, y0 + y1 - 88, 80, 80, Color(31,31,31))
        surface.SetMaterial(fan)
        surface.SetDrawColor(255,255,255,255)
        surface.DrawTexturedRectRotatedPoint(x0 + x1 - 48, y0 + y1 - 48, 64, 64, (CurTime() * 60) % 360, 0, 0)
    cam.End3D2D()
end