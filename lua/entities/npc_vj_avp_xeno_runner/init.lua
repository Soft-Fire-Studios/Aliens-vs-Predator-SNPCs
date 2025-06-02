AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/runner.mdl"}
ENT.StartHealth = 60

ENT.CanStand = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	self.MainSoundPitch = VJ.SET(110, 115)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Gibs()
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ.Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(300)
	util.Effect("VJ_Blood1",bloodeffect)

	local function changeGib(gib)
		gib:SetColor(Color(255,111,0))
	end

	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	-- self:CreateGibEntity("obj_vj_gib",{"models/cpthazama/avp/xeno/gibs/larm.mdl"},nil,function(gib) changeGib(gib) end)
	-- self:CreateGibEntity("obj_vj_gib",{"models/cpthazama/avp/xeno/gibs/rarm.mdl"},nil,function(gib) changeGib(gib) end)
	-- self:CreateGibEntity("obj_vj_gib",{"models/cpthazama/avp/xeno/gibs/lleg.mdl"},nil,function(gib) changeGib(gib) end)
	-- self:CreateGibEntity("obj_vj_gib",{"models/cpthazama/avp/xeno/gibs/rleg.mdl"},nil,function(gib) changeGib(gib) end)
	-- self:CreateGibEntity("obj_vj_gib",{"models/cpthazama/avp/xeno/gibs/tail.mdl"},nil,function(gib) changeGib(gib) end)
end