AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2025 by Cpt. Hazama,All rights reserved. ***
	No parts of this code or any of its contents may be reproduced,copied,modified or adapted,
	without the prior written consent of the author,unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/cpthazama/avp/misc/dropship.mdl"
ENT.StartHealth = 4000
ENT.VJ_ID_Boss = true
ENT.HullType = HULL_LARGE
ENT.TurningSpeed = 3
ENT.MovementType = VJ_MOVETYPE_AERIAL
-- ENT.TurningUseAllAxis = true
ENT.Aerial_FlyingSpeed_Alerted = 300
ENT.Aerial_FlyingSpeed_Calm = 600
ENT.AA_GroundLimit = 400
ENT.AA_MinWanderDist = 500
ENT.AA_MoveAccelerate = 15
ENT.AA_MoveDecelerate = 8

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
ENT.AlliedWithPlayerAllies = true

local combatDistance = 7000
ENT.ConstantlyFaceEnemy = true
ENT.LimitChaseDistance = true
ENT.LimitChaseDistance_Max = combatDistance
ENT.LimitChaseDistance_Min = 0

ENT.HasRangeAttack = true
ENT.RangeAttackProjectiles = "obj_vj_rocket"
ENT.RangeAttackMaxDistance = combatDistance
ENT.RangeAttackMinDistance = 1
ENT.RangeAttackAngleRadius = 100
ENT.TimeUntilRangeAttackProjectileRelease = 0.1
ENT.NextRangeAttackTime = VJ.SET(3,10)
ENT.RangeAttackReps = 1
ENT.RangeAttackExtraTimers = {0}
ENT.AnimTbl_RangeAttack = false
ENT.RangeAttackAttachmentType = "rocket_l"

ENT.Bleeds = false
ENT.HasDeathCorpse = false

ENT.HasMeleeAttack = false

ENT.MainSoundPitch = 100
ENT.DeathSoundLevel = 100

local sdFiring = {"^cpthazama/avp/weapons/sentry guns/sentry gun burst 01.ogg","^cpthazama/avp/weapons/sentry guns/sentry gun burst 02.ogg","^cpthazama/avp/weapons/sentry guns/sentry gun burst 03.ogg"}
---------------------------------------------------------------------------------------------------------------------------------------------
local spawnPos = Vector(0, 0, 400)
--
function ENT:Init()
	self.DeleteSounds = {}
	self.CurrentAttackSound = nil
	self.HasLOS = false
	self.ScanDirSide = 0
	self.ScanDirUp = 0

	self.ConstantlyFaceEnemy_MinDistance = self:GetMaxLookDistance()
	self:SetCollisionBounds(Vector(250, 250, 90), Vector(-250, -250, -120))
	self:SetPos(self:GetPos() + spawnPos)

	self.AlarmLoop = CreateSound(self,"cpthazama/avp/dropship/vehicle_dropship_dive_alarm_01.wav")
	self.AlarmLoop:SetSoundLevel(80)
	-- self.AlarmLoop:Play()
	table.insert(self.DeleteSounds,self.AlarmLoop)

	self.EngineLoop = CreateSound(self,"cpthazama/avp/dropship/vehicle_dropship_loop_highend_01.wav")
	self.EngineLoop:SetSoundLevel(95)
	self.EngineLoop:Play()
	table.insert(self.DeleteSounds,self.EngineLoop)

	self.EngineLoopB = CreateSound(self,"cpthazama/avp/dropship/vehicle_dropship_engine_loop_02.wav")
	self.EngineLoopB:SetSoundLevel(120)
	self.EngineLoopB:Play()
	table.insert(self.DeleteSounds,self.EngineLoopB)

	self.MoveSpeed_Calm = self.Aerial_FlyingSpeed_Calm
	self.MoveSpeed_Alerted = self.Aerial_FlyingSpeed_Alerted

	local rotorwash = ents.Create("env_rotorwash_emitter")
	rotorwash:SetPos(self:GetPos())
	rotorwash:SetParent(self)
	rotorwash:Spawn()
	rotorwash:Activate()
	self:DeleteOnRemove(rotorwash)

	for i = 1,2 do
		local att = "light" .. i
		local envLight = ents.Create("env_projectedtexture")
		envLight:SetLocalPos(self:GetPos())
		envLight:SetLocalAngles(self:GetAngles())
		envLight:SetKeyValue("lightcolor","255 210 210")
		envLight:SetKeyValue("lightfov","65")
		envLight:SetKeyValue("farz","2500")
		envLight:SetKeyValue("nearz","10")
		envLight:SetKeyValue("shadowquality","1")
		envLight:Input("SpotlightTexture",NULL,NULL,"effects/flashlight001")
		envLight:SetOwner(self)
		envLight:SetParent(self)
		envLight:Spawn()
		envLight:Fire("setparentattachment",att)
		self:DeleteOnRemove(envLight)

		local spotlight = ents.Create("beam_spotlight")
		spotlight:SetPos(self:GetPos())
		spotlight:SetAngles(self:GetAngles())
		spotlight:SetKeyValue("spotlightlength",2300)
		spotlight:SetKeyValue("spotlightwidth",90)
		spotlight:SetKeyValue("spawnflags","2")
		spotlight:Fire("Color","255 210 210")
		spotlight:SetParent(self)
		spotlight:Spawn()
		spotlight:Activate()
		spotlight:Fire("setparentattachment",att)
		spotlight:Fire("lighton")
		spotlight:AddEffects(EF_PARENT_ANIMATES)
		self:DeleteOnRemove(spotlight)
	end

	self:SetEngineState(1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply,controlEnt)
	controlEnt.VJC_Player_CanChatMessage = false

	ply:ChatPrint("Controls:")
	ply:ChatPrint("LMB - Fire Machine Guns")
	ply:ChatPrint("RMB - Fire Missiles")
	ply:ChatPrint("Space - Ascend")
	ply:ChatPrint("Ctrl - Descend")
	ply:ChatPrint("Sprint - Accelerate")
	ply:ChatPrint("Land to recover health")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjPos(projectile)
	self.RangeAttackAttachmentType = self.RangeAttackAttachmentType == "rocket_l" && "rocket_r" or "rocket_l"
	VJ.EmitSound(self,"cpthazama/avp/dropship/vehicle_dropship_missile_fire_01.wav",95)
	return self:GetAttachment(self:LookupAttachment(self.RangeAttackAttachmentType)).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetMoveDirection(ignoreZ)
	if self:GetVelocity():Length() <= 0 then return defPos end
	local myPos = self:GetPos()
	local dir = (((self:GetPos() +self:GetVelocity()) or myPos) - myPos)
	if ignoreZ then dir.z = 0 end
	return (self:GetAngles() - dir:Angle()):Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlaySound(sndTbl,level,pitch,setCurSnd)
	if !sndTbl or istable(sndTbl) && #sndTbl <= 0 then return 0 end
	local setCurSnd = setCurSnd or true
	if setCurSnd then
		self:StopAllSounds()
		if self.CurrentAttackSound then
			self.CurrentAttackSound:Stop()
		end
	end
	local sndName = VJ_PICK(sndTbl)
	local snd = VJ.CreateSound(self,sndName,level or 75,pitch or 100)
	if setCurSnd then
		self.CurrentAttackSound = snd
	end
	table.insert(self.DeleteSounds,snd)
	return SoundDuration(sndName)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkAttack(isAttacking, ent)
	local data = self.EnemyData
	local visible = data.Visible
	local dist = data.DistanceNearest
	local curTime = CurTime()
	if self.VJ_IsBeingControlled then
		local cont = self.VJ_TheController
		if cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && !self:IsBusy("Activities") then
			self:FireWeapon(ent)
		end
		return
	end
	if visible && !self:IsBusy("Activities") && dist <= combatDistance then
		self:FireWeapon(ent)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:FireWeapon(ent)
	if !IsValid(ent) then return end
	if CurTime() < (self.NextWeaponFireT or 0) then return end

	for i = 1,2 do
		local att = self:LookupAttachment("muzzlefx" .. i)
		local attPos = self:GetAttachment(att).Pos
		local aimDir = ((ent:EyePos() -Vector(0,0,ent:OBBCenter().z *0.2)) -self:GetAttachment(att).Pos):GetNormalized()
		local bullet = {}
		bullet.Num = 1
		bullet.Src = attPos
		bullet.Dir = aimDir
		bullet.Spread = Vector(0.02,0.02,0)
		bullet.Tracer = 1
		bullet.Force = 5
		bullet.Damage = 7
		bullet.TracerName = "VJ_AVP_Trace"
		bullet.AmmoType = "AirboatGun"
		bullet.Attacker = self
		bullet.Inflictor = self
		bullet.IgnoreEntity = self
		bullet.Callback = function(attacker,tr,dmginfo)
			util.ScreenShake(tr.HitPos,16,100,0.2,200)
		end
		self:FireBullets(bullet)
		ParticleEffectAttach("vj_avp_muzzle_lmg_main",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("muzzlefx" .. i))
	end
	VJ.EmitSound(self,sdFiring,95)
	self.NextWeaponFireT = CurTime() +0.05
	if math.random(1,25) == 1 then
		self.NextWeaponFireT = self.NextWeaponFireT +math.Rand(0.5,1.5)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetEngineState(state)
	self:StopParticles()
	-- if !self.EngineLoop or self.EngineLoop && !self.EngineLoop:IsPlaying() then
	-- 	self.EngineLoop = CreateSound(self,"cpthazama/avp/dropship/vehicle_dropship_loop_highend_01.wav")
	-- 	self.EngineLoop:SetSoundLevel(95)
	-- 	self.EngineLoop:Play()
	-- 	if !table.HasValue(self.DeleteSounds,self.EngineLoop) then
	-- 		table.insert(self.DeleteSounds,self.EngineLoop)
	-- 	end
	-- end
	-- if !self.EngineLoopB or self.EngineLoopB && !self.EngineLoopB:IsPlaying() then
	-- 	self.EngineLoopB = CreateSound(self,"cpthazama/avp/dropship/vehicle_dropship_engine_loop_02.wav")
	-- 	self.EngineLoopB:SetSoundLevel(120)
	-- 	self.EngineLoopB:Play()
	-- 	if !table.HasValue(self.DeleteSounds,self.EngineLoopB) then
	-- 		table.insert(self.DeleteSounds,self.EngineLoopB)
	-- 	end
	-- end
	if state == 1 then
		self.EngineLoop:ChangeVolume(1)
		self.EngineLoopB:ChangeVolume(1)
		for i = 1,4 do
			ParticleEffectAttach("vj_avp_dropship_engine",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("engine" .. i))
		end
	elseif state == 2 then
		self.EngineLoop:ChangeVolume(1)
		self.EngineLoopB:ChangeVolume(1)
		for i = 1,4 do
			ParticleEffectAttach((i == 1 or i == 4) && "vj_avp_dropship_engine" or "vj_avp_dropship_smoke",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("engine" .. i))
		end
	elseif state == 3 then -- Landed
		self.EngineLoop:ChangeVolume(0.3)
		self.EngineLoopB:ChangeVolume(0)
	elseif state == 4 then -- Landed and heavily damaged
		self.EngineLoop:ChangeVolume(0.3)
		self.EngineLoopB:ChangeVolume(0)
		ParticleEffectAttach("vj_avp_dropship_smoke",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("engine2"))
		ParticleEffectAttach("vj_avp_dropship_smoke",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("engine3"))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	return ACT_IDLE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
	if self.Dead then return end
	local curTime = CurTime()
	local cont = self.VJ_TheController
	local lerpingFactor = FrameTime() *15
	local moveDir = self:GetMoveDirection()
	local velNorm = moveDir && moveDir:GetNormal() or Vector(0,0,0)
	local vel = self:GetVelocity():Length()
	local hpPer = self:Health() /self:GetMaxHealth()

	-- if IsValid(cont) then
		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() +self:GetUp() *-130,
			filter = {self, cont},
			mask = MASK_SOLID_BRUSHONLY
		})
		-- cont:ChatPrint("Is hitting world:" .. tostring(tr.HitWorld))
		if tr.HitWorld then
			if !self.IsLanded then
				self.IsLanded = true
				self.LandAngles = self:GetAngles()
				self:SetEngineState(hpPer <= 0.25 && 4 or 3)
			end
			self:SetCycle(0)
			self:SetMaxYawSpeed(0)
			self:SetAngles(self.LandAngles)
			self:SetLocalVelocity(Vector(0,0,0))
			self:SetVelocity(Vector(0,0,0))
			self:SetHealth(math.Clamp(self:Health() +2,1,self:GetMaxHealth()))
			velNorm = Vector(0,0,0)
		else
			if self.IsLanded then
				self.IsLanded = false
				self:SetMaxYawSpeed(self.TurningSpeed)
				if hpPer <= 0.25 && !self.StartedAlarm then
					self.StartedAlarm = true
					self.AlarmLoop:Play()
					self:SetEngineState(2)
				elseif hpPer > 0.25 && self.StartedAlarm then
					self.StartedAlarm = false
					self.AlarmLoop:Stop()
					self:SetEngineState(1)
				else
					self:SetEngineState(1)
					self.StartedAlarm = false
				end
			end
		end
	-- end

	if hpPer <= 0.25 && !self.StartedAlarm then
		self.StartedAlarm = true
		self.AlarmLoop:Play()
		self:SetEngineState(self.IsLanded && 4 or 2)
	elseif hpPer > 0.25 && self.StartedAlarm then
		self.StartedAlarm = false
		self.AlarmLoop:Stop()
		self:SetEngineState(self.IsLanded && 3 or 1)
	end

	if moveDir && moveDir != defPos && !self.IsLanded then
		targetYaw = -math.NormalizeAngle(math.deg(math.atan2(moveDir.y,moveDir.x)))
		local pitchMin,pitchMax = 90,130
		local maxVel = 1000
		local pitch = math.Clamp(math.Remap(vel,0,maxVel,pitchMin,pitchMax),pitchMin,pitchMax)
		self.EngineLoop:ChangePitch(Lerp(lerpingFactor, self.EngineLoop:GetPitch(), math.Clamp(pitch, 80, 120)))
		self.EngineLoopB:ChangePitch(Lerp(lerpingFactor, self.EngineLoopB:GetPitch(), math.Clamp(pitch, 80, 120)))
	else
		self.EngineLoop:ChangePitch(Lerp(lerpingFactor, self.EngineLoop:GetPitch(), 100))
		self.EngineLoopB:ChangePitch(Lerp(lerpingFactor, self.EngineLoopB:GetPitch(), 100))
	end

	self:SetPoseParameter("tilt_x", Lerp(lerpingFactor, self:GetPoseParameter("tilt_x"), velNorm.x))
	self:SetPoseParameter("tilt_y", Lerp(lerpingFactor, self:GetPoseParameter("tilt_y"), velNorm.y))
end
---------------------------------------------------------------------------------------------------------------------------------------------
local angY0 = Angle(0, 0, 0)
local angY45 = Angle(0, 45, 0)
local angYN45 = Angle(0, -45, 0)
local angY90 = Angle(0, 90, 0)
local angYN90 = Angle(0, -90, 0)
local angY135 = Angle(0, 135, 0)
local angYN135 = Angle(0, -135, 0)
local angY180 = Angle(0, 180, 0)
--
function ENT:Controller_Movement(cont, ply, bullseyePos)
	if self.MovementType != VJ_MOVETYPE_STATIONARY then
		local gerta_lef = ply:KeyDown(IN_MOVELEFT)
		local gerta_rig = ply:KeyDown(IN_MOVERIGHT)
		local gerta_arak = ply:KeyDown(IN_SPEED)
		local goUp = ply:KeyDown(IN_JUMP)
		local goDown = ply:KeyDown(IN_DUCK)
		local atk = ply:KeyDown(IN_ATTACK)
		local aimVector = ply:GetAimVector()
		local Rot = angY0
		local FT = FrameTime() *(self.TurningSpeed *5)
		local ZOffset = (goUp && 1 or 0) -(goDown && 1 or 0)
		local throttle = 1
		local vert = false
		local speed = (gerta_arak && 1000 or 600)
		if atk then
			speed = speed *0.5
		end

		self.Aerial_FlyingSpeed_Alerted = speed
		self.Aerial_FlyingSpeed_Calm = speed
		self.ControllerParams.TurnAngle = self.ControllerParams.TurnAngle or angY0
		
		if ply:KeyDown(IN_FORWARD) then
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, gerta_lef && angY45 or gerta_rig && angYN45 or angY0)
		elseif ply:KeyDown(IN_BACK) then
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, gerta_lef && angY135 or gerta_rig && angYN135 or angY180)
		elseif gerta_lef then
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, angY90)
		elseif gerta_rig then
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, angYN90)
		elseif goUp then
			vert = true
			-- self:AA_MoveTo(self:GetPos() +self:GetForward() *1 +self:GetUp() *speed, true, gerta_arak and "Alert" or "Calm", {IgnoreGround=true})
			-- return
		elseif goDown then
			vert = true
			throttle = -1
			-- self:AA_MoveTo(self:GetPos() +self:GetForward() *1 +self:GetUp() *-speed, true, gerta_arak and "Alert" or "Calm", {IgnoreGround=true})
			-- return
		else
			-- self:AA_StopMoving()
			throttle = 0
			self.ControllerParams.TurnAngle = LerpAngle(FT, self.ControllerParams.TurnAngle, angY0)
			return
		end

		Rot = self.ControllerParams.TurnAngle
		aimVector.z = 0
		aimVector:Rotate(Rot)
		local selfPos = self:GetPos()
		local centerToPos = self:OBBCenter():Distance(self:OBBMins()) + 20
		local NPCPos = selfPos
		local targetPos = vert && (self:GetPos() +self:GetForward() *1 +self:GetUp() *(speed *throttle)) or (NPCPos +aimVector *(speed *throttle) +self:GetUp() *(ZOffset *speed))
		local forwardTr = util.TraceLine({start = NPCPos, endpos = targetPos, filter = {self, cont, ply}})
		self:AA_MoveTo(forwardTr.HitPos, true, gerta_arak and "Alert" or "Calm", {IgnoreGround=true})
		if throttle != 0 then
			self:SetTurnTarget(self.VJ_TheControllerBullseye, 0.2)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibMdls = {"models/props_debris/metal_panelchunk01a.mdl","models/props_debris/metal_panelchunk01b.mdl","models/props_debris/metal_panelchunk01d.mdl","models/props_debris/metal_panelchunk01e.mdl","models/props_debris/metal_panelchunk01f.mdl","models/props_debris/metal_panelchunk01g.mdl","models/props_debris/metal_panelchunk02d.mdl","models/props_debris/metal_panelchunk02e.mdl"}
local gibColor = Color(50, 50, 50)
local humanMdls = {
	"models/cpthazama/avp/marines/connor.mdl",
	"models/cpthazama/avp/marines/female_blonde.mdl",
	"models/cpthazama/avp/marines/moss.mdl",
	"models/cpthazama/avp/marines/alex.mdl"
}
--
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "Init" then
		local deathCorpse = ents.Create("prop_vj_animatable")
		deathCorpse:SetModel(self:GetModel())
		deathCorpse:SetPos(self:GetPos())
		deathCorpse:SetAngles(self:GetAngles())
		function deathCorpse:Initialize()
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetMoveCollide(MOVECOLLIDE_FLY_BOUNCE)
			self:SetCollisionGroup(COLLISION_GROUP_NONE)
			self:SetSolid(SOLID_CUSTOM)
			local phys = self:GetPhysicsObject()
			if IsValid(phys) then
				phys:Wake()
				phys:EnableGravity(true)
				phys:SetBuoyancyRatio(0)
				phys:SetVelocity(self:GetVelocity() +self:GetRight() *math.Rand(-700,700))
				phys:AddAngleVelocity(Vector(math.Rand(-150, 150), math.Rand(-20, 20), 200))
			end
		end
		VJ.EmitSound(deathCorpse, "cpthazama/avp/dropship/vehicle_dropship_impact_explosion_01.wav", 140, 100)
		deathCorpse.NextExpT = 0
		deathCorpse:Spawn()
		deathCorpse:Activate()
		
		function deathCorpse:Think()
			self:ResetSequence("idle")
			if CurTime() > self.NextExpT then
				self.NextExpT = CurTime() +math.Rand(0.1, 0.5)
				local expPos2 = self:GetPos() + Vector(math.Rand(-150, 150), math.Rand(-150, 150), math.Rand(-150, -50))
				ParticleEffect("vj_explosion2", expPos2, Angle())
				util.BlastDamage(self, self, expPos2, 300, 100)
				VJ.EmitSound(self, "vj_base/ambience/explosion1.wav" .. math.random(1, 5) .. ".wav", 140, 100)
			end
		
			self:NextThink(CurTime())
			return true
		end
		
		-- Get destroyed when it collides with something
		function deathCorpse:PhysicsCollide(data, phys)
			if self.Dead then return end
			local myPos = self:GetPos()
			self.Dead = true
			
			-- Create gibs
			for _ = 1, 50 do
				local gib = ents.Create("prop_physics")
				gib:SetModel(VJ.PICK(gibMdls))
				gib:SetPos(myPos + Vector(math.random(-100, 100), math.random(-100, 100), math.random(20, 150)))
				gib:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
				gib:Spawn()
				gib:Activate()
				gib:SetColor(gibColor)
				gib:Ignite(math.Rand(5, 10))
				local myPhys = gib:GetPhysicsObject()
				if IsValid(myPhys) then
					myPhys:AddVelocity(Vector(math.Rand(-300, 300), math.Rand(-300, 300), math.Rand(150, 250)))
					myPhys:AddAngleVelocity(Vector(math.Rand(-200, 200), math.Rand(-200, 200), math.Rand(-200, 200)))
				end
				if GetConVar("vj_npc_gib_fade"):GetInt() == 1 then
					timer.Simple(GetConVar("vj_npc_gib_fadetime"):GetInt(), function() SafeRemoveEntity(gib) end)
				end
			end

			local corpse = ents.Create("prop_ragdoll")
			corpse:SetModel(VJ.PICK(humanMdls))
			corpse:SetPos(myPos + Vector(math.Rand(-35, 35), math.Rand(-35, 35), math.Rand(35, 35)) +self:GetForward() *300)
			corpse:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
			corpse:Spawn()
			corpse:Activate()
			corpse:Ignite(math.Rand(5, 10))
			corpse:SetBodygroup(corpse:FindBodygroupByName("head"),math.random(0,2))
			corpse:SetBodygroup(corpse:FindBodygroupByName("larm"),math.random(0,1))
			corpse:SetBodygroup(corpse:FindBodygroupByName("rarm"),math.random(0,1))
			corpse:SetBodygroup(corpse:FindBodygroupByName("lleg"),math.random(0,1))
			corpse:SetBodygroup(corpse:FindBodygroupByName("rleg"),math.random(0,1))
			local corpsePhys = corpse:GetPhysicsObject()
			if IsValid(corpsePhys) then
				corpsePhys:AddVelocity(Vector(math.Rand(-300, 300), math.Rand(-300, 300), math.Rand(150, 250)))
				corpsePhys:AddAngleVelocity(Vector(math.Rand(-200, 200), math.Rand(-200, 200), math.Rand(-200, 200)))
			end
			
			local expPos2 = myPos + Vector(0, 0, math.Rand(150, 150))
			ParticleEffect("vj_explosion2", expPos2, Angle())
			util.BlastDamage(self, self, expPos2, 600, 200)
			VJ.EmitSound(self, "cpthazama/avp/dropship/vehicle_dropship_impact_explosion_01.wav", 140, 100)
			self:Remove()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	for _,v in ipairs(self.DeleteSounds) do
		if v then
			v:Stop()
		end
	end
end