AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/player/guerilla.mdl","models/player/phoenix.mdl","models/player/leet.mdl"}
ENT.StartHealth = 50
ENT.SightDistance = 3200
ENT.UsePlayerModelMovement = true
ENT.NextProcessTime = 2

ENT.BloodColor = "Red"

ENT.VJ_NPC_Class = {"CLASS_AVP_HUNT_ENEMY"}

ENT.HasMeleeAttack = true
ENT.AnimTbl_MeleeAttack = "vjseq_seq_meleeattack01"

ENT.HasGrenadeAttack = true
ENT.TimeUntilGrenadeIsReleased = 0.85
ENT.AnimTbl_GrenadeAttack = "vjges_gesture_item_throw"

ENT.AnimTbl_Medic_GiveHealth = "vjges_gesture_item_drop"
ENT.AnimTbl_CallForHelp = {"vjges_gesture_signal_group", "vjges_gesture_signal_forward"}
ENT.CallForBackUpOnDamageAnimation = "vjges_gesture_signal_halt"

ENT.FootStepTimeRun = 0.3
ENT.FootStepTimeWalk = 0.5

ENT.CanFlinch = 1
ENT.NextFlinchTime = 1
ENT.AnimTbl_Flinch = {"vjges_flinch_01", "vjges_flinch_02"}
ENT.HitGroupFlinching_Values = {
	{HitGroup = {HITGROUP_HEAD}, Animation = {"vjges_flinch_head_01", "vjges_flinch_head_02"}},
	{HitGroup = {HITGROUP_CHEST}, Animation = {"vjges_flinch_phys_01", "vjges_flinch_phys_02", "vjges_flinch_back_01"}},
	{HitGroup = {HITGROUP_STOMACH}, Animation = {"vjges_flinch_stomach_01", "vjges_flinch_stomach_02"}},
	{HitGroup = {HITGROUP_LEFTARM}, Animation = {"vjges_flinch_shoulder_l"}},
	{HitGroup = {HITGROUP_RIGHTARM}, Animation = {"vjges_flinch_shoulder_r"}}
}

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {"vjseq_death_02", "vjseq_death_03", "vjseq_death_04"}
ENT.DeathAnimationChance = 2

ENT.SoundTbl_FootStep = {"npc/footsteps/hardboot_generic1.wav","npc/footsteps/hardboot_generic2.wav","npc/footsteps/hardboot_generic3.wav","npc/footsteps/hardboot_generic4.wav","npc/footsteps/hardboot_generic5.wav","npc/footsteps/hardboot_generic6.wav","npc/footsteps/hardboot_generic8.wav"}
ENT.SoundTbl_LostEnemy = {"bot/where_are_you_hiding.wav","bot/where_are_they.wav"}
ENT.SoundTbl_Pain = {"bot/pain2.wav","bot/pain4.wav"}
ENT.SoundTbl_Death = {"bot/pain5.wav","bot/pain8.wav","bot/pain9.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:SetSurroundingBoundsType(BOUNDS_COLLISION)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
    local att = self:LookupAttachment("eyes")
    return att != 0 && self:GetAttachment(att).Ang:Forward() or self:GetForward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnGrenadeAttack(status, grenade, customEnt, landDir, landingPos)
	if status == "Throw" then
		return (landingPos - grenade:GetPos()) + (self:GetUp()*200 + self:GetForward()*500 + self:GetRight()*math.Rand(-20, 20))
	end
end