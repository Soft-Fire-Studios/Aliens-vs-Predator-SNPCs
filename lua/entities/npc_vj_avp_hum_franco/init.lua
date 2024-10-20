AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Gender = 1
ENT.VO = 2

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
ENT.FriendsWithAllPlayerAllies = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit2()
	local vest = math.random(1,4) == 1 && 1 or 0
	self:SetBodygroup(self:FindBodygroupByName("vest"),vest)
	if vest == 0 then
		self:SetBodygroup(self:FindBodygroupByName("decal_vest"),math.random(1,4) == 1 && 1 or 0)
	end
	self:SetBodygroup(self:FindBodygroupByName("decal_lleg"),math.random(1,4) == 1 && 1 or 0)
	self:SetBodygroup(self:FindBodygroupByName("decal_rleg"),math.random(1,4) == 1 && 1 or 0)
	self:SetBodygroup(self:FindBodygroupByName("helmet"),math.random(1,4) == 1 && 1 or 0)
end