AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/k_runner.mdl"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self.VJ_NPC_Class = {"CLASS_XENOMORPH_KSERIES"}
	self.GeneralSoundPitch1 = 110
	self.GeneralSoundPitch2 = 115
end