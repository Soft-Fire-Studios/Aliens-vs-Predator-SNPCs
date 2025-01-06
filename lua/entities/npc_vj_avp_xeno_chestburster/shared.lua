ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Xenomorph Chestburster"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

ENT.VJ_AVP_NPC = true
ENT.VJ_AVP_Xenomorph = true
ENT.VJ_AVP_XenomorphChestburster = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Vision")
	self:NetworkVar("Int",0,"HP")
	self:NetworkVar("Vector",0,"QueenMarker")
end

if CLIENT then
	local string_EndsWith = string.EndsWith
	local string_Replace = string.Replace
	local file_Exists = file.Exists

	ENT.XenoMaterials = {
		["models/cpthazama/avp/xeno/chestburster/chestburster"] = "models/cpthazama/avp/xeno/chestburster/chestburster_xv",
		["models/cpthazama/avp/xeno/chestburster/chestburster_inner_mouth"] = "models/cpthazama/avp/xeno/chestburster/chestburster_inner_mouth_xv",
		["models/cpthazama/avp/xeno/chestburster/chestburster_predator"] = "models/cpthazama/avp/xeno/chestburster/chestburster_xv",
		["models/cpthazama/avp/xeno/chestburster/chestburster_inner_mouth_predator"] = "models/cpthazama/avp/xeno/chestburster/chestburster_inner_mouth_xv",

	}

	function ENT:Initialize()
		self.HasResetMaterials = true
		self.NextDarknessT = 0

		self.QueenMarkerPoints = {}
	end

	local render_GetLightColor = render.GetLightColor
	function ENT:Draw()
		self:DrawModel()
		local ply = LocalPlayer()
		if ply.VJ_IsControllingNPC && ply.VJCE_NPC.VJ_AVP_Predator && ply.VJCE_NPC.PreviousVisionMode == 2 then
		-- if ply:Health() == 100 then
			self.HasResetMaterials = false
			for i,v in pairs(self:GetMaterials()) do
				if self.XenoMaterials[v] then
					local xvMat = self.XenoMaterials[v]
					local mat = self:GetSubMaterial(i)
					if (mat == "" or mat != xvMat) then
						self:SetSubMaterial(i -1,xvMat)
					end
				end
			end
		else
			if !self.HasResetMaterials then
				self.HasResetMaterials = true
				self:SetSubMaterial()
			end
		end

		if VJ_AVP_CVAR_XENOSTEALTH then
			local light = render_GetLightColor(self:GetPos() +self:OBBCenter()):Length()
			if CurTime() > self.NextDarknessT && light <= 1 then
				net.Start("VJ_AVP_Xeno_Darkness")
					net.WriteEntity(self)
					net.WriteFloat(light,4)
				net.SendToServer()
				self.NextDarknessT = CurTime() +math.Rand(1,2)
			end
		end
	end

	local vec0 = Vector(0, 0, 0)
	local vec1 = Vector(1, 1, 1)
	function ENT:Controller_CalcView(ply, origin, angles, fov, camera, cameraMode)
		local pos = origin -- The position that will be set
		local ang = ply:EyeAngles()
		if cameraMode == 2 then -- First person
			local setPos = self:EyePos() + self:GetForward()*20
			local offset = ply.VJC_FP_Offset
			//camera:SetLocalPos(camera:GetLocalPos() + ply.VJC_TP_Offset) -- Help keep the camera stable
			if ply.VJC_FP_Bone != -1 then -- If the bone does exist, then use the bone position
				local bonePos, boneAng = self:GetBonePosition(ply.VJC_FP_Bone)
				setPos = bonePos
				if ply.VJC_FP_CameraBoneAng > 0 then
					ang[3] = boneAng[ply.VJC_FP_CameraBoneAng] + ply.VJC_FP_CameraBoneAng_Offset
				end
				if ply.VJC_FP_ShrinkBone then
					self:ManipulateBoneScale(ply.VJC_FP_Bone, vec0) -- Bone manipulate to make it easier to see
					-- for _,v in pairs(self:GetChildBones(ply.VJC_FP_Bone)) do
					-- 	self:ManipulateBoneScale(v, vec0)
					-- end
				end
			end
			pos = setPos + (self:GetForward()*offset.x + self:GetRight()*offset.y + self:GetUp()*offset.z)
			fov = 140
		else -- Third person
			if ply.VJC_FP_Bone != -1 then -- Reset the NPC's bone manipulation!
				self:ManipulateBoneScale(ply.VJC_FP_Bone, vec1)
				-- for _,v in pairs(self:GetChildBones(ply.VJC_FP_Bone)) do
				-- 	self:ManipulateBoneScale(v, vec1)
				-- end
			end
			local offset = ply.VJC_TP_Offset + Vector(0, 0, self:OBBMaxs().z - self:OBBMins().z) // + vectp
			//camera:SetLocalPos(camera:GetLocalPos() + ply.VJC_TP_Offset) -- Help keep the camera stable
			local tr = util.TraceHull({
				start = self:GetPos() + self:OBBCenter(),
				endpos = self:GetPos() + self:OBBCenter() + angles:Forward()*-camera.Zoom + (self:GetForward()*offset.x + self:GetRight()*offset.y + self:GetUp()*offset.z),
				filter = {ply, camera, self},
				mins = Vector(-5, -5, -5),
				maxs = Vector(5, 5, 5),
				mask = MASK_SHOT,
			})
			pos = tr.HitPos + tr.HitNormal*2
			fov = 75
		end
		return {origin = pos, angles = ang, fov = fov}
	end

	function ENT:OnRemove()
		if IsValid(self.QueenMarkerFX) then
			self.QueenMarkerFX:StopEmission(false,true)
			self.QueenMarkerFX = nil
		end
		for _,v in pairs(self.QueenMarkerPoints) do
			if IsValid(v) then
				v:StopEmission(false,true)
				v = nil
			end
		end
	end
end