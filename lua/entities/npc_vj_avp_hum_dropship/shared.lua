ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

if CLIENT then
	local viewLerpFOV = 75
    local vec0 = Vector(0,0,0)
    local vec1 = Vector(0,0,0)
    function ENT:Controller_OnCalcView(cont, ply, pos, angles, fov)
        local camera = cont:GetCamera()
        local cameraMode = cont:GetCameraMode()
        if cameraMode != 1 then
            local pos,ang = self:GetBonePosition(self:LookupBone("DropShip_Body"))
            pos = pos +ang:Up() *450
            -- pos = pos +ang:Forward() *230 +self:GetUp() *10
            return {origin = pos, ang = angles, fov = fov}
        end
        local offset = vec1
        local zoom = cont.VJC_Camera_Zoom *2
		local mainAtt = self:LookupBone("DropShip_Body")
		local viewPos = mainAtt != nil && self:GetBonePosition(mainAtt) +self:OBBCenter() *-10 or (self:GetPos() +self:OBBCenter())
		viewPos = viewPos +self:GetVelocity() /20
		local endPosition = viewPos +angles:Forward() *(-zoom -300) +angles:Up() *(150) +angles:Right() *offset.y
		local tr = util.TraceHull({
			start = viewPos,
			endpos = endPosition,
			filter = {ply, camera, self},
			mins = Vector(-5, -5, -5),
			maxs = Vector(5, 5, 5),
			mask = MASK_SOLID_BRUSHONLY,
		})
		pos = tr.HitPos + tr.HitNormal *2
		ply:SetEyeAngles(angles)
		viewLerpFOV = Lerp(FrameTime() *ply:GetInfoNum("vj_npc_cont_cam_speed", 6),viewLerpFOV,fov)
		return {origin = pos, ang = angles, fov = viewLerpFOV}
	end
end