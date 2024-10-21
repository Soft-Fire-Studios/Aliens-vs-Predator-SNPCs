AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/jungle.mdl"}
ENT.StartHealth = 60

ENT.CanSpit = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self.SoundTbl_Alert = {
		"cpthazama/avp/xeno/jungle alien/junglealien_hiss_long1.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_hiss_long2.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_hiss_long3.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_hiss_long4.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_hiss_short1.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_hiss_short2.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_hiss_short3.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_spotted1.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_spotted2.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_spotted3.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_spotted4.ogg",
	}
	self.SoundTbl_CombatIdle = {
		"cpthazama/avp/xeno/jungle alien/junglealien_scream_long1.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_scream_long2.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_scream_long3.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_taunt1.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_taunt2.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_taunt3.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_taunt4.ogg",
	}
	self.SoundTbl_Pain = {
		"cpthazama/avp/xeno/jungle alien/junglealien_injured1.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_injured2.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_injured3.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_injured4.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_injured5.ogg",
	}
	self.SoundTbl_Death = {
		"cpthazama/avp/xeno/jungle alien/junglealien_death1.ogg",
		"cpthazama/avp/xeno/jungle alien/junglealien_death2.ogg",
	}
end