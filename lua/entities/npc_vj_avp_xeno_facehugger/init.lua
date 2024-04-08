AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/facehugger.mdl"}
ENT.StartHealth = 15
ENT.HullType = HULL_TINY
ENT.FindEnemy_CanSeeThroughWalls = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow"
ENT.CustomBlood_Particle = {"vj_avp_blood_xeno"}
ENT.CustomBlood_Decal = {"VJ_AVP_BloodXenomorph"}
ENT.VJ_NPC_Class = {"CLASS_XENOMORPH"}

ENT.MeleeAttackDamage = 5
ENT.MeleeAttackDistance = 80
ENT.MeleeAttackDamageDistance = 50
ENT.MeleeAttackDamageAngleRadius = 50
ENT.AnimTbl_MeleeAttack = {"facehugger_jump"}
ENT.TimeUntilMeleeAttackDamage = 0.6
ENT.MeleeAttackExtraTimers = {0.8, 1, 1.2, 1.4}

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {"facehugger_death"}

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0,-15),
    FirstP_Bone = "body",
    FirstP_Offset = Vector(2, 0, 6),
    FirstP_ShrinkBone = false
}

ENT.GeneralSoundPitch1 = 100
ENT.FootStepSoundLevel = 40
ENT.FootStepTimeWalk = 0.2
ENT.FootStepTimeRun = 0.1

ENT.SoundTbl_FootStep = {
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch1.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch2.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch3.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch4.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch5.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch6.ogg",
	"cpthazama/avp/xeno/facehugger/foley/fhg_squelch7.ogg",
}
ENT.SoundTbl_Idle = {
	"cpthazama/avp/xeno/facehugger/vocals/fhg_idle_vocal1.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/fhg_idle_vocal2.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/fhg_idle_vocal3.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/fhg_idle_vocal4.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/fhg_idle_vocal5.ogg",
}
ENT.SoundTbl_Alert = {
	"cpthazama/avp/xeno/facehugger/idle_0.wav",
	"cpthazama/avp/xeno/facehugger/idle_1.wav",
	"cpthazama/avp/xeno/facehugger/spot_0.wav",
	"cpthazama/avp/xeno/facehugger/spot_1.wav",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"cpthazama/avp/xeno/facehugger/vocals/fhg_attackhiss_tp_1.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/fhg_attackhiss_tp_2.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/fhg_attackhiss_tp_3.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/fhg_attackhiss_tp_4.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/fhg_attackhiss_tp_5.ogg",
}
ENT.SoundTbl_MeleeAttackGrapple = {
	"cpthazama/avp/xeno/facehugger/attack/fhg_constrict_tp_1.ogg",
	"cpthazama/avp/xeno/facehugger/attack/fhg_constrict_tp_2.ogg",
	"cpthazama/avp/xeno/facehugger/attack/fhg_constrict_tp_3.ogg",
}
ENT.SoundTbl_Pain = {
	"cpthazama/avp/xeno/facehugger/vocals/fhg_grapple_screech_01.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/fhg_grapple_screech_02.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/fhg_grapple_screech_03.ogg",
}
ENT.SoundTbl_Death = {
	"cpthazama/avp/xeno/facehugger/death_0.wav",
	"cpthazama/avp/xeno/facehugger/vocals/facehugger_death_01.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/facehugger_death_02.ogg",
	"cpthazama/avp/xeno/facehugger/vocals/facehugger_death_03.ogg",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply,controlEnt)
    net.Start("VJ_AVP_Xeno_Client")
		net.WriteBool(false)
		net.WriteEntity(self)
		net.WriteEntity(ply)
    net.Send(ply)

	controlEnt.VJC_Player_DrawHUD = false

	function controlEnt:CustomOnThink()
		self.VJC_NPC_CanTurn = self.VJC_Camera_Mode == 2
		self.VJC_BullseyeTracking = self.VJC_Camera_Mode == 2
	end

	function controlEnt:CustomOnStopControlling()
		net.Start("VJ_AVP_Xeno_Client")
			net.WriteBool(true)
			net.WriteEntity(self)
			net.WriteEntity(ply)
		net.Send(ply)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.IsLatched = false
	self.LatchVictim = nil

	self:SetCollisionBounds(Vector(5,5,7),Vector(-5,-5,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		self:FootStepSoundCode()
	end
	if key == "attack" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_Miss()
	self:VJ_ACT_PLAYACTIVITY("facehugger_jump_land",true,false,false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(ent, isProp)
	if IsValid(self.LatchVictim) then return true end

	if (ent:IsNPC() or (ent:IsNextBot() && ent.IsLambdaPlayer) or ent:IsPlayer() && ent:Health() <= 25) && !ent.VJ_AVP_IsFacehugged && !ent.VJ_AVP_IsTech && (ent:IsNPC() && (ent:GetHullType() == HULL_HUMAN or ent:GetHullType() == HULL_WIDE_HUMAN) or !ent:IsNPC()) && util.IsValidRagdoll(ent:GetModel()) then
		local counter = math.random(1,100) <= (100 *(ent:Health() /ent:GetMaxHealth()))
		if ent.VJ_AVP_Predator && counter then
			self:VJ_ACT_PLAYACTIVITY("facehugger_jump_land",true,false,false)
			return false
		end
		local eyeAttach = ent:LookupAttachment("eyes")
		local mouthAttach = ent:LookupAttachment("mouth")
		local att,useBone = nil,false
		if eyeAttach >= 1 then
			att = "eyes"
		elseif mouthAttach >= 1 then
			att = "mouth"
		elseif ent:LookupBone("ValveBiped.Bip01_Head1") != nil then
			useBone = true
		end

		if att then
			local corpse = ents.Create("prop_ragdoll")
			corpse:SetModel(ent:GetModel())
			corpse:SetPos(ent:GetPos())
			corpse:SetAngles(ent:GetAngles())
			corpse:SetOwner(ent)
			corpse:Spawn()
			corpse:Activate()
			corpse:SetColor(ent:GetColor())
			corpse:SetMaterial(ent:GetMaterial())
			corpse:SetSkin(ent:GetSkin())
			for x = 0,32 do
				if ent:GetSubMaterial(x) != "" then
					corpse:SetSubMaterial(x,ent:GetSubMaterial(x))
				end
			end
			corpse.IsVJBaseCorpse = true
			-- corpse:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			for i = 0, ent:GetNumBodyGroups() do
				corpse:SetBodygroup(i, ent:GetBodygroup(i))
			end
			local physCount = corpse:GetPhysicsObjectCount()
			for boneLimit = 0, physCount - 1 do -- 128 = Bone Limit
				local childPhysObj = corpse:GetPhysicsObjectNum(boneLimit)
				if IsValid(childPhysObj) then
					local childPhysObj_BonePos, childPhysObj_BoneAng = ent:GetBonePosition(corpse:TranslatePhysBoneToBone(boneLimit))
					if (childPhysObj_BonePos) then
						childPhysObj:SetAngles(childPhysObj_BoneAng)
						childPhysObj:SetPos(childPhysObj_BonePos)
					end
				end
			end
			if ent:IsNPC() then
				ent:DeleteOnRemove(corpse)
			else
				undo.ReplaceEntity(ent,corpse)
				SafeRemoveEntityDelayed(ent,36)
			end
			-- ent:DeleteOnRemove(self)

			corpse.VJ_AVP_Facehugged = true
			corpse.VJ_AVP_Facehugger = self
			corpse.VJ_AVP_Class = self:GetClass()
			corpse.VJ_AVP_XenoClass = ent:GetMaxHealth() >= 100 && (self.VJ_AVP_K_Xenomorph && "npc_vj_avp_kxeno_warrior" or "npc_vj_avp_xeno_warrior") or (self.VJ_AVP_K_Xenomorph && "npc_vj_avp_kxeno_drone" or "npc_vj_avp_xeno_drone")
			if ent.VJ_AVP_Predator then
				corpse.VJ_AVP_IsPredburster = true
				corpse.VJ_AVP_XenoClass = (self.VJ_AVP_K_Xenomorph && "npc_vj_avp_kxeno_predalien" or "npc_vj_avp_xeno_predalien")
			elseif ent:IsNPC() && ent:Classify() == CLASS_VORTIGAUNT then
				corpse.VJ_AVP_XenoClass = (self.VJ_AVP_K_Xenomorph && "npc_vj_avp_kxeno_jungle" or "npc_vj_avp_xeno_jungle")
			end
			corpse.BloodData = {Color = ent.BloodColor, Particle = VJ.PICK(ent.CustomBlood_Particle), Decal = ent.CustomBlood_Decal}

			VJ.CreateSound(self,self.SoundTbl_MeleeAttackGrapple,70)
			self.LatchVictim = ent
			self.LatchCorpse = corpse
			self.IsLatched = true
			self.BirthT = CurTime() +30
			self:SetOwner(ent)
			self:AddFlags(FL_NOTARGET)
			self.DisableFindEnemy = true
			self.DisableSelectSchedule = true
			self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
			self:SetNavType(NAV_NONE)
			self:SetMoveType(MOVETYPE_NONE)
			self:SetNoDraw(true)
			self:DrawShadow(false)
			local fakeFacehugger = ents.Create("prop_vj_animatable")
			fakeFacehugger:SetModel(self:GetModel())
			fakeFacehugger:SetPos(self:GetPos())
			fakeFacehugger:SetAngles(self:GetAngles())
			fakeFacehugger:SetOwner(self)
			fakeFacehugger:Spawn()
			fakeFacehugger:Activate()
			fakeFacehugger:SetNotSolid(true)
			fakeFacehugger:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			self:DeleteOnRemove(fakeFacehugger)
			if useBone then
				local bonePos,boneAng = corpse:GetBonePosition(corpse:LookupBone("ValveBiped.Bip01_Head1"))
				self:FollowBone(corpse,corpse:LookupBone("ValveBiped.Bip01_Head1"))
				-- fakeFacehugger:SetAngles(boneAng)
				fakeFacehugger:FollowBone(corpse,corpse:LookupBone("ValveBiped.Bip01_Head1"))
			else
				self:SetParent(corpse)
				self:Fire("SetParentAttachment",att,0)
				fakeFacehugger:SetParent(corpse)
				fakeFacehugger:Fire("SetParentAttachment",att,0)
			end
			fakeFacehugger:ResetSequence("facehugger_harvest_idle")
			self.LatchFakeFacehugger = fakeFacehugger

			if ent:IsNPC() then
				ent.VJ_AVP_IsFacehugged = true
				ent:SetNoDraw(true)
				ent:SetNotSolid(true)
				ent:DrawShadow(false)
				ent:NextThink(CurTime() +2)
				for _,v in pairs(ent:GetChildren()) do
					if IsValid(v) then
						ent:SetNoDraw(true)
						ent:DrawShadow(false)
					end
				end
			end

			if ent.OnFacehugged then
				ent:OnFacehugged(self,fakeFacehugger,corpse)
			end

			if ent:IsNPC() then
				hook.Add("Think",ent,function(ent)
					if !IsValid(corpse) then
						ent:SetNoDraw(false)
						ent:SetNotSolid(false)
						ent:DrawShadow(true)
						ent:NextThink(CurTime())
						ent:RemoveFlags(FL_NOTARGET)
						for _,v in pairs(ent:GetChildren()) do
							if IsValid(v) then
								ent:SetNoDraw(false)
								ent:DrawShadow(true)
							end
						end

						if IsValid(self) then
							self:SetParent(nil)
							self:SetHealth(0)
							self:TakeDamage(1000)
						end
						hook.Remove("Think",ent)
						return
					end

					ent:SetPos(corpse:GetPos())
					ent:TaskComplete()
					ent:StopMoving()
					ent:ClearSchedule()
					ent:ClearGoal()
					ent:ResetIdealActivity(ACT_IDLE)
					ent:AddFlags(FL_NOTARGET)
					ent.HasDeathAnimation = false
					if ent.IsVJBaseSNPC then
						ent:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
						ent:SetEnemy(nil)
						ent.HasSounds = false
						ent.DisableFindEnemy = true
					end
					local wep = ent:GetActiveWeapon()
					if IsValid(wep) then
						if wep.SetNextPrimaryFire then
							wep:SetNextPrimaryFire(CurTime() +2)
						end
						if wep.SetNextSecondaryFire then
							wep:SetNextSecondaryFire(CurTime() +2)
						end
					end
				end)
			else
				if ent:IsPlayer() then
					ent:Kill()
					local ragdoll = ent:GetRagdollEntity()
					if IsValid(ragdoll) then
						ragdoll:Remove()
					end
				elseif ent:IsNextBot() then
					ent:SetHealth(0)
					local dmginfo = DamageInfo()
					dmginfo:SetDamage(1000)
					dmginfo:SetDamageType(DMG_DIRECT)
					dmginfo:SetAttacker(self)
					dmginfo:SetInflictor(self)
					ent:TakeDamageInfo(dmginfo)
					ent:Remove()
				end
			end
		end
	else
		self:VJ_ACT_PLAYACTIVITY("facehugger_jump_land",true,false,false)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_IDLE && self.IsLatched then
		return ACT_IDLE_ANGRY
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	self:Acid(dmginfo:GetDamagePosition(),125,3)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled()
	self:Acid(self:GetPos(),200,15)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_acos = math.acos
local math_deg = math.deg
local math_rad = math.rad
local math_abs = math.abs
--
function ENT:SetGroundAngle()
	local pos = self:GetPos()
	local len = self:GetUp() *50
	local ang = self:GetAngles()
	local ang_y = Angle(0,ang.y,0)
	local refreshRate = FrameTime() *20
	if self:OnGround() then
		local mins, maxs = self:GetCollisionBounds()
		local posForward, posBackward, posRight, posLeft
		local directionVectors = {
			forward = ang_y:Forward(),
			backward = ang_y:Forward() * -1,
			right = ang_y:Right(),
			left = ang_y:Right() * -1,
		}
		local hits = {}
		for direction, vector in pairs(directionVectors) do
			local startPos = pos + vector * ((vector == directionVectors.right or vector == directionVectors.left) and maxs.y or maxs.x)
			local tr = util.TraceLine({
				start = startPos,
				endpos = startPos - len,
				filter = self
			})
			hits[direction] = tr.HitPos
			if direction == "forward" then
				posForward = startPos
			elseif direction == "backward" then
				posBackward = startPos
			elseif direction == "right" then
				posRight = startPos
			elseif direction == "left" then
				posLeft = startPos
			end
		end

		local hitForward = hits.forward
		local hitBackward = hits.backward
		local hitRight = hits.right
		local hitLeft = hits.left
		local pitch
		local roll
		local pitchDif = math_abs(hitForward.z -hitBackward.z)
		local rollDif = math_abs(hitLeft.z -hitRight.z)
		if posForward:Distance(hitForward) > posBackward:Distance(hitBackward) then
			pitch = 90 -math_deg(math_acos(pitchDif /hitForward:Distance(posBackward)))
		else
			pitch = -(90 -math_deg(math_acos(pitchDif /hitBackward:Distance(posForward))))
		end
		if posLeft:Distance(hitLeft) > posRight:Distance(hitRight) then
			roll = -(90 -math_deg(math_acos(rollDif /hitLeft:Distance(posRight))))
		else
			roll = 90 -math_deg(math_acos(rollDif /hitRight:Distance(posLeft)))
		end

		local tr = util.TraceLine({
			start = pos,
			endpos = pos -len,
			filter = self
		})

		self.Incline = pitch
		self:ManipulateBonePosition(0,Vector(0,0,Lerp(refreshRate,self:GetManipulateBonePosition(0).z,-(tr.HitPos +tr.HitNormal):Distance(pos))))
		self:SetAngles(LerpAngle(refreshRate,self:GetAngles(),Angle(pitch,ang.y,roll)))
	else
		self.Incline = 0
		self:ManipulateBonePosition(0,Vector(0,0,Lerp(refreshRate,self:GetManipulateBonePosition(0).z,0)))
		self:SetAngles(LerpAngle(refreshRate,self:GetAngles(),Angle(0,ang.y,0)))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.Dead then return end

	self:SetHP(self:Health())
	if !self.IsLatched then
		self:SetGroundAngle()
	end

	if self.IsLatched && self.BirthT && CurTime() > self.BirthT then
		self:GiveBirth()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GiveBirth()
	self.IsLatched = false
	self:SetParent(nil)
	self:SetPos(self.LatchCorpse:GetPos() +self.LatchCorpse:GetUp() *10)
	SafeRemoveEntity(self.LatchFakeFacehugger)
	local ent,corpseEnt,xenoClass,predBurster = self.LatchVictim, self.LatchCorpse, self.LatchCorpse.VJ_AVP_XenoClass, self.LatchCorpse.VJ_AVP_IsPredburster
	if !IsValid(self.VJ_TheController) then
		self:SetHealth(0)
		self.DisableCorpseCleanUp = true
		self:TakeDamage(1000)
		for i = 1,4 do
			timer.Simple(i,function()
				if IsValid(corpseEnt) then
					local phys = corpseEnt:GetPhysicsObject()
					if IsValid(phys) then
						phys:ApplyForceCenter(VectorRand() *math.random(600,1200))
					end
					local bonePos = corpseEnt:LookupBone("ValveBiped.Bip01_Spine4") != nil && corpseEnt:GetBonePosition(corpseEnt:LookupBone("ValveBiped.Bip01_Spine4")) or corpseEnt:GetPos()
					local particle = ents.Create("info_particle_system")
					particle:SetKeyValue("effect_name", corpseEnt.BloodData.Particle or "blood_impact_red_01")
					particle:SetPos(bonePos)
					particle:Spawn()
					particle:Activate()
					particle:Fire("Start")
					particle:Fire("Kill", "", 0.1)
					sound.Play("cpthazama/avp/xeno/chestburster/chestburster_fleshrip_0" .. math.random(1,3) .. ".ogg",bonePos,75)
				end
			end)
		end
		timer.Simple(5,function()
			if IsValid(corpseEnt) then
				local tr = util.TraceLine({
					start = corpseEnt:GetPos() +Vector(0,0,128),
					endpos = corpseEnt:GetPos(),
					filter = {corpseEnt,ent}
				})
				local pos = tr.HitPos +tr.HitNormal *2
				if IsValid(ent) && ent:IsNPC() then
					ent:SetPos(pos)
					ent:SetAngles(corpseEnt:GetAngles())
					ent.HasSounds = true
					hook.Remove("Think",ent)
					ent:SetHealth(0)
				end
				corpseEnt:Remove()
				local chestburster = ents.Create(self.VJ_AVP_K_Xenomorph && "npc_vj_avp_kxeno_chestburster" or "npc_vj_avp_xeno_chestburster")
				chestburster:SetPos(pos)
				chestburster:SetAngles(Angle(0,corpseEnt:GetAngles().y,0))
				chestburster.XenoClass = xenoClass
				chestburster:Spawn()
				chestburster:Activate()
				if predBurster then
					chestburster:SetSkin(1)
				end
				if IsValid(ent) && ent:IsNPC() then
					undo.ReplaceEntity(ent,chestburster)
					ent:TakeDamage(1000)
				end
			end
		end)
	else
		local tr = util.TraceLine({
			start = corpseEnt:GetPos() +Vector(0,0,128),
			endpos = corpseEnt:GetPos(),
			filter = {corpseEnt,ent}
		})
		local pos = tr.HitPos +tr.HitNormal *2
		if IsValid(ent) && ent:IsNPC() then
			ent:SetPos(pos)
			ent:SetAngles(corpseEnt:GetAngles())
			ent.HasSounds = true
			hook.Remove("Think",ent)
			ent:SetHealth(0)
		end
		corpseEnt:Remove()
		local cont = self.VJ_TheController
		self:Remove()
		local chestburster = ents.Create(self.VJ_AVP_K_Xenomorph && "npc_vj_avp_kxeno_chestburster" or "npc_vj_avp_xeno_chestburster")
		chestburster:SetPos(pos)
		chestburster:SetAngles(Angle(0,corpseEnt:GetAngles().y,0))
		chestburster.XenoClass = xenoClass
		chestburster:Spawn()
		chestburster:Activate()
		if predBurster then
			chestburster:SetSkin(1)
		end
		timer.Simple(0.12,function()
			if IsValid(cont) && IsValid(chestburster) then
				local SpawnControllerObject = ents.Create("obj_vj_npccontroller")
				SpawnControllerObject.VJCE_Player = cont
				SpawnControllerObject:SetControlledNPC(chestburster)
				SpawnControllerObject:Spawn()
				SpawnControllerObject:StartControlling()
			end
		end)
		if IsValid(ent) && ent:IsNPC() then
			undo.ReplaceEntity(ent,chestburster)
			ent:TakeDamage(1000)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if IsValid(self.LatchCorpse) && self.DisableCorpseCleanUp != true then
		self.LatchCorpse:Remove()
		if IsValid(self.LatchVictim) && self.LatchVictim:IsNPC() then
			self.LatchVictim:Remove()
		end
	end
end