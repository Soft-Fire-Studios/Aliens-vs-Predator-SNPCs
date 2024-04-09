AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "RC Battery"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= ""
ENT.Instructions 	= ""
ENT.Category		= "Aliens vs Predator"

ENT.Spawnable = false
ENT.AdminOnly = false
ENT.AutomaticFrameAdvance = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Active")
	self:NetworkVar("Int",0,"RechargeTime")
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
	
	function ENT:DrawTranslucent()
		self:Draw()
	end
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/cpthazama/avp/misc/rc_battery.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local light = ents.Create("light_dynamic")
	light:SetKeyValue("brightness", "2")
	light:SetKeyValue("distance", "100")
	light:SetLocalPos(self:GetPos())
	light:SetLocalAngles(self:GetAngles())
	light:Fire("Color", "155 155 255")
	light:SetParent(self)
	light:Spawn()
	light:Activate()
	light:Fire("SetParentAttachment", "light", 0)
	self:DeleteOnRemove(light)
	self.Light = light

	self:SetBattery(true)
	self.BatteryLife = 100
	self.BatteryRestoreT = 0
	self.BatteryRestoreDelayT = 0
	self.BatteryFlashT = 0

	-- timer.Simple(3,function() self:DrainBattery() end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Use(ent)
	if ent:IsPlayer() && ent:Alive() && !IsValid(ent:GetObserverTarget()) && ent:Armor() < ent:GetMaxArmor() then
		self.BatteryLife = math.Clamp(self.BatteryLife -10,0,100)
		ent:SetArmor(math.Clamp(ent:Armor() +10,0,ent:GetMaxArmor() or 100))
		self.BatteryRestoreDelayT = CurTime() +15
		ent:ChatPrint("Restored 10% of your suit battery.")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DrainBattery() -- Drain the entire battery
	self.BatteryLife = 0
	self.BatteryRestoreDelayT = CurTime() +30

	VJ.EmitSound(self,"cpthazama/avp/shared/battery_terminal_electricity_01.ogg",80)
	ParticleEffectAttach("vj_avp_rc_battery_sap",PATTACH_POINT_FOLLOW,self,1)
	timer.Simple(6,function()
		if IsValid(self) then
			self:StopParticles()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetBattery(battery) -- Called when we remove the battery entirely or put a new one in
	self:StopParticles()
	if battery then
		self:SetActive(true)
		self.Light:Fire("TurnOn","",0)
		self.BatteryLife = 100
		sound.Play("cpthazama/avp/shared/electricity_battery_insert_01.ogg",self:GetPos(),70)
		VJ.EmitSound(self,"cpthazama/avp/shared/electricity_power_up_01.ogg",70)
		return
	end
	self:SetActive(false)
	self.Light:Fire("TurnOff","",0)
	self.BatteryLife = 0
	VJ.EmitSound(self,"cpthazama/avp/shared/electricity_power_down_01.ogg",70)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	local curTime = CurTime()
	local batteryBG = self:GetBodygroup(self:FindBodygroupByName("battery"))

	if batteryBG == 1 && self:GetActive() then
		self:SetBattery(false)
		return
	elseif batteryBG == 0 && !self:GetActive() then
		self:SetBattery(true)
		return
	end

	if self:GetActive() then
		if self.BatteryLife <= 0 then
			self.Light:Fire("Color","255 0 0")
			if curTime > self.BatteryFlashT then
				self.Light:Fire("TurnOff","",0)
				timer.Simple(0.25,function()
					if IsValid(self) then
						self.Light:Fire("TurnOn","",0)
						VJ.EmitSound(self,"cpthazama/avp/shared/laptop_error_beep_01.ogg",70)
					end
				end)
				self.BatteryFlashT = curTime +0.5
			end
		else
			self.Light:Fire("Color","155 155 255")
		end
		if self.BatteryLife < 100 && curTime > self.BatteryRestoreT then
			if curTime < self.BatteryRestoreDelayT then return end
			if self.BatteryLife <= 0 then
				VJ.EmitSound(self,"cpthazama/avp/shared/electricity_power_up_01.ogg",70)
			end
			self.BatteryLife = math.Clamp(self.BatteryLife +1,0,100)
			self.BatteryRestoreT = curTime +0.2
		end
	end

	self:NextThink(CurTime())
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self:StopParticles()
	-- VJ.STOPSOUND(self.fireLoopSD)
end