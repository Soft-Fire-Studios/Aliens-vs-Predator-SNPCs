AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/predators/predlord.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 2000

-- ENT.ArmorColor = Vector(3,3,3)

ENT.AttackDamageMultiplier = 1.2
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	if GetConVar("vj_avp_bosstheme_p"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/Annihilation.mp3"}
	end

	self.SoundTbl_Idle = {
		"cpthazama/avp/predator/vocals/predlord/predlord_hologram_short_01.ogg",
		"cpthazama/avp/predator/vocals/predlord/predlord_hologram_short_02.ogg",
		"cpthazama/avp/predator/vocals/predlord/predlord_hologram_short_03.ogg",
		"cpthazama/avp/predator/vocals/predlord/predlord_hologram_short_04.ogg",
		"cpthazama/avp/predator/vocals/predlord/predlord_hologram_short_05.ogg",
		"cpthazama/avp/predator/vocals/predlord/predlord_hologram_short_06.ogg",
		"cpthazama/avp/predator/vocals/predlord/predlord_hologram_short_07.ogg",
	}

	self.PlasmaVisible = true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
	local equip = self:GetEquipment()
	if equip == 1 && !self.PlasmaVisible then
		self.PlasmaVisible = true
		self:SetBodygroup(self:FindBodygroupByName("plasmacaster"),0)
	elseif equip != 1 && self.PlasmaVisible then
		self.PlasmaVisible = false
		self:SetBodygroup(self:FindBodygroupByName("plasmacaster"),1)
	end
end