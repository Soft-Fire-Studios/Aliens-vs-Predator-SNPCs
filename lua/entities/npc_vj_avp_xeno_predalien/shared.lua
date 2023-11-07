ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

ENT.VJ_AVP_Xenomorph = true
ENT.VJ_AVP_XenomorphLarge = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity",0,"EnemyCS")
end

if CLIENT then
	function ENT:Think()
		local enemy = self:GetEnemyCS()
		local p_enemy = 0
		local y_enemy = 0
		local r_enemy = 0
		if IsValid(enemy) then
			local enemy_pos = enemy:GetPos() +enemy:OBBCenter()
			local self_ang = self:GetAngles()
			local enemy_ang = (enemy_pos -(self:GetPos() +self:OBBCenter())):Angle()
			p_enemy = -math.AngleDifference(enemy_ang.p,self_ang.p)
			y_enemy = -math.AngleDifference(enemy_ang.y,self_ang.y)
			r_enemy = -math.AngleDifference(enemy_ang.z,self_ang.z)
		end

		local ang_app = math.ApproachAngle
		local speed = 5
		local bones = {
			[1] = {ID = 7, p = 25, y = 60, r = 15},
			[2] = {ID = 3, p = 35, y = 60, r = 5},
		}
		for i = 1,#bones do
			local get = self:GetManipulateBoneAngles(bones[i].ID)
			local p = ang_app(get[1],p_enemy,speed)
			local y = ang_app(get[2],y_enemy,speed)
			local r = ang_app(get[3],r_enemy,speed)
			self:ManipulateBoneAngles(bones[i].ID,Angle(math.Clamp(p,-(bones[i].p),bones[i].p),math.Clamp(r,-(bones[i].r),bones[i].r),math.Clamp(-y,-(bones[i].y),bones[i].y)))
		end
	end
end