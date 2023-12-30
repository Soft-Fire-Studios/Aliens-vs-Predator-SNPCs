AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/queen.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 3000
ENT.HullType = HULL_LARGE

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, 20),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(25, 0, -3),
    FirstP_ShrinkBone = false
}

ENT.HasBreath = true

ENT.CanLeap = false
ENT.CanSetGroundAngle = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	if VJ_AVP_QueenExists(self) then
		self:Remove()
		if game.SinglePlayer() then
			Entity(1):ChatPrint("There can only be one Queen at a time!")
		else
			if IsValid(self:GetCreator()) then
				self:GetCreator():ChatPrint("There can only be one Queen at a time!")
			end
		end
		return
	end
	self.CurrentSet = 2
	self.SoundTbl_FootStep = {
		"cpthazama/avp/xeno/queen/alien_queen_footstep_01.wav",
		"cpthazama/avp/xeno/queen/alien_queen_footstep_02.wav",
		"cpthazama/avp/xeno/queen/alien_queen_footstep_03.wav",
	}
	if GetConVar("vj_avp_bosstheme_a"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/Full Tilt Rampage.mp3"}
	end

	self.InBirth = false
	self.NextLookForBirthT = CurTime() +5
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
	if self.Alerted then
		self.NextLookForBirthT = CurTime() +60
	end
	if !self.InBirth && CurTime() > self.NextLookForBirthT then
		if !self:IsBusy() && !self:IsMoving() then
			local vsched = vj_ai_schedule.New("vj_idle_wander")
			vsched:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 2000)
			vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
			vsched.IsMovingTask = true
			self:SetMovementActivity(VJ.PICK(self.AnimTbl_Run))
			vsched.MoveType = 1
			if (customFunc) then customFunc(vsched) end
			self:StartSchedule(vsched)
		end
		local check = Vector(self:OBBMaxs().x *9,self:OBBMaxs().y *9,0)
		local trHull = util.TraceHull({
			start = self:GetPos(),
			endpos = self:GetPos(),
			filter = self,
			mins = check *-1,
			maxs = check,
		})
		if !trHull.Hit then
			self.InBirth = true
		end
	elseif self.InBirth then
		if !IsValid(self.EggSack) then
			local eggsack = ents.Create("prop_vj_animatable")
			eggsack:SetModel("models/cpthazama/avp/xeno/queen_eggsack.mdl")
			eggsack:SetPos(self:GetPos() +self:GetForward() *18 +self:GetUp() *-10)
			eggsack:SetAngles(self:GetAngles())
			eggsack:SetOwner(self)
			eggsack:SetParent(self)
			eggsack:Spawn()
			eggsack:Activate()
			eggsack:SetRenderMode(RENDERMODE_TRANSALPHA)
			eggsack:SetColor(Color(255,255,255,0))
			eggsack:SetRenderFX(kRenderFxSolidSlow)
			eggsack:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			eggsack:AddEffects(EF_PARENT_ANIMATES)
			eggsack:ResetSequence("idle")
			self:DeleteOnRemove(eggsack)
			self.EggSack = eggsack
			self:VJ_ACT_PLAYACTIVITY("Alien_Queen_eggsack_enter",true,false,false)
			self:PlaySound({"^cpthazama/avp/xeno/alien/hud/queen_message_new_objective_01.ogg","^cpthazama/avp/xeno/alien/hud/queen_message_objective_complete_01.ogg"},150)
			self:SetIdleAnimation({ACT_IDLE_RELAXED},true)
		end
		if self:IsMoving() then
			self:StopMoving()
		end
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Breathe()
	if CurTime() > (self.NextBreathT or 0) then
		local snd = "cpthazama/avp/xeno/alien queen/queen_breath_2.wav"
		VJ_CreateSound(self,snd,72)
		self.NextBreathT = CurTime() +SoundDuration(snd)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity()
	local act = ACT_RUN
	local ply = self.VJ_TheController
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			act = ACT_WALK
		elseif self.Charging then
			act = ACT_SPRINT
		end
		return act
	end
	if self.Charging then
		act = ACT_SPRINT
	else
		local currentSchedule = self.CurrentSchedule
		if currentSchedule != nil then
			act = currentSchedule.MoveType == 0 && ACT_WALK or ACT_RUN
		end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity()
	return ACT_IDLE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectTurnActivity(inAct)
	return inAct
end