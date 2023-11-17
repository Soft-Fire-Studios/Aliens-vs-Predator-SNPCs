AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/warrior.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 225
ENT.HullType = HULL_HUMAN
ENT.FindEnemy_CanSeeThroughWalls = true
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.CustomBlood_Particle = {"vj_avp_blood_xeno"}
ENT.VJ_NPC_Class = {"CLASS_XENOMORPH"} -- NPCs with the same class with be allied to each other

ENT.HasMeleeAttack = false

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(15, 0, 0),
    FirstP_ShrinkBone = false
}

ENT.HasExtraMeleeAttackSounds = true
ENT.GeneralSoundPitch1 = 100

ENT.AnimTbl_FatalitiesResponse = {
	["predator_claws_trophy_alien_grab"] = "standing_guard_broken",
	["predator_claws_trophy_alien_lift"] = "pred_trophy_standing_lift",
	["predator_claws_trophy_alien_countered"] = "pred_trophy_countered",
	["predator_claws_trophy_alien_impale"] = "pred_trophy_death_impaled",
	["predator_claws_trophy_alien_kill"] = "pred_trophy_death",
	["predator_claws_trophy_alien_kill_headplant"] = "pred_trophy_death_headplant",
	["predator_claws_trophy_alien_kill_kneeplant"] = "pred_trophy_death_kneeplant",
	["predator_claws_trophy_alien_kill_slow"] = "pred_trophy_death_slow",
	["predator_claws_stealthkill_alien_kill"] = "stealthkill_pred_death",
	["predator_claws_stealthkill_alien_standing_kill"] = "stealthkill_standing_pred_death",
}

ENT.SoundTbl_Alert = {
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_long_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_long_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_scream_long_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_scream_long_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_short_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_hiss_short_02.ogg",
}
ENT.SoundTbl_Attack = {
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_05.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_04.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_06.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_08.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_10.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_taunt_12.ogg",
}
ENT.SoundTbl_CombatIdle = {
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_04.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_growl_short_05.ogg",
}
ENT.SoundTbl_Jump = {
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_04.ogg",
}
ENT.SoundTbl_Pain = {
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_01.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_02.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_03.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_04.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_05.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_06.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_07.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_08.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_09.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_pain_small_10.ogg",
}
ENT.SoundTbl_Death = {
	"cpthazama/avp/xeno/alien/vocals/alien_death_scream_iconic_elephant.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_20.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_21.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_22.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_23.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_24.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_25.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_26.ogg",
	"cpthazama/avp/xeno/alien/vocals/aln_death_scream_27.ogg",
}

ENT.AttackDistance = 130
ENT.AttackDamageDistance = 140
ENT.AttackDamage = 18

ENT.CanSpit = false
ENT.CanStand = true
ENT.CanLeap = true
ENT.CanAttack = true
ENT.CanSetGroundAngle = true
ENT.FaceEnemyMovements = {ACT_RUN_RELAXED,ACT_RUN,ACT_WALK_STIMULATED}
--
local math_acos = math.acos
local math_deg = math.deg
local math_rad = math.rad
local math_abs = math.abs
--
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnChangeActivity(act)
	-- if self.AnimationBehaviors[act] then
	-- 	self.AnimationBehaviors[act](self)
	-- end
	if act == ACT_IDLE then
		local idleAct = self:SelectIdleActivity()
		if idleAct != act then
			self:ResetIdealActivity(idleAct)
		end
	elseif act == ACT_JUMP then
		VJ_CreateSound(self,self.SoundTbl_Jump,76)
	end
end
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
	self.CurrentSet = 1 -- Crawl | 2 = Stand
	self.LastIdleActivity = ACT_IDLE
	self.LastMovementActivity = ACT_RUN
	self.ChangeSetT = CurTime() +1
	self.IsUsingFaceAnimation = false
	self.SprintT = 0
	self.NextSprintT = 0
	self.LastEnemyDistance = 999999

	if self.OnInit then
		self:OnInit()
	end

	hook.Add("PlayerButtonDown", self, function(self, ply, button)
		if ply.VJTag_IsControllingNPC == true && IsValid(ply.VJ_TheControllerEntity) then
			local cent = ply.VJ_TheControllerEntity
            if cent.VJCE_NPC == self then
                cent.VJCE_NPC:OnKeyPressed(ply,button)
            end
        end
    end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKeyPressed(ply,key)
    if key == KEY_E then
		local tr = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +ply:GetAimVector() *125,
			filter = {self,ply}
		})
		local ent = tr.Entity
		if tr.Hit && IsValid(ent) then
			ent:Fire("Use",nil,0,ply,self)
		end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:LongJumpCode(gotoPos,atk)
	if self.InFatality then return end
	if !self.CanLeap then return end
	self.CurrentSet = 1
	self.ChangeSetT = CurTime() +0.5
	local ply = self.VJ_TheController
	local bullseye = self.VJ_TheControllerBullseye
	local aimVec = IsValid(ply) && ply:GetAimVector()
	local tr1
	local canJump = true
	self:SetMoveType(MOVETYPE_STEP)
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND))
	if gotoPos then
		tr1 = util.TraceLine({
			start = self:EyePos(),
			endpos = gotoPos +Vector(0,0,self:OBBMaxs().z),
			filter = {self,ply,bullseye}
		})
		canJump = self:VisibleVec(gotoPos)
	else
		tr1 = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +(IsValid(ply) && aimVec *(atk && 600 or 1000) or self:GetForward() *600),
			filter = {self,ply,bullseye}
		})
	end
	if !canJump then return end
	local firstHit = tr1.HitPos
	local hitNormal = tr1.HitNormal
	local trSt
	if math_abs(hitNormal.x) >= 0.9 or math_abs(hitNormal.y) >= 0.9 then
		// Normal ground stuff
		-- Entity(1):ChatPrint('Wall')
		trSt = tr1
		self.LongJumpType = 2
	-- elseif hitNormal.z == -1 then
		// Ceiling
		-- Entity(1):ChatPrint('Ceiling')
		-- trSt = tr1
		-- self.LongJumpType = 1
	else
		-- Entity(1):ChatPrint('Ground')
		local upCheck1 = util.TraceLine({
			start = firstHit,
			endpos = firstHit +self:GetUp() *200,
			filter = {self,ply,bullseye}
		})
		if upCheck1 then
			local pos = upCheck1.HitPos +(upCheck1.HitPos -self:GetPos()):GetNormalized() *64
			-- VJ.DEBUG_TempEnt(pos, self:GetAngles(), Color(255,242,0), 5)
			trSt = util.TraceLine({
				start = pos,
				endpos = pos +self:GetUp() *-2000,
				filter = {self,ply,bullseye}
			})
			-- VJ.DEBUG_TempEnt(trSt.HitPos, self:GetAngles(), Color(255,0,212), 5)
		else
			trSt = util.TraceLine({
				start = firstHit,
				endpos = firstHit +self:GetUp() *-2000,
				filter = {self,ply,bullseye}
			})
			-- VJ.DEBUG_TempEnt(trSt.HitPos, self:GetAngles(), Color(17,255,0), 5)
		end
		self.LongJumpType = 0
	end
	-- Entity(1):ChatPrint(tostring(hitNormal))
	-- VJ.DEBUG_TempEnt(firstHit, self:GetAngles(), Color(255,0,0), 5)

	local startPos = trSt.HitPos +trSt.HitNormal *4
	-- VJ.DEBUG_TempEnt(startPos, self:GetAngles(), Color(13,0,255), 5)
	self.LongJumpPos = trSt.HitPos
	self.LongJumpAttacking = atk
	self.JumpT = 0
	local anim = "jump_fwd"
	local dist = self:GetPos():Distance(self.LongJumpPos)
	local height = self:GetPos().z -self.LongJumpPos.z
	self:FaceCertainPosition(self.LongJumpPos,1)
	self:VJ_ACT_PLAYACTIVITY(anim,true,false,false)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sdClawFlesh = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_03.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_04.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_05.ogg",
}
local sdClawMiss = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_03.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_04.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_05.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_06.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_07.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_08.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_09.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_10.ogg",
}
local sdMM = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_03.ogg",
}
local sdTail = {
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_01.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_02.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_03.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_01.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_02.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_03.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_04.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_05.ogg",
}
local sdTailMiss = {
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_1.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_2.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_3.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_4.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_5.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_6.ogg",
}

local string_StartWith = string.StartWith
local string_Replace = string.Replace
--
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "jump_start" then
		self.LongJumping = true
		self.JumpStart = self:GetPos()
		self:PlaySound(self.SoundTbl_Jump,75)
	elseif key == "jump_end" then
		self.LongJumping = false
		self:SetLocalVelocity(Vector(0,0,0))
		self:SetVelocity(self:GetForward() *150 +Vector(0,0,-100))
		VJ.EmitSound(self,"cpthazama/avp/humans/human/jumplands/human_land_dirt_01.ogg",75)
		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() +self:GetUp() *-100,
			filter = {self},
			mask = MASK_SOLID_BRUSHONLY
		})
		if tr.Hit then
			local fx = EffectData()
			fx:SetOrigin(tr.HitPos)
			fx:SetScale(2)
			fx:SetMagnitude(2)
			fx:SetNormal(self:GetUp())
			util.Effect("ElectricSpark",fx)
			for i = 1,16 do
				util.Effect("GlassImpact",fx)
			end
		end
		if self.LongJumpType > 0 && self:GetPos():Distance(self.LongJumpPos) <= 60 then
			self:SetMoveType(MOVETYPE_NONE)
			self:CapabilitiesRemove(CAP_MOVE_GROUND)
		end
	elseif key == "step" then
		self:FootStepSoundCode()
	elseif key == "attack" then
		self.AttackDamageDistance = 140
		self.AttackDamageType = DMG_SLASH
		VJ.EmitSound(self,#self:RunDamageCode() > 0 && sdClawFlesh or sdClawMiss,75)
	elseif key == "attack_heavy" then
		self.AttackDamageDistance = 140
		self.AttackDamageType = bit.bor(DMG_SLASH,DMG_VEHICLE)
		VJ.EmitSound(self,#self:RunDamageCode(1.5) > 0 && sdClawFlesh or sdClawMiss,75)
	elseif key == "attack_mouth" then
		self.AttackDamageDistance = 120
		self.AttackDamageType = DMG_SLASH
		self:RunDamageCode(1.25)
		VJ.EmitSound(self,sdMM,75)
	elseif key == "attack_tail" then
		self.AttackDamageDistance = 200
		self.AttackDamageType = bit.bor(DMG_SLASH,DMG_VEHICLE)
		VJ.EmitSound(self,#self:RunDamageCode(2) > 0 && sdTail or sdTailMiss,75)
	elseif string_StartWith(key,"snd") then
		key = string_Replace(key,"snd ","")
		local snd,vol,sndEnt = false,70,self
		if key == "pierce_tail" then
			snd = "cpthazama/avp/weapons/alien/tail/alien_killmove_cheststabgore_in.ogg"
		elseif key == "remove_tail" then
			snd = "cpthazama/avp/weapons/alien/tail/alien_killmove_cheststabgore_out.ogg"
		elseif key == "short_hiss" then
			snd = VJ.PICK("cpthazama/avp/xeno/alien/vocals/alien_hiss_short_01.ogg","cpthazama/avp/xeno/alien/vocals/alien_hiss_short_02.ogg")
		end
		if snd then
			VJ.EmitSound(sndEnt or self,snd,vol or 70)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RunDamageCode(mult)
	local mult = mult or 1
	local hitEnts = VJ.AVP_ApplyRadiusDamage(self,self,self:GetPos() +self:OBBCenter(),self.AttackDamageDistance or 120,(self.AttackDamage or 10) *mult,self.AttackDamageType or DMG_SLASH,true,false,{UseConeDegree=self.MeleeAttackDamageAngleRadius},
	function(ent)
		return ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot() or VJ.IsProp(ent)
	end)
	return hitEnts
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetFatalityOffset(ent)
	local offset = (self:OBBMaxs().y +ent:OBBMaxs().y) *2
	if ent.VJ_AVP_Xenomorph then
		offset = (self:OBBMaxs().y +ent:OBBMaxs().y) *1.25
	elseif ent.VJ_AVP_Predator then
		offset = (self:OBBMaxs().y +ent:OBBMaxs().y) *1.5
	end
	return offset
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack(ent,visible)
	local cont = self.VJ_TheController
	local dist = self.LastEnemyDistance
	local isCrawling = self.CurrentSet == 1

	if IsValid(cont) then
		if cont:KeyDown(IN_ATTACK) && !self:IsBusy() then
			self:AttackCode(isCrawling)
		elseif cont:KeyDown(IN_ATTACK2) && !self:IsBusy() then
			self:AttackCode(isCrawling,5)
		elseif !cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && cont:KeyDown(IN_JUMP) && !self:IsBusy() then
			self:LongJumpCode()
		end
		return
	end

	if visible then
		if self.CanAttack then
			if dist <= self.AttackDistance && !self:IsBusy() then
				self:AttackCode(isCrawling)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AttackCode(isCrawling,forceAttack)
	if self.InFatality then return end
	if !self.CanAttack then return end
	if isCrawling then
		-- print(isCrawling,self:IsMoving(),forceAttack)
		if self:IsMoving() then
			if forceAttack == 5 or forceAttack == nil && math.random(1,4) == 1 then
				// Leap attack
				self.AttackType = 3
				self.AttackSide = self.AttackSide == "right" && "left" or "right"
				self:VJ_ACT_PLAYACTIVITY("crawl_claw_attack_" .. self.AttackSide,true,false,true,0,{OnFinish=function(interrupted,anim)
					if interrupted or self.InFatality then return end
					self:VJ_ACT_PLAYACTIVITY("crawl_claw_attack_" .. self.AttackSide .. "_land",true,false,false)
				end})
			else
				if IsValid(self.VJ_TheController) or math.random(1,3) == 1 then
					// Stand up attack
					self.AttackType = 1
					self.AttackSide = self.AttackSide == "right" && "left" or "right"
					self:PlaySound(self.SoundTbl_Attack,75)
					self:VJ_ACT_PLAYACTIVITY("crawl_stand_attack_" .. self.AttackSide,true,false,true,0,{OnFinish=function(interrupted)
						if interrupted or self.InFatality then return end -- Means we hit something
						if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
							self.AttackSide = self.AttackSide == "right" && "left" or "right"
							local anim = "crawl_stand_attack_" .. self.AttackSide .. "_loop"
							self:PlaySound(self.SoundTbl_Attack,75)
							self:VJ_ACT_PLAYACTIVITY({anim,anim .. "_move",anim .. "_variant1",anim .. "_variant1_move"},true,false,false,0,{OnFinish=function(interrupted)
								if interrupted or self.InFatality then return end
								if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
									self.AttackSide = self.AttackSide == "right" && "left" or "right"
									local anim = "crawl_stand_attack_" .. self.AttackSide .. "_loop"
									self:PlaySound(self.SoundTbl_Attack,75)
									self:VJ_ACT_PLAYACTIVITY({anim,anim .. "_move",anim .. "_variant1",anim .. "_variant1_move"},true,false,false,0,{OnFinish=function(interrupted)
										if interrupted or self.InFatality then return end
										self:VJ_ACT_PLAYACTIVITY("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
											if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
											self.CurrentSet = 1
											self.ChangeSetT = CurTime() +0.5
										end})
									end})
								else
									self:VJ_ACT_PLAYACTIVITY("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
										if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
										self.CurrentSet = 1
										self.ChangeSetT = CurTime() +0.5
									end})
								end
							end})
						else
							self:VJ_ACT_PLAYACTIVITY("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
								if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
								self.CurrentSet = 1
								self.ChangeSetT = CurTime() +0.5
							end})
						end
					end})
				else
					// Gesture claw attack
					self.AttackType = 2
					self.AttackSide = self.AttackSide == "right" && "left" or "right"
					self:VJ_ACT_PLAYACTIVITY("claw_swipe_" .. self.AttackSide .. "_mid",true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted,anim)
						if interrupted or self.InFatality then return end
						self:VJ_ACT_PLAYACTIVITY("claw_swipe_" .. self.AttackSide .. "_mid_return",true,false,false,0,{AlwaysUseGesture=true})
						self.NextChaseTime = 0
					end})
					self.NextChaseTime = 0
				end
			end
		else
			if forceAttack == 5 or forceAttack == nil && !IsValid(self.VJ_TheController) && math.random(1,4) == 1 then
				// Heavy attack
				self.AttackType = 5
				self:VJ_ACT_PLAYACTIVITY("melee_heavy_attack_charge_up",true,false,true,0,{OnFinish=function(interrupted)
					if interrupted or self.InFatality then return end
					self:PlaySound(self.SoundTbl_Attack,75)
					self:VJ_ACT_PLAYACTIVITY({"melee_heavy_attack_medium","melee_heavy_attack_short"},true,false,true)
				end})
			elseif IsValid(self.VJ_TheController) or math.random(1,3) == 1 then
				// Stand up attack
				self.AttackType = 1
				self.AttackSide = self.AttackSide == "right" && "left" or "right"
				self:PlaySound(self.SoundTbl_Attack,75)
				self:VJ_ACT_PLAYACTIVITY("crawl_stand_attack_" .. self.AttackSide,true,false,true,0,{OnFinish=function(interrupted)
					if interrupted or self.InFatality then return end -- Means we hit something
					if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
						self.AttackSide = self.AttackSide == "right" && "left" or "right"
						local anim = "crawl_stand_attack_" .. self.AttackSide .. "_loop"
						self:PlaySound(self.SoundTbl_Attack,75)
						self:VJ_ACT_PLAYACTIVITY({anim,anim .. "_move",anim .. "_variant1",anim .. "_variant1_move"},true,false,false,0,{OnFinish=function(interrupted)
							if interrupted or self.InFatality then return end
							if IsValid(self.VJ_TheController) && self.VJ_TheController:KeyDown(IN_ATTACK) or !IsValid(self.VJ_TheController) && IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
								self.AttackSide = self.AttackSide == "right" && "left" or "right"
								local anim = "crawl_stand_attack_" .. self.AttackSide .. "_loop"
								self:PlaySound(self.SoundTbl_Attack,75)
								self:VJ_ACT_PLAYACTIVITY({anim,anim .. "_move",anim .. "_variant1",anim .. "_variant1_move"},true,false,false,0,{OnFinish=function(interrupted)
									if interrupted or self.InFatality then return end
									self:VJ_ACT_PLAYACTIVITY("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
										if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
										self.CurrentSet = 1
										self.ChangeSetT = CurTime() +0.5
									end})
								end})
							else
								self:VJ_ACT_PLAYACTIVITY("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
									if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
									self.CurrentSet = 1
									self.ChangeSetT = CurTime() +0.5
								end})
							end
						end})
					else
						self:VJ_ACT_PLAYACTIVITY("crawl_stand_attack_" .. self.AttackSide .. "_end",true,false,false,0,{OnFinish=function(interrupted,anim)
							if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
							self.CurrentSet = 1
							self.ChangeSetT = CurTime() +0.5
						end})
					end
				end})
			else
				// Claw attack
				self.AttackType = 0
				local side = math.random(1,2)
				self:VJ_ACT_PLAYACTIVITY("all4s_claw_swipe_" .. side,true,false,true,0,{OnFinish=function(interrupted,anim)
					if interrupted or self.InFatality then return end -- Means we hit something and started the return animation
					self:VJ_ACT_PLAYACTIVITY("all4s_claw_swipe_" .. side .. "_return",true,false,false)
				end})
			end
		end
	else
		if self:IsMoving() then
			// Gesture claw attack
			if forceAttack == 5 or forceAttack == nil && !IsValid(self.VJ_TheController) && math.random(1,4) == 1 then
				self.AttackType = 5
				self:VJ_ACT_PLAYACTIVITY("melee_heavy_attack_charge_up",true,false,true,0,{OnFinish=function(interrupted)
					if interrupted or self.InFatality then return end
					self:PlaySound(self.SoundTbl_Attack,75)
					self:VJ_ACT_PLAYACTIVITY("melee_heavy_attack_long",true,false,true)
				end})
			else
				self.AttackType = 2
				self.AttackSide = self.AttackSide == "right" && "left" or "right"
				self:VJ_ACT_PLAYACTIVITY("light_attack_" .. self.AttackSide .. "_mid",true,false,true,0,{AlwaysUseGesture=true})
				self.NextChaseTime = 0
			end
		else
			if forceAttack == 5 or forceAttack == nil && !IsValid(self.VJ_TheController) && math.random(1,4) == 1 then
				// Heavy attack
				self.AttackType = 5
				self:VJ_ACT_PLAYACTIVITY("melee_heavy_attack_charge_up",true,false,true,0,{OnFinish=function(interrupted)
					if interrupted or self.InFatality then return end
					self:PlaySound(self.SoundTbl_Attack,75)
					self:VJ_ACT_PLAYACTIVITY({"melee_heavy_attack_medium","melee_heavy_attack_short"},true,false,true)
				end})
			else
				// Stand up attack
				self.AttackType = 1
				self.AttackSide = self.AttackSide == "right" && "left" or "right"
				self:PlaySound(self.SoundTbl_Attack,75)
				self:VJ_ACT_PLAYACTIVITY("light_step_attack_" .. self.AttackSide .. "_mid",true,false,true,0,{OnFinish=function(interrupted)
					if interrupted or self.InFatality then return end -- Means we hit something
					if IsValid(self:GetEnemy()) && self.LastEnemyDistance <= 130 then
						self.AttackSide = self.AttackSide == "right" && "left" or "right"
						self:PlaySound(self.SoundTbl_Attack,75)
						self:VJ_ACT_PLAYACTIVITY("light_step_attack_" .. self.AttackSide .. "_mid",true,false,true,0,{OnFinish=function(interrupted)
							if interrupted or self.InFatality or IsValid(self.VJ_TheController) then return end
							self.AttackSide = self.AttackSide == "right" && "left" or "right"
							self:VJ_ACT_PLAYACTIVITY({"light_attack_" .. self.AttackSide .. "_to_run_fwd","light_attack_" .. self.AttackSide .. "_to_crawl_fwd"},true,false,true,0,{OnFinish=function(interrupted,anim)
								if interrupted or self.InFatality then return end
								self.CurrentSet = (anim == "light_attack_" .. self.AttackSide .. "_to_run_fwd") && 2 or 1
								self.ChangeSetT = CurTime() +0.5
							end})
						end})
					end
				end})
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Gibs()
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(300)
	util.Effect("VJ_Blood1",bloodeffect)

	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetGroundAngle(curSet)
	if self.InFatality then curSet = 0 end
	if !self.CanSetGroundAngle then return end
	local pos = self:GetPos()
	local len = self:GetUp() *50
	local ang = self:GetAngles()
	local ang_y = Angle(0,ang.y,0)
	local refreshRate = FrameTime() *20
	if curSet == 1 /*&& self:OnGround()*/ then
		local mins, maxs = self:GetCollisionBounds()
		-- mins = mins *2
		-- maxs = maxs *2
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
local VJ_HasValue = VJ.HasValue
local startCycle = 0.23
local endCycle = 0.65
--
function ENT:CustomOnThink_AIEnabled()
	if self.Dead then return end
	if self.InFatality then
		if !IsValid(self.FatalityKiller) then
			self.InFatality = false
			self:SetState()
			self:SetHealth(0)
			self:TakeDamage(1000,self,self)
		else
			-- self:SetCycle(self.FatalityKiller:GetCycle())
		end
		return
	end
	local curTime = CurTime()
	local ent = self:GetEnemy()
	local ply = self.VJ_TheController
	local curSet = self.CurrentSet
	local idleAct = self:SelectIdleActivity()
	local moveAct = self:SelectMovementActivity()
	if self.LastIdleActivity != idleAct then
		self.LastIdleActivity = idleAct
		self:SetIdleAnimation({idleAct})
		self:SetArrivalActivity(idleAct)
	end
	if self.LastMovementActivity != moveAct then
		self.LastMovementActivity = moveAct
		self.AnimTbl_Walk = {moveAct}
		self.AnimTbl_Run = {moveAct}
	end

	if self.HasBreath then
		self:Breathe()
	end
	self:SetGroundAngle(curSet)

	if self.LongJumping && self.LongJumpPos then
		self.JumpT = self.JumpT +0.1
		local currentPos = self:GetPos()
		local dist = currentPos:Distance(self.LongJumpPos)
		local targetPos = self.LongJumpPos +(dist < 250 && self:OBBCenter() *0.3 or self:OBBCenter() *0.5)
		local moveDirection = (targetPos -currentPos):GetNormalized()
		local moveSpeed = (dist < 250 && 800 or dist *4)
		local newPos = currentPos +moveDirection *moveSpeed *FrameTime()
		self:SetLocalVelocity(moveDirection *moveSpeed)
		if dist >= 70 && self.JumpT <= 1 then
			self:SetCycle(0.5)
			self.NextChaseTime = CurTime() +1
			self.NextIdleTime = CurTime() +1
		end
	end

	if self.OnThink then
		self:OnThink()
	end

	self:SetSprinting(self:IsMoving() && (self:GetActivity() == ACT_SPRINT or self:GetActivity() == ACT_MP_SPRINT))
	self:SetPoseParameter("standing", Lerp(FrameTime() *10,self:GetPoseParameter("standing"),curSet -1))

	local sprinting = self:GetSprinting()
	-- self.CanAttack = !sprinting
	if sprinting then
		if self:GetActivity() == ACT_SPRINT && self:OnGround() then
			self:SetVelocity(self:GetMoveVelocity() *1.25)
		end
		self.SprintT = self.SprintT +0.1
		if self.SprintT >= 4 then
			self.NextSprintT = curTime +3
		end
	else
		if self.SprintT > 0 then
			self.SprintT = self.SprintT -0.2
		end
	end
	self.IsUsingFaceAnimation = VJ_HasValue(self.FaceEnemyMovements,moveAct)
	if IsValid(ply) then
		-- if ply:KeyDown(IN_WALK) then -- Wall walking
		-- 	if ply:KeyDown(IN_FORWARD) then
		-- 		local tr = util.TraceLine({
		-- 			start = self:GetPos(),
		-- 			endpos = self:GetPos() +ply:GetAimVector() *250,
		-- 			filter = {self,ply}
		-- 		})
		-- 		local touchDir = {L=false,R=false,U=false,D=false}
		-- 		for i = 1,4 do
		-- 			local dir = i == 1 && ply:GetRight() or i == 2 && ply:GetRight() *-1 or i == 3 && ply:GetUp() or ply:GetUp() *-1
		-- 			local tr = util.TraceLine({
		-- 				start = self:GetPos(),
		-- 				endpos = self:GetPos() +dir *250,
		-- 				filter = {self,ply}
		-- 			})
		-- 			if tr.Hit then
		-- 				if i == 1 then
		-- 					touchDir.R = true
		-- 				elseif i == 2 then
		-- 					touchDir.L = true
		-- 				elseif i == 3 then
		-- 					touchDir.U = true
		-- 				elseif i == 4 then
		-- 					touchDir.D = true
		-- 				end
		-- 			end
		-- 		end
		-- 		local moveSpeed = self:GetSequenceGroundSpeed(self:GetSequence())
		-- 		local moveDirection = (tr.HitPos -self:GetPos()):GetNormalized()
		-- 		self:SetLocalVelocity(moveDirection *(moveSpeed <= 0 && 100 or moveSpeed))
		-- 		self:SetMoveType(MOVETYPE_STEP)
		-- 		self:SetNavType(NAV_FLY)
		-- 		self:ResetIdealActivity(moveAct)
		-- 	else
		-- 		self:SetLocalVelocity(Vector(0,0,0))
		-- 		self:SetMoveType(MOVETYPE_NONE)
		-- 		self:SetNavType(NAV_GROUND)
		-- 		self:ResetIdealActivity(idleAct)
		-- 	end
		-- end
		if ply:KeyDown(IN_DUCK) then
			if curTime > self.ChangeSetT then
				self.CurrentSet = curSet == 1 && 2 or 1
				self.ChangeSetT = curTime +0.5
			end
		end
	else
		self.ConstantlyFaceEnemy = self.IsUsingFaceAnimation
		if IsValid(ent) then
			local dist = self.LastEnemyDistance
			if curTime > self.ChangeSetT then
				if curSet == 1 then
					if dist < 750 && math.random(1,20) == 1 then
						self.CurrentSet = 2
						self.ChangeSetT = curTime +math.Rand(15,35)
					end
				else
					if dist >= 750 && math.random(1,10) == 1 then
						self.CurrentSet = 1
						self.ChangeSetT = curTime +math.Rand(15,35)
					end
				end
			end
		else
			if curTime > self.ChangeSetT then
				self.CurrentSet = 1
				self.ChangeSetT = curTime +math.Rand(3,8)
			end
		end
	end
	if IsValid(ent) then
		self.LastEnemyDistance = self:VJ_GetNearestPointToEntityDistance(ent)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local bit_band = bit.band
local math_Clamp = math.Clamp
--
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if dmginfo:IsBulletDamage() then
		if dmginfo:GetDamage() <= 30 then
			dmginfo:SetDamage(dmginfo:GetDamage() <= 10 && 0 or math_Clamp(dmginfo:GetDamage() *0.2,1,30))
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	self:Acid(dmginfo:GetDamagePosition(),125,5)

	local explosion = dmginfo:IsExplosionDamage()
	if self:Health() > 0 && (explosion or dmginfo:GetDamage() > 100 or bit_band(dmginfo:GetDamageType(),DMG_SNIPER) == DMG_SNIPER or bit_band(dmginfo:GetDamageType(),DMG_VEHICLE) == DMG_VEHICLE or (dmginfo:GetAttacker().VJ_IsHugeMonster && bit_band(dmginfo:GetDamageType(),DMG_CRUSH) == DMG_CRUSH)) then
		local dmgAng = ((explosion && dmginfo:GetDamagePosition() or dmginfo:GetAttacker():GetPos()) -self:GetPos()):Angle()
		dmgAng.p = 0
		dmgAng.r = 0
		self:TaskComplete()
		self:StopMoving()
		self:ClearSchedule()
		self:ClearGoal()
		self:SetAngles(dmgAng)
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		-- self.CanFlinch = 0
		local dmgDir = self:GetDamageDirection(dmginfo)
		self:VJ_ACT_PLAYACTIVITY(dmgDir == 4 && "standing_knockdown_forward" or "standing_knockdown_back",true,false,false,0,{OnFinish=function(interrupted)
			if interrupted then return end
			self:SetState()
			-- self.CanFlinch = 1
		end})
		self.NextCallForBackUpOnDamageT = CurTime() +1
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled()
	self:Acid(self:GetPos(),200,25)
	if self:GetState() == VJ_STATE_NONE then
		for i = 1,self:GetBoneCount() -1 do
			if math.random(1,4) <= 3 then continue end
			local bone = self:GetBonePosition(i)
			if bone then
				local particle = ents.Create("info_particle_system")
				particle:SetKeyValue("effect_name", VJ.PICK(self.CustomBlood_Particle))
				particle:SetPos(bone +VectorRand() *15)
				particle:Spawn()
				particle:Activate()
				particle:Fire("Start")
				particle:Fire("Kill", "", 0.1)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity()
	local act = ACT_RUN
	local ply = self.VJ_TheController
	local standing = self.CurrentSet == 2
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			act = standing && ACT_WALK or ACT_WALK_RELAXED
		elseif ply:KeyDown(IN_SPEED) && self.NextSprintT < CurTime() then
			act = standing && ACT_MP_SPRINT or ACT_SPRINT
		else
			act = standing && ACT_RUN or ACT_RUN_RELAXED
		end
		return act
	end
	local currentSchedule = self.CurrentSchedule
	if currentSchedule != nil then
		if currentSchedule.MoveType == 0 then
			act = standing && (self.Alerted == true && ACT_WALK_STIMULATED or ACT_WALK) or ACT_WALK_RELAXED
		else
			if self.NextSprintT < CurTime() then
				act = standing && ACT_MP_SPRINT or ACT_SPRINT
			else
				act = standing && ACT_RUN or ACT_RUN_RELAXED
			end
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity()
	local act = ACT_IDLE
	local standing = self.CurrentSet == 2
	-- if standing then
		-- act = ACT_IDLE_STIMULATED
	-- else
		act = ACT_IDLE
	-- end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnChangeActivity(newAct)
	//print(newAct)
	local funcCustom = self.CustomOnChangeActivity; if funcCustom then funcCustom(self, newAct) end
	if newAct == ACT_TURN_LEFT or newAct == ACT_TURN_RIGHT then
		self.NextIdleStandTime = CurTime() + VJ.AnimDuration(self, self:GetSequenceName(self:GetSequence()))
		//self.NextIdleStandTime = CurTime() + 1.2
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, ent)
	ent.VJ_AVP_Xenomorph = true
	ent:SetNW2Bool("AVP.Xenomorph",true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlaySound(sndTbl,level,pitch,setCurSnd)
	if sndTbl == nil or istable(sndTbl) && #sndTbl <= 0 then return 0 end
	if setCurSnd then
		self:StopAllCommonSpeechSounds()
	end
	local sndName = VJ_PICK(sndTbl)
	local snd = VJ_CreateSound(self,sndName,level or 75,pitch or math.random(self.GeneralSoundPitch1,self.GeneralSoundPitch2))
	if setCurSnd then
		self.CurrentVoiceLine = snd
	end
	self.DeleteSounds = self.DeleteSounds or {}
	table.insert(self.DeleteSounds,snd)
	return SoundDuration(sndName)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	VJ_STOPSOUND(self.CurrentVoiceLine)
	if self.DeleteSounds then
		for _,v in pairs(self.DeleteSounds) do
			VJ_STOPSOUND(v)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local math_acos = math.acos
local math_abs = math.abs
local math_rad = math.rad
local math_deg = math.deg
local math_atan2 = math.atan2
--
function ENT:GetDamageDirection(dmginfo)
	local dir = (self:GetPos() +self:OBBCenter()) -dmginfo:GetDamagePosition()
	dir:Normalize()
	dir.z = 0.5

	local hitDir = 1
	local forward = self:GetForward()
	local angle = math_deg(math_atan2(dir:Dot(forward:Cross(Vector(0,0,1))),dir:Dot(forward)))
	if angle >= 45 and angle <= 135 then
		-- print("NPC was hit from the left")
		hitDir = 2
	elseif angle >= -135 and angle <= -45 then
		-- print("NPC was hit from the right")
		hitDir = 3
	elseif angle >= 135 or angle <= -135 then
		-- print("NPC was hit from the front")
		hitDir = 1
	else
		-- print("NPC was hit from the back")
		hitDir = 4
	end

	return hitDir
end