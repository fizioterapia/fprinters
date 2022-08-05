AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Setup()
	self:SetCapacity(self.Defaults.Capacity)
	self:SetHP(self.Defaults.HP)
	self:SetPrintAmount(self.Defaults.PrintAmount)
	self:SetSpeed(self.Defaults.Speed)

	self:SetMoney(0)
	self:SetTemperature(0)
	self:SetTotalPrinted(0)
	self:SetSpeedUpgrade(FPrinters.Config.Upgrades.StartTier)
	self:SetCapacityUpgrade(FPrinters.Config.Upgrades.StartTier)
	self:SetCoolerUpgrade(FPrinters.Config.Upgrades.StartTier)
	self:SetHealthUpgrade(FPrinters.Config.Upgrades.StartTier)
end

function ENT:Initialize()
	self:SetModel( "models/props_c17/consolebox01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )

    local physObj = self:GetPhysicsObject()
	if ( physObj:IsValid() ) then
		physObj:Wake()
	end

	self:Setup()
	self:PrintMoney()
end

function ENT:Open(ply)
    net.Start("FPrinter_OpenPrinter")
		net.WriteEntity(self)
	net.Send(ply)
end

function ENT:Use( ply )
	self:Open(ply)
end

function ENT:CheckTemperature()
	if self:GetTemperature() > 80 then
		self:SetTemperature(self:GetTemperature() - math.random(1,2 + (2 * (self:GetCoolerUpgrade() - 1))))
		return false
	else
		self:SetTemperature(self:GetTemperature() + math.random(1,2 + (2 * (self:GetSpeedUpgrade() - 1))))
		return true
	end
end

function ENT:PrintMoney()
	if self:GetMoney() > self:GetCapacity() then return false end

	if self:CheckTemperature() then
		local money = math.min(self:GetMoney() + self:GetPrintAmount(), self:GetCapacity())

		self:SetTotalPrinted(self:GetTotalPrinted() + (money - self:GetMoney()))
		self:SetMoney(money)
	end

	timer.Simple(self:GetSpeed(), function()
		if IsValid(self) then
			self:PrintMoney()
		end
	end)
end

function ENT:StartSound()
    self.sound = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
    self.sound:SetSoundLevel(52)
    self.sound:PlayEx(1, 100)
end

function ENT:OnTakeDamage(dmg)
    self:TakePhysicsDamage(dmg)

    self:SetHP(self:GetHP() - dmg:GetDamage())
    if self:GetHP() <= 0 then
        self:Remove()
    end
end

function ENT:Think()
    if self:WaterLevel() > 0 then
        self:Remove()
        return
    end
    self:StartSound()
end

function ENT:OnRemove()
    if self.sound then
        self.sound:Stop()
    end
end

function ENT:Collect(ply)
	local nearbyEntities = ents.FindInSphere(self:GetPos(), 512)
	if !table.HasValue(nearbyEntities, ply) then 
		return 
	end

	ply:addMoney(self:GetMoney())

	DarkRP.notify(ply, 0, 10, "You have succesfully collected $" .. self:GetMoney() .. ".")
	self:SetMoney(0)
end

function ENT:UpgradeSpeed(ply)
	local upgradeMoney = (self:GetSpeedUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost

	if !ply:canAfford(upgradeMoney) then 
		DarkRP.notify(ply, 1, 10, "You don't have enough money to purchase this upgrade.")
		return false 
	end
	if self:GetSpeedUpgrade() >= 10 then 
		DarkRP.notify(ply, 1, 10, "You have already the biggest tier of this upgrade.")
		return false 
	end

	self:SetSpeedUpgrade(self:GetSpeedUpgrade() + 1)
	self:SetSpeed(self.Defaults.Speed - (self:GetSpeedUpgrade() * FPrinters.Config.Upgrades.SpeedIncrease))
	ply:addMoney(-upgradeMoney)

	DarkRP.notify(ply, 0, 10, "You have succesfully purchased this upgrade.")
end

function ENT:UpgradeCapacity(ply)
	local upgradeMoney = (self:GetCapacityUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost

	if !ply:canAfford(upgradeMoney) then 
		DarkRP.notify(ply, 1, 10, "You don't have enough money to purchase this upgrade.")
		return false 
	end
	if self:GetCapacityUpgrade() >= 10 then 
		DarkRP.notify(ply, 1, 10, "You have already the biggest tier of this upgrade.")
		return false 
	end

	self:SetCapacityUpgrade(self:GetCapacityUpgrade() + 1)
	self:SetCapacity(self.Defaults.Capacity * self:GetCapacityUpgrade())
	ply:addMoney(-upgradeMoney)

	DarkRP.notify(ply, 0, 10, "You have succesfully purchased this upgrade.")
end

function ENT:UpgradeCooler(ply)
	local upgradeMoney = (self:GetCoolerUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost

	if !ply:canAfford(upgradeMoney) then 
		DarkRP.notify(ply, 1, 10, "You don't have enough money to purchase this upgrade.")
		return false 
	end
	if self:GetCoolerUpgrade() >= 10 then 
		DarkRP.notify(ply, 1, 10, "You have already the biggest tier of this upgrade.")
		return false 
	end

	self:SetCoolerUpgrade(self:GetCoolerUpgrade() + 1)
	ply:addMoney(-upgradeMoney)

	DarkRP.notify(ply, 0, 10, "You have succesfully purchased this upgrade.")
end

function ENT:UpgradeHealth(ply)
	local upgradeMoney = (self:GetHealthUpgrade() + 1) * FPrinters.Config.Upgrades.CostMultiplier * FPrinters.Config.Upgrades.Cost

	if !ply:canAfford(upgradeMoney) then 
		DarkRP.notify(ply, 1, 10, "You don't have enough money to purchase this upgrade.")
		return false 
	end
	if self:GetHealthUpgrade() >= 10 then 
		DarkRP.notify(ply, 1, 10, "You have already the biggest tier of this upgrade.")
		return false 
	end

	self:SetHealthUpgrade(self:GetHealthUpgrade() + 1)
	self:SetHP(self.Defaults.HP * self:GetHealthUpgrade())
	ply:addMoney(-upgradeMoney)

	DarkRP.notify(ply, 0, 10, "You have succesfully purchased this upgrade.")
end