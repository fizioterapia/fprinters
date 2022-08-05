ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName		= "FPrinters Base"
ENT.Category    = "FPrinters"
ENT.Author			= "fizi"
ENT.Spawnable       = true
ENT.AdminOnly       = true


ENT.Defaults = {
	Capacity = 10000,
	HP = 200,
	PrintAmount = 500,
	Speed = 5,
    Color = Color(255,157,58)
}

function ENT:SetupDataTables()
    self:NetworkVar("Float", 1, "Money")
    self:NetworkVar("Float", 2, "Capacity")
    self:NetworkVar("Float", 3, "Temperature")
    self:NetworkVar("Float", 4, "TotalPrinted")

    self:NetworkVar("Int", 1, "HP")
    self:NetworkVar("Int", 2, "PrintAmount")
    self:NetworkVar("Int", 3, "Speed")
    self:NetworkVar("Int", 4, "SpeedUpgrade")
    self:NetworkVar("Int", 5, "CapacityUpgrade")
    self:NetworkVar("Int", 6, "CoolerUpgrade")
    self:NetworkVar("Int", 7, "HealthUpgrade")
end
