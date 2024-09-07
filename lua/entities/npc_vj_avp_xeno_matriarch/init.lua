AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/queen_hag.mdl"} -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 6000
ENT.HullType = HULL_LARGE

ENT.SoundTbl_FootStep = {
	"cpthazama/avp/xeno/queen/alien_queen_footstep_01.wav",
	"cpthazama/avp/xeno/queen/alien_queen_footstep_02.wav",
	"cpthazama/avp/xeno/queen/alien_queen_footstep_03.wav",
}

ENT.StandingBounds = Vector(25,25,200)
ENT.CrawlingBounds = Vector(25,25,200)
ENT.CanBlock = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	if VJ_AVP_MatriarchExists(self) then
		self:Remove()
		if game.SinglePlayer() then
			Entity(1):ChatPrint("There can only be one Matriarch at a time!")
		else
			if IsValid(self:GetCreator()) then
				self:GetCreator():ChatPrint("There can only be one Matriarch at a time!")
			end
		end
		return
	end

	self.AttackProps = true
	self.PushProps = true
	self.HasRangeAttack = true
	self.PropAP_MaxSize = 1.65
	self.FootStepSoundLevel = 75
	self.FootStepPitch1 = 60
	self.FootStepPitch2 = 70
	self.SoundTbl_FootSteps = {
		[MAT_CONCRETE] = {
			"cpthazama/avp/xeno/alien queen/alien_queen_footstep_01.ogg",
			"cpthazama/avp/xeno/alien queen/alien_queen_footstep_02.ogg",
			"cpthazama/avp/xeno/alien queen/alien_queen_footstep_03.ogg",
		}
	}
	self.SoundTbl_Alert = {
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_02.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_09.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_10.ogg",}
	self.SoundTbl_Attack = {
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_01.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_03.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_04.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_07.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_08.ogg",
	}
	self.SoundTbl_CombatIdle = {}
	self.SoundTbl_BeforeRangeAttack = {}
	self.SoundTbl_RangeAttack = {}
	self.SoundTbl_Jump = {}
	self.SoundTbl_Pain = {
		"cpthazama/avp/xeno/alien hag queen/alien_hag_queen_scream_short_01.ogg",
		"cpthazama/avp/xeno/alien hag queen/alien_hag_queen_scream_short_02.ogg",
		"cpthazama/avp/xeno/alien hag queen/alien_hag_queen_scream_short_03.ogg"
	}
	self.SoundTbl_Death = {
		"^cpthazama/avp/xeno/alien/vocals/queen death.ogg"
	}
	if GetConVar("vj_avp_bosstheme_a"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/Full Tilt Rampage.mp3"}
	end

	self.FootData = {
		["lfoot"] = {Range=70,OnGround=true},
		["rfoot"] = {Range=70,OnGround=true}
	}
	
	self.AnimTbl_Fatalities = nil
	self.AnimTbl_FatalitiesResponse = nil

	self.CanFlinch = 1
	self.FlinchChance = 45
	self.NextFlinchTime = 8
	self.AnimTbl_Flinch = {"Alien_Queen_charge_collide_injured"}
	self.AnimTbl_FlinchCrouch = {"Alien_Queen_charge_collide_injured"}
	self.AnimTbl_FlinchStand = {"Alien_Queen_charge_collide_injured"}

	self.InBirth = false
	-- self.NextLookForBirthT = CurTime() +60
	self.NextLookForBirthT = CurTime() +10
	self.NextSpawnEggT = 0
	self.NextCommandXenosT = 0
	self.Eggs = {}
	self.InCharge = false
	self.ChargeT = 0
	self.NextSpecialEggCheckT = CurTime() +5

	self:SetStepHeight(66)
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- function ENT:SelectMovementActivity()
-- 	return self.InCharge && ACT_SPRINT or ACT_WALK
-- end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	if math.random(1,2) == 1 && !self:IsBusy() then
		VJ.STOPSOUND(self.CurrentSpeechSound)
		VJ.STOPSOUND(self.CurrentIdleSound)
		self:VJ_ACT_PLAYACTIVITY("Alien_Queen_fidget_roar",true,false,false)
		self:PlaySound("^cpthazama/avp/xeno/alien/hud/queen_message_new_objective_01.ogg",120)
		util.ScreenShake(self:EyePos(),16,200,4,1000,true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnCallForHelp(ally)
	if self:IsBusy() then return end
	VJ.STOPSOUND(self.CurrentSpeechSound)
	VJ.STOPSOUND(self.CurrentIdleSound)
	self:VJ_ACT_PLAYACTIVITY("Alien_Queen_fidget_roar",true,false,false)
	self:PlaySound("^cpthazama/avp/xeno/alien/hud/queen_message_new_objective_01.ogg",120)
	util.ScreenShake(self:EyePos(),16,200,4,1000,true)
end