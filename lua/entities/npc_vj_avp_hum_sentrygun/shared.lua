ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

ENT.VJTag_ID_Turret = true
ENT.VJ_AVP_IsTech = true
ENT.EntityClass = AVP_ENTITYCLASS_SENTRYGUN

if CLIENT then
	local matLaser = Material("sprites/avp/turret_laser_fade")
	local laserColor = Color(0,161,255,50)
	--
    -- function ENT:Initialize()
	-- 	local attStart = self:LookupAttachment("scan")
    --     hook.Add("PreDrawEffects",self,function(self)
    --         local att = self:GetAttachment(attStart)
    --         local startPos = att.Pos
    --         local endPos = att.Ang:Forward() *400
    --         for i = 1,2 do
    --             render.SetMaterial(matLaser)
    --             render.DrawBeam(startPos, startPos +endPos +self:GetUp() *(i == 1 && 100 or -100), 2, 0, 0.98, laserColor)
    --             -- local tr = util.TraceLine({
    --             --     start = startPos,
    --             --     endpos = startPos +endPos +self:GetUp() *(i == 1 && 100 or -100),
    --             --     filter = self,
    --             --     mask = MASK_SHOT
    --             -- })
    --             -- render.DrawBeam(startPos, tr.HitPos, 2, 0, 0.98, laserColor)
    --         end
    --     end)
    -- end
end