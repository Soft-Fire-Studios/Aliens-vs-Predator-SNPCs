AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "Xenomorph Restraint"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Category		= "Aliens vs Predator"
ENT.AutomaticFrameAdvance = true
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
local xenoClass = {
	"npc_vj_avp_xeno_warrior",
	"npc_vj_avp_xeno_drone",
	"npc_vj_avp_xeno_jungle",
	"npc_vj_avp_xeno_runner",
	"npc_vj_avp_xeno_ridged",
}
--
function ENT:Initialize()
	self:SetModel("models/cpthazama/avp/misc/alien_restraint.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self.Lights = {}
	self.Glows = {}
	for i = 1,3 do
		local light = ents.Create("light_dynamic")
		light:SetKeyValue("brightness", "2")
		light:SetKeyValue("distance", "200")
		light:SetLocalPos(self:GetPos())
		light:SetLocalAngles(self:GetAngles())
		light:Fire("Color", "155 155 255")
		light:SetParent(self)
		light:Spawn()
		light:Activate()
		light:Fire("SetParentAttachment", "light" .. i, 0)
		self:DeleteOnRemove(light)

		local glow1 = ents.Create("env_sprite")
		glow1:SetKeyValue("model","vj_base/sprites/glow.vmt")
		glow1:SetKeyValue("scale","0.25")
		glow1:SetKeyValue("rendermode","9")
		glow1:SetKeyValue("rendercolor","155 155 255")
		glow1:SetKeyValue("spawnflags","0.1")
		glow1:SetParent(self)
		glow1:SetOwner(self)
		glow1:Fire("SetParentAttachment","light" .. i,0)
		glow1:Spawn()
		self:DeleteOnRemove(glow1)

		table.insert(self.Lights,light)
		table.insert(self.Glows,glow1)
	end
	timer.Simple(0,function()
		if IsValid(self) then
			local class = self.XenoClass or VJ.PICK(xenoClass)
			local xeno = ents.Create(class)
			xeno:SetPos(self:GetPos())
			if class == "npc_vj_avp_xeno_runner" or class == "npc_vj_avp_xeno_jungle" then
				xeno:SetPos(self:GetPos() +self:GetUp() *12)
			end
			xeno:SetAngles(self:GetAngles())
			xeno:SetOwner(self)
			xeno:SetParent(self)
			xeno:Spawn()
			xeno:Activate()
			xeno.CanSetGroundAngle = false
			xeno.Restraint = self
			self.Xeno = xeno
			timer.Simple(0,function()
				if IsValid(self) && IsValid(xeno) then
					xeno:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
					xeno:AddFlags(FL_NOTARGET)
					xeno:SetMaxYawSpeed(0)
					xeno.CanSetGroundAngle = false
					xeno.PoseParameterLooking_Names = {
						pitch = {"head_pitch"},
						yaw = {"head_yaw"},
						roll={}
					}
				end
			end)

			local rc = ents.Create("sent_vj_avp_battery")
			rc:SetPos(self:GetPos() +self:GetForward() *35 +self:GetRight() *60)
			rc:SetAngles(self:GetAngles())
			rc:Spawn()
			rc:SetLinkedObject(self)
			self.RC = rc
			self:DeleteOnRemove(rc)
		end
	end)

	self:SetNW2Bool("AVP.IsTech",true)
	self.VJ_AVP_IsTech = true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	local curTime = CurTime()

	if IsValid(self.Xeno) then
		self.Xeno.RoyalMorphT = CurTime() +600
		self:ResetSequence(self:LookupSequence("idle"))
	end
	self:NextThink(CurTime())
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeviceEffected(rc,efType)
	if efType == 1 then -- Turned on
		self.Lights = {}
		self.Glows = {}
		for i = 1,3 do
			local light = ents.Create("light_dynamic")
			light:SetKeyValue("brightness", "2")
			light:SetKeyValue("distance", "200")
			light:SetLocalPos(self:GetPos())
			light:SetLocalAngles(self:GetAngles())
			light:Fire("Color", "155 155 255")
			light:SetParent(self)
			light:Spawn()
			light:Activate()
			light:Fire("SetParentAttachment", "light" .. i, 0)
			self:DeleteOnRemove(light)
	
			local glow1 = ents.Create("env_sprite")
			glow1:SetKeyValue("model","vj_base/sprites/glow.vmt")
			glow1:SetKeyValue("scale","0.25")
			glow1:SetKeyValue("rendermode","9")
			glow1:SetKeyValue("rendercolor","155 155 255")
			glow1:SetKeyValue("spawnflags","0.1")
			glow1:SetParent(self)
			glow1:SetOwner(self)
			glow1:Fire("SetParentAttachment","light" .. i,0)
			glow1:Spawn()
			self:DeleteOnRemove(glow1)
	
			table.insert(self.Lights,light)
			table.insert(self.Glows,glow1)
		end
	elseif efType == 2 or efType == 3 then -- Turned off/drained
		for _,v in ipairs(self.Lights) do
			SafeRemoveEntity(v)
		end
		for _,v in ipairs(self.Glows) do
			SafeRemoveEntity(v)
		end
		if IsValid(self.Xeno) then
			local xeno = self.Xeno
			xeno.Restraint = nil
			xeno:SetOwner(self)
			xeno:SetParent(NULL)
			xeno:VJ_ACT_PLAYACTIVITY("Constraints_Release_Agressive",true,false,false,0,{OnFinish=function()
				xeno.CanSetGroundAngle = true
				xeno:SetState()
				xeno:RemoveFlags(FL_NOTARGET)
				xeno:SetMaxYawSpeed(xeno.TurningSpeed)
			end})
			self:ResetSequence(self:LookupSequence("release"))
			self:ResetSequenceInfo()
			self:SetCycle(0)
			self:SetPlaybackRate(1)
			self.Xeno = nil
			-- SafeRemoveEntityDelayed(self,120)
		end
	elseif efType == 4 then -- Destroyed
		local fx = EffectData()
		fx:SetOrigin(rc:GetAttachment(1).Pos)
		fx:SetScale(2)
		fx:SetMagnitude(2)
		fx:SetNormal(self:GetUp())
		util.Effect("ElectricSpark",fx)
		for i = 1,16 do
			util.Effect("GlassImpact",fx)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self:StopParticles()
	SafeRemoveEntity(self.Xeno)
end