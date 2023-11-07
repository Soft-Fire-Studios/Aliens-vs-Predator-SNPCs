AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/praetorian.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 2500
ENT.VJ_IsHugeMonster = true
ENT.HullType = HULL_LARGE

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(20, 0, 0),
    FirstP_ShrinkBone = false
}

ENT.HasBreath = true
ENT.SoundTbl_FootStep = {
	"cpthazama/avp/xeno/queen/alien_queen_footstep_01.wav",
	"cpthazama/avp/xeno/queen/alien_queen_footstep_02.wav",
	"cpthazama/avp/xeno/queen/alien_queen_footstep_03.wav",
}
ENT.SoundTbl_Alert = {
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_01.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_02.wav",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_01.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_02.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_03.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_04.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_05.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_06.wav",
}
ENT.SoundTbl_Pain = {
	"cpthazama/avp/xeno/praetorian/praetorian_pain_01.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_02.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_04.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_05.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_06.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_07.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_08.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_09.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_10.wav",
}
ENT.SoundTbl_Death = {
	"cpthazama/avp/xeno/predalien/predalien_death_scream_01.wav"
}

ENT.AnimationBehaviors = {}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Breathe()
	if CurTime() > (self.NextBreathT or 0) then
		local snd = "cpthazama/avp/xeno/queen/alien_queen_breathe_in_0" .. math.random(1,3) .. ".wav"
		local sndB = "cpthazama/avp/xeno/queen/alien_queen_breathe_out_0" .. math.random(1,3) .. ".wav"
		VJ_CreateSound(self,snd,62)
		timer.Simple(SoundDuration(snd) +0.15,function()
			if IsValid(self) then
				VJ_CreateSound(self,sndB,62)
			end
		end)
		self.NextBreathT = CurTime() +SoundDuration(snd) +SoundDuration(sndB) +0.3
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity()
	local act = ACT_RUN
	local ply = self.VJ_TheController
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			act = ACT_WALK
		else
			act = ply:KeyDown(IN_SPEED) && ACT_RUN or ACT_WALK_STIMULATED
		end
		return act
	end
	if self.Charging then
		act = ACT_SPRINT
	else
		local currentSchedule = self.CurrentSchedule
		if currentSchedule != nil then
			act = currentSchedule.MoveType == 0 && (self.Alerted && ACT_WALK_STIMULATED or ACT_WALK) or ACT_RUN
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