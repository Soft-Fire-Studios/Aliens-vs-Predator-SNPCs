AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/queen_hag.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 8000
ENT.HullType = HULL_LARGE

ENT.SoundTbl_FootStep = {
	"cpthazama/avp/xeno/queen/alien_queen_footstep_01.wav",
	"cpthazama/avp/xeno/queen/alien_queen_footstep_02.wav",
	"cpthazama/avp/xeno/queen/alien_queen_footstep_03.wav",
}

ENT.AnimationBehaviors = {}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self.CurrentSet = 2
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity()
	return ACT_WALK
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity()
	return ACT_IDLE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectTurnActivity(inAct)
	return inAct
end