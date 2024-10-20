AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/predators/wolf.mdl"} -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 1500

ENT.ArmorColor = Vector(0.725,0.745,0.7)

ENT.AttackDamageMultiplier = 1.35
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit2()
	if GetConVar("vj_avp_bosstheme_p"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/Annihilation.mp3"}
	end
end