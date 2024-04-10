AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "RC Controller"
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
	self:NetworkVar("Entity",0,"LinkedObject")
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
	self:SetModel("models/cpthazama/avp/misc/rc_controller.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	-- local light = ents.Create("light_dynamic")
	-- light:SetKeyValue("brightness", "2")
	-- light:SetKeyValue("distance", "100")
	-- light:SetLocalPos(self:GetPos())
	-- light:SetLocalAngles(self:GetAngles())
	-- light:Fire("Color", "155 155 255")
	-- light:SetParent(self)
	-- light:Spawn()
	-- light:Activate()
	-- light:Fire("SetParentAttachment", "fx", 0)
	-- self:DeleteOnRemove(light)
	-- self.Light = light

	self.IsOn = true

	self:SetActive(true)
	self:SetNW2Bool("AVP.IsTech",true)
	self.VJ_AVP_IsTech = true

	-- timer.Simple(3,function() self:DrainBattery() end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Use(ent)
	if !self:GetActive() then return end
	local linkedObj = self:GetLinkedObject()
	if ent:IsPlayer() && IsValid(linkedObj) && ent:Alive() && !IsValid(ent:GetObserverTarget()) then
		if linkedObj.OnDeviceEffected then
			ent:ChatPrint(self.IsOn && "The Sentry Gun has been turned off." or "The Sentry Gun has been turned on.")
			linkedObj:OnDeviceEffected(self,self.IsOn && 2 or 1)
			self.IsOn = !self.IsOn
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DestroyObject()
	self.IsOn = false
	self:SetActive(false)

	local linkedObj = self:GetLinkedObject()
	if IsValid(linkedObj) && linkedObj.OnDeviceEffected then
		linkedObj:OnDeviceEffected(self,4)
	end

	VJ.EmitSound(self,"cpthazama/avp/shared/battery_terminal_electricity_01.ogg",80)
	ParticleEffectAttach("vj_avp_rc_battery_sap",PATTACH_POINT_FOLLOW,self,1)
	timer.Simple(6,function()
		if IsValid(self) then
			self:StopParticles()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	self:NextThink(CurTime())
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self:StopParticles()
	-- VJ.STOPSOUND(self.fireLoopSD)
end