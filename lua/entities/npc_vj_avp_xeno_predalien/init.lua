AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/predalien.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 1500
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
ENT.FootStepSoundLevel = 82

ENT.AttackDamageMultiplier = 2.35
ENT.AlwaysStand = true
ENT.TranslateActivities = {
	[ACT_IDLE] = ACT_HL2MP_IDLE_SMG1,
	[ACT_WALK] = ACT_HL2MP_WALK_SMG1,
	[ACT_RUN] = ACT_HL2MP_RUN_SMG1,
	[ACT_MP_SPRINT] = ACT_HL2MP_RUN_SMG1,
	-- [ACT_TURN_LEFT] = ACT_ROLL_LEFT,
	-- [ACT_TURN_RIGHT] = ACT_ROLL_RIGHT,
}
ENT.FaceEnemyMovements = {ACT_HL2MP_WALK_SMG1,ACT_HL2MP_RUN_SMG1}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	-- self.CurrentSet = 2
	if GetConVar("vj_avp_bosstheme_a"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/The Unstoppable.mp3"}
	end

	self.SoundTbl_Alert = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_02.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_03.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_04.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_05.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_06.ogg",
	}
	self.SoundTbl_Attack = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_trophy_struggle_02.ogg",
	}
	self.SoundTbl_CombatIdle = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_02.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_03.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_04.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_05.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_taunt_06.ogg",
		"cpthazama/avp/xeno/predalien/predalien_scream_p01.ogg",
	}
	self.SoundTbl_Jump = {
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_01.ogg",
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_02.ogg",
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_03.ogg",
		"cpthazama/avp/xeno/alien/vocals/alien_jump_grunt_04.ogg",
	}
	self.SoundTbl_Pain = {
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_01.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_02.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_04.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_05.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_06.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_07.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_08.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_09.ogg",
		"cpthazama/avp/xeno/praetorian/vocal/praetorian_pain_10.ogg",
	}
	self.SoundTbl_Death = {
		"cpthazama/avp/xeno/predalien/predalien_death_scream_01.ogg",
	}

	self.FootData = {
		["lfoot"] = {Range=24,OnGround=true},
		["rfoot"] = {Range=24,OnGround=true}
	}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnStep(pos,name)
	util.ScreenShake(pos,5,100,0.35,500)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Breathe()
	if CurTime() > (self.NextBreathT or 0) then
		local snd = "cpthazama/avp/xeno/alien queen/alien_queen_breathe_in_0" .. math.random(1,3) .. ".ogg"
		local sndB = "cpthazama/avp/xeno/alien queen/alien_queen_breathe_out_0" .. math.random(1,3) .. ".ogg"
		VJ_CreateSound(self,snd,65,90)
		timer.Simple(1.25,function()
			if IsValid(self) then
				VJ_CreateSound(self,sndB,65,90)
			end
		end)
		self.NextBreathT = CurTime() +2.5
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if self.TranslateActivities[act] then
		return self.TranslateActivities[act]
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity()
	return ACT_IDLE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity()
	local act = ACT_RUN
	local ply = self.VJ_TheController
	local standing = self.CurrentSet == 2
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			act = ACT_WALK
		end
		return act
	end
	local currentSchedule = self.CurrentSchedule
	if currentSchedule != nil then
		if currentSchedule.MoveType == 0 then
			act = ACT_WALK
		end
	end
	return act
end