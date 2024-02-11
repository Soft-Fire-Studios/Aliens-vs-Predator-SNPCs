AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/predators/alien.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 700

ENT.AttackDamageMultiplier = 1.125
---------------------------------------------------------------------------------------------------------------------------------------------
-- function ENT:OnInit()
-- 	self.VJ_NPC_Class = {"CLASS_PREDATOR_TESTING"}
-- end