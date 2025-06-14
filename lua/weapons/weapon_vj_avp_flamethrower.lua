SWEP.Base 						= "weapon_vj_avp_base"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Category					= "VJ Base - Aliens vs Predator"

sound.Add({
	name = "AVP.Flamethrower.Fluid",
	sound = {"cpthazama/avp/weapons/human/flamethrower/flamethrower_fluid_movement_01.ogg","cpthazama/avp/weapons/human/flamethrower/flamethrower_fluid_movement_02.ogg","cpthazama/avp/weapons/human/flamethrower/flamethrower_fluid_movement_03.ogg","cpthazama/avp/weapons/human/flamethrower/flamethrower_fluid_movement_04.ogg"},
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})
sound.Add({
	name = "AVP.Flamethrower.Latch",
	sound = {"cpthazama/avp/weapons/human/flamethrower/flamethrower_reload_latch_01.ogg","cpthazama/avp/weapons/human/flamethrower/flamethrower_reload_latch_02.ogg"},
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})
sound.Add({
	name = "AVP.Flamethrower.LatchClose",
	sound = "cpthazama/avp/weapons/human/flamethrower/flamethrower_reload_latch_close_01.ogg",
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})
sound.Add({
	name = "AVP.Flamethrower.ClipOut",
	sound = "cpthazama/avp/weapons/human/flamethrower/flamethrower_unload_bottle_01.ogg",
	channel = CHAN_STATIC,
	volume = 1,
	level = 65,
})

if CLIENT then
	SWEP.Slot						= 2
	SWEP.SlotPos					= 4
end

SWEP.PrintName					= "M260B Flamethrower"
SWEP.ViewModel					= "models/cpthazama/avp/weapons/hud_flamethrower.mdl"
SWEP.WorldModel					= "models/cpthazama/avp/weapons/w_flamethrower.mdl"
SWEP.HoldType 					= "ar2"
SWEP.Spawnable					= true

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(-12, 0, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, 3.75, 0.3)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_R_Hand"

SWEP.HasMotionTracker			= true
SWEP.PrimaryEffects_MuzzleParticles = {"vj_avp_muzzle_ft"}

SWEP.Primary.Damage				= 3
SWEP.Primary.ClipSize			= 250
SWEP.Primary.RPM				= 900
SWEP.Primary.AccurateRange		= 250
SWEP.Primary.Automatic			= true
SWEP.Primary.Ammo				= "Uranium"
SWEP.Primary.Delay				= 60 /SWEP.Primary.RPM
SWEP.Primary.Cone				= 35
SWEP.Primary.Recoil				= 0.25
SWEP.NPC_NextPrimaryFire 		= SWEP.Primary.Delay *(SWEP.Primary.Automatic == false && 3.5 or 0.9)
-- SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.Primary.DisableBulletCode 	= true

SWEP.NPC_FiringDistanceScale = 0.1

SWEP.AnimTbl_PrimaryFire 		= {ACT_VM_PRIMARYATTACK}
SWEP.AnimTbl_SecondaryFire 		= false

SWEP.Primary.UsesLoopedSound 	= true
SWEP.Primary.Sound 				= {"cpthazama/avp/weapons/human/flamethrower/flamethrower_flame_loop_01.wav"}
SWEP.Primary.StartSound 		= {"cpthazama/avp/weapons/human/flamethrower/flamethrower_flame_on_01.ogg"}
SWEP.Primary.EndSound 			= {"cpthazama/avp/weapons/human/flamethrower/flamethrower_flame_off_01.ogg"}

SWEP.ViewModelAdjust = {
	Pos = {Right = 0,Forward = 0,Up = 0},
	Ang = {Right = 0,Up = 0,Forward = 0}
}
---------------------------------------------------------------------------------------------------------------------------------------------
local IsProp = VJ.IsProp
--
function SWEP:OnShoot()
	local owner = self:GetOwner()
	sound.EmitHint(SOUND_DANGER, owner:GetPos() +owner:GetAimVector() *(self.Primary.AccurateRange /2), self.Primary.AccurateRange *2, 0.2, owner)
	VJ.ApplyRadiusDamage(owner,self,(owner:GetPos() +(self:GetForward() *owner:OBBMaxs().y)),self.Primary.AccurateRange,self.Primary.Damage,DMG_BURN,true,false,{UseConeDegree=self.Primary.Cone,UseConeDirection=owner:GetAimVector()}, function(ent) if !ent:IsOnFire() && (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() or IsProp(ent)) then ent:Ignite(10) end end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:AddVars()
	self:NetworkVar("Bool", 2, "Flame")
	self:NetworkVar("Entity", 0, "FlameAtt")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnMeleeHit(entities,hitType,owner)
	self:EmitSound("AVP.Flamethrower.Fluid")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnInit()
	if CLIENT then
		hook.Add("PostDrawViewModel",self, function(self,vm, ply, weapon)
			if !IsValid(weapon) or weapon != self then return end

			local bone = vm:LookupBone("flamethrower")
			if !bone then return end

			local pos, ang = vm:GetBonePosition(bone)
			pos = pos +ang:Right() *3.65 + ang:Forward() *-1.12 + ang:Up() *6.88
			ang:RotateAroundAxis(ang:Right(), 100)
			ang:RotateAroundAxis(ang:Forward(), 0)
			ang:RotateAroundAxis(ang:Up(), 179)

			cam.Start3D2D(pos, ang, 0.011)
				draw.SimpleTextOutlined("00", "VJFont_AVP_Ammo",0, 0,Color(199,250,255,25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0, 0, 0))
				draw.SimpleTextOutlined(weapon:Clip1(), "VJFont_AVP_AmmoBlur",0, 0,Color(199,250,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0, 0, 0))
				draw.SimpleTextOutlined(weapon:Clip1(), "VJFont_AVP_Ammo",0, 0,Color(199,250,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER,1, Color(0, 0, 0))
			cam.End3D2D()
		end)
		return
	end
	local pos = self:GetPos()
	pos = pos +self:GetUp() *18 +self:GetRight() *10
	local ang = self:GetAngles()
	-- ang.y = ang.y +180
	local fake = ents.Create("prop_vj_animatable")
	fake:SetModel("models/weapons/w_smg1.mdl")
	fake:SetPos(pos)
	fake:SetAngles(ang)
	fake:Spawn()
	fake:Activate()
	fake:SetParent(self)
	fake:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	fake:SetSolid(SOLID_NONE)
	fake:SetNoDraw(true)
	fake:DrawShadow(false)
	self:DeleteOnRemove(fake)
	self:SetFlameAtt(fake)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnThink2(owner)
	local lastFire = self:GetLastFire()
	self:SetFlame(lastFire > 0 && CurTime() < lastFire +0.25)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PostDrawViewModel(vm,weapon,ply)
	if IsValid(vm) then
		local att = vm:GetAttachment(vm:LookupAttachment("muzzle"))
		if att then
			local pos = att.Pos
			local ang = att.Ang
			local dLight = DynamicLight(vm:EntIndex())
			if (dLight) then
				if self:GetFlame() then
					dLight.pos = pos
					dLight.r = 255
					dLight.g = 150
					dLight.b = 0
					dLight.brightness = 4
					dLight.Decay = 1000
					dLight.Size = 300
					dLight.DieTime = CurTime() +0.1
				else
					dLight.pos = pos
					dLight.r = 0
					dLight.g = 150
					dLight.b = 255
					dLight.brightness = 1
					dLight.Decay = 1000
					dLight.Size = 75
					dLight.DieTime = CurTime() +0.1
				end
			end
		end
	end

	if self:GetFlame() then
		if !IsValid(self.Flame) then
			self.Flame = CreateParticleSystem(vm,"vj_avp_flamethrower",PATTACH_POINT_FOLLOW,vm:LookupAttachment("muzzle"))
			self.Flame:StartEmission()
		end
	else
		if IsValid(self.Flame) then
			self.Flame:StopEmission()
			self.Flame = nil
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnDrawWorldModel()
	local owner = self:GetOwner()
	if !IsValid(owner) then return end

	local att = self:GetAttachment(self:LookupAttachment("muzzle"))
	if att then
		local pos = att.Pos
		local ang = att.Ang
		local dLight = DynamicLight(self:EntIndex())
		if (dLight) then
			dLight.pos = pos
			dLight.r = 0
			dLight.g = 150
			dLight.b = 255
			dLight.brightness = 1
			dLight.Decay = 1000
			dLight.Size = 75
			dLight.DieTime = CurTime() +0.1
		end
	end

	if self:GetFlame() then
		if !IsValid(self.Flame) then
			self.Flame = CreateParticleSystem(self:GetFlameAtt() or owner,"vj_avp_flamethrower",PATTACH_POINT_FOLLOW,self:LookupAttachment("muzzle"))
			self.Flame:StartEmission()
		end
	else
		if IsValid(self.Flame) then
			self.Flame:StopEmission()
			self.Flame = nil
		end
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:WhenDropped()
	self:SetFlame(false)
	if IsValid(self.Flame) then
		self.Flame:StopEmission()
		self.Flame = nil
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnNewOwner(owner)
	self:SetFlame(false)
	if IsValid(self.Flame) then
		self.Flame:StopEmission()
		self.Flame = nil
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnNoOwner()
	self:SetFlame(false)
	if IsValid(self.Flame) then
		self.Flame:StopEmission()
		self.Flame = nil
	end
end