AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Gender = 1
ENT.VO = 1

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY","CLASS_WEYLAND_YUTANI"}
ENT.FriendsWithAllPlayerAllies = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/archa.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ColonistInitialize()

end