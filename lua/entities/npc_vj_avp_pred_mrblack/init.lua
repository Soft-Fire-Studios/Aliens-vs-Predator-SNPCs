AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/predators/mrblack.mdl"}
ENT.StartHealth = 3000
-------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	-- self.BaseClass.OnInit(self)
	self.VJ_NPC_Class = {"CLASS_YAUTJA_BERSERKER"}
end