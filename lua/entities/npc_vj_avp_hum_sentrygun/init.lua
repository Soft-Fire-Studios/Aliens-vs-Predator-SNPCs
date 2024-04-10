AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/misc/sentry_gun.mdl"}
ENT.StartHealth = 350
ENT.SightDistance = 4000
ENT.SightAngle = 70
ENT.MovementType = VJ_MOVETYPE_STATIONARY
ENT.CanTurnWhileStationary = false

ENT.PoseParameterLooking_InvertPitch = true
ENT.PoseParameterLooking_InvertYaw = true

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
ENT.FriendsWithAllPlayerAllies = true
ENT.AlertedToIdleTime = VJ.SET(2.5, 2.5)
ENT.HasMeleeAttack = false

ENT.HasRangeAttack = true
ENT.DisableDefaultRangeAttackCode = true
ENT.DisableRangeAttackAnimation = true
ENT.RangeDistance = 4000
ENT.RangeToMeleeDistance = 1
ENT.RangeAttackAngleRadius = 75
ENT.TimeUntilRangeAttackProjectileRelease = 0
ENT.NextRangeAttackTime = 0
ENT.NextAnyAttackTime_Range = 0.01

ENT.Medic_CanBeHealed = false

ENT.SoundTbl_Impact = {"ambient/energy/spark1.wav","ambient/energy/spark2.wav","ambient/energy/spark3.wav","ambient/energy/spark4.wav"}
ENT.SoundTbl_Death = {"cpthazama/avp/weapons/sentry guns/sentry_gun_destroyed_01.ogg"}

local sdFiring = {"^cpthazama/avp/weapons/sentry guns/sentry gun burst 01.ogg","^cpthazama/avp/weapons/sentry guns/sentry gun burst 02.ogg","^cpthazama/avp/weapons/sentry guns/sentry gun burst 03.ogg"}

ENT.Turret_HasLOS = false
ENT.Turret_CurrentParameter = 0
ENT.Turret_ScanDirSide = 0
ENT.Turret_ScanDirUp = 0
ENT.Turret_NextScanBeepT = 0
ENT.Turret_ControllerStatus = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	-- self:SetCollisionBounds(Vector(13, 13, 63), Vector(-13, -13, 0))
	self.turret_idlesd = CreateSound(self, "cpthazama/avp/weapons/sentry guns/sentry_mechanical_loop.wav") 
	self.turret_idlesd:SetSoundLevel(60)
	self.turret_idlesd:PlayEx(1, 100)

	local att = self:LookupAttachment("scan")
	if att > 0 then
        local spotlight = ents.Create("beam_spotlight")
        spotlight:SetPos(self:GetPos())
        spotlight:SetAngles(self:GetAngles())
        spotlight:SetKeyValue("spotlightlength",250)
        spotlight:SetKeyValue("spotlightwidth",80)
        spotlight:Fire("Color","0 161 255")
        spotlight:SetParent(self)
        spotlight:Spawn()
        spotlight:Activate()
		spotlight:Fire("setparentattachment","scan")
        spotlight:Fire("lighton")
		spotlight:AddEffects(EF_PARENT_ANIMATES)
        self:DeleteOnRemove(spotlight)
		self.Spotlight = spotlight
	
		local envLight = ents.Create("env_projectedtexture")
		envLight:SetLocalPos(self:GetPos())
		envLight:SetLocalAngles(self:GetAngles())
		envLight:SetKeyValue("lightcolor","0 161 255")
		envLight:SetKeyValue("lightfov","70")
		envLight:SetKeyValue("farz","1000")
		envLight:SetKeyValue("nearz","10")
		envLight:SetKeyValue("shadowquality","1")
		envLight:Input("spotlighttexture",NULL,NULL,"effects/avp/sentry_light")
		envLight:SetOwner(self)
		envLight:SetParent(self)
		envLight:Spawn()
		envLight:Fire("setparentattachment","scan")
		envLight:AddEffects(EF_PARENT_ANIMATES)
		self:DeleteOnRemove(envLight)
		self.ProjectedTexture = envLight

		-- local glow1 = ents.Create("env_sprite")
		-- glow1:SetKeyValue("model","sprites/light_glow02_add.vmt")
		-- glow1:SetKeyValue("scale","0.2")
		-- glow1:SetKeyValue("rendermode","9")
		-- glow1:SetKeyValue("rendercolor","0 161 255")
		-- glow1:SetKeyValue("spawnflags","0.1")
		-- glow1:SetParent(self)
		-- glow1:SetOwner(self)
		-- glow1:Fire("SetParentAttachment","scan",0)
		-- glow1:AddEffects(EF_PARENT_ANIMATES)
		-- glow1:Spawn()
		-- self:DeleteOnRemove(glow1)
	end

	local startPos = self:GetPos() +self:GetForward() *-55 +self:GetUp() *-31.5
	local rc = ents.Create("sent_vj_avp_controller")
	rc:SetPos(startPos)
	rc:SetAngles(Angle(0,(startPos -self:GetPos()):Angle().y,0))
	rc:Spawn()
	rc:SetLinkedObject(self)
	self.RC = rc
	-- self:DeleteOnRemove(rc)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnDeviceEffected(rc,efType)
	if efType == 1 then -- Turned on
		if IsValid(self.Spotlight) then
			self.Spotlight:Fire("lighton")
		end
		if IsValid(self.ProjectedTexture) then
			self.ProjectedTexture:Fire("turnon")
		end
		rc:SetSkin(0)
		self:RemoveFlags(FL_NOTARGET)
		self.DisableFindEnemy = false
		self.DisableMakingSelfEnemyToNPCs = false
		self.turret_idlesd:Play()
	elseif efType == 2 or efType == 3 then -- Turned off/drained
		if IsValid(self.Spotlight) then
			self.Spotlight:Fire("lightoff")
		end
		if IsValid(self.ProjectedTexture) then
			self.ProjectedTexture:Fire("turnoff")
		end
		rc:SetSkin(1)
		self:AddFlags(FL_NOTARGET)
		self.DisableFindEnemy = true
		self.DisableMakingSelfEnemyToNPCs = true
		VJ.STOPSOUND(self.turret_idlesd)
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
		rc:SetSkin(2)
		rc:SetBodygroup(1,1)
		self:SetHealth(0)
		self.GodMode = false
		self.DisableExplosionOnDeath = true
		self:TakeDamage(600,self,self)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply, controlEnt)
	self.NextAlertSoundT = CurTime() + 1
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local parameter = self:GetPoseParameter("aim_yaw")
	if parameter != self.Turret_CurrentParameter then
		self.turret_turningsd = CreateSound(self, "cpthazama/avp/weapons/sentry guns/sentry_gun_pan_02.wav") 
		self.turret_turningsd:SetSoundLevel(60)
		self.turret_turningsd:PlayEx(1, 100)
	else
		if self.turret_turningsd then
			VJ.STOPSOUND(self.turret_turningsd)
			self.turret_turningsd = nil
			VJ.EmitSound(self, "cpthazama/avp/weapons/sentry guns/sentry gun marine stop click 01.ogg", 70, 100)
		end
	end
	self.Turret_CurrentParameter = parameter
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	local eneValid = IsValid(self:GetEnemy())
	if self.Alerted && !eneValid then
		self.PoseParameterLooking_CanReset = false
	else
		self.PoseParameterLooking_CanReset = true
	end

	if self.DisableFindEnemy then
		self.HasPoseParameterLooking = true
		self.PoseParameterLooking_CanReset = true
		self:SetEnemy(nil)
		return
	end

	local pyaw = self:GetPoseParameter("aim_yaw")
	if !eneValid then
		self.HasPoseParameterLooking = false
		if pyaw >= 70 then
			self.Turret_ScanDirSide = 1
			if self.Turret_NextScanBeepT < CurTime() then
				VJ.EmitSound(self, "cpthazama/avp/weapons/sentry guns/sentry gun marine move 02.ogg", 75, 100)
				self.Turret_NextScanBeepT = CurTime() +0.5
			end
		elseif pyaw <= -70 then
			self.Turret_ScanDirSide = 0
			if self.Turret_NextScanBeepT < CurTime() then
				VJ.EmitSound(self, "cpthazama/avp/weapons/sentry guns/sentry gun marine move 02.ogg", 75, 100)
				self.Turret_NextScanBeepT = CurTime() +0.5
			end
		end
		self:SetPoseParameter("aim_yaw", pyaw + (self.Turret_ScanDirSide == 1 and -5 or 5))
		self:SetPoseParameter("aim_pitch",Lerp(FrameTime() *8,self:GetPoseParameter("aim_pitch"),0))
	else
		self.HasPoseParameterLooking = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOn_PoseParameterLookingCode(pitch, yaw, roll)
	if (math.abs(math.AngleDifference(self:GetPoseParameter("aim_yaw"), math.ApproachAngle(self:GetPoseParameter("aim_yaw"), yaw, self.PoseParameterLooking_TurningSpeed))) >= 10) or (math.abs(math.AngleDifference(self:GetPoseParameter("aim_pitch"), math.ApproachAngle(self:GetPoseParameter("aim_pitch"), pitch, self.PoseParameterLooking_TurningSpeed))) >= 10) then
		if self.Turret_HasLOS == true && IsValid(self:GetEnemy()) then
			VJ.EmitSound(self, "cpthazama/avp/weapons/sentry guns/sentry gun lost target 01.ogg", 70, 100)
		end
		self.Turret_HasLOS = false
	else
		if self.Turret_HasLOS == false && IsValid(self:GetEnemy()) then
			VJ.EmitSound(self, "cpthazama/avp/weapons/sentry guns/sentry gun locked on 01.ogg", 70, 100)
		end
		self.Turret_HasLOS = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttackCheck_RangeAttack()
	return self.Turret_HasLOS
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomRangeAttackCode()	
	local startpos = self:GetAttachment(self:LookupAttachment("muzzle")).Pos
	local ent = self:GetEnemy()
	local bSpread = 150
	for i = 1,3 do
		timer.Simple(0.05 *i,function()
			if IsValid(self) && IsValid(ent) then
				local bullet = {}
				bullet.Num = 1
				bullet.Src = startpos
				bullet.Dir = ((ent:GetPos() +ent:OBBCenter()) -startpos):GetNormalized() *4000
				bullet.Spread = Vector(math.random(-bSpread,bSpread),math.random(-bSpread,bSpread),math.random(-bSpread,bSpread))
				bullet.Tracer = 1
				bullet.Force = 5
				bullet.Damage = 5
				bullet.AmmoType = "AirboatGun"
				bullet.Callback = function(attacker,tr,dmginfo)
					util.ScreenShake(tr.HitPos,16,100,0.2,50)
				end
				self:FireBullets(bullet)
			end
		end)
	end
	
	VJ.EmitSound(self,sdFiring,90,self:VJ_DecideSoundPitch(98,105))

	ParticleEffectAttach("vj_rifle_full",PATTACH_POINT_FOLLOW,self,1)
	
	local FireLight1 = ents.Create("light_dynamic")
	FireLight1:SetKeyValue("brightness","4")
	FireLight1:SetKeyValue("distance","250")
	FireLight1:SetPos(startpos)
	FireLight1:SetLocalAngles(self:GetAngles())
	FireLight1:Fire("Color","255 150 60")
	FireLight1:SetParent(self)
	FireLight1:Spawn()
	FireLight1:Activate()
	FireLight1:Fire("TurnOn","",0)
	FireLight1:Fire("Kill","",0.07)
	self:DeleteOnRemove(FireLight1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local defAng = Angle(0, 0, 0)
--
function ENT:CustomOnKilled(dmginfo, hitgroup)
	if !self.DisableExplosionOnDeath then
		VJ.ApplyRadiusDamage(self, self, self:GetPos(), 200, 50, bit.bor(DMG_BLAST,DMG_SHOCK), true, true)
		local startPos = self:GetPos() + self:OBBCenter()
		ParticleEffect("explosion_turret_break_fire", startPos, defAng, NULL)
		ParticleEffect("explosion_turret_break_flash", startPos, defAng, NULL)
		ParticleEffect("explosion_turret_break_pre_smoke Version #2", startPos, defAng, NULL)
		ParticleEffect("explosion_turret_break_sparks", startPos, defAng, NULL)
		ParticleEffect("vj_avp_android_death",startPos,defAng)
		sound.Play("cpthazama/avp/weapons/predator/mine/prd_mine_explosion_01.ogg",startPos,90)
	
		local FireLight1 = ents.Create("light_dynamic")
		FireLight1:SetKeyValue("brightness","4")
		FireLight1:SetKeyValue("distance","350")
		FireLight1:SetPos(startPos)
		FireLight1:SetLocalAngles(self:GetAngles())
		FireLight1:Fire("Color","220 180 255")
		FireLight1:SetParent(self)
		FireLight1:Spawn()
		FireLight1:Activate()
		FireLight1:Fire("TurnOn","",0)
		FireLight1:Fire("Kill","",0.9)
		self:DeleteOnRemove(FireLight1)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, ent)
	ParticleEffectAttach("smoke_exhaust_01a", PATTACH_POINT_FOLLOW, ent, 2)
	ent.VJ_AVP_IsTech = true
	ent:SetNW2Bool("AVP.IsTech",true)
	ent:DeleteOnRemove(self.RC)
	SafeRemoveEntityDelayed(self.RC,60)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ.STOPSOUND(self.turret_turningsd)
	VJ.STOPSOUND(self.turret_idlesd)

	if !self.DisableExplosionOnDeath then
		SafeRemoveEntity(self.RC)
	end
end