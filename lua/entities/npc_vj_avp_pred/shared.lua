ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

-- include("vj_base/extensions/avp_viewmodel_module.lua")

ENT.VJ_AVP_NPC = true
ENT.VJ_AVP_Creature = true
ENT.VJ_AVP_Predator = true

sound.Add({
	name = "AVP.Predator.NuclearExplosion",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
	sound = "cpthazama/avp/weapons/explosions/pred_detonated_01.ogg"
})

sound.Add({
	name = "AVP.Predator.NuclearExplosionFX",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
	sound = "cpthazama/avp/weapons/explosions/explosion_large_distant_fx_02.ogg"
})

function ENT:SetupDataTables()
	self:NetworkVar("Entity",0,"LockOn")
	self:NetworkVar("Entity",1,"VM")
	self:NetworkVar("Entity",2,"Spear")
	self:NetworkVar("Entity",3,"Disc")
	self:NetworkVar("Int",0,"VisionMode")
	self:NetworkVar("Int",1,"Equipment")
	self:NetworkVar("Int",2,"StimCount")
	self:NetworkVar("Int",3,"Energy")
	self:NetworkVar("Int",4,"HP")
	self:NetworkVar("Float",0,"EquipmentShowTime")
	self:NetworkVar("Float",1,"CloakDisruptTime")
	self:NetworkVar("Bool",0,"Cloaked")
	self:NetworkVar("Bool",1,"Sprinting")
	self:NetworkVar("Bool",2,"Beam")
	self:NetworkVar("Bool",3,"InFatality")
	self:NetworkVar("Vector",0,"JumpPosition")
	self:NetworkVar("Vector",1,"ArmorColor")
end

hook.Add("PlayerButtonDown","VJ_AVP_Predator_Buttons",function(ply,button)
	if ply.VJTag_IsControllingNPC == true && IsValid(ply.VJ_TheControllerEntity) then
		local cent = ply.VJ_TheControllerEntity
		local npc = cent.VJCE_NPC
		if npc.VJ_AVP_NPC then
			ply:AllowFlashlight(false)
		end

		if button == KEY_F then
			if npc.VJ_AVP_Predator && (npc.PredLord && 1 or npc:GetBodygroup(npc:FindBodygroupByName("mask")) == 1) then
				local mode = npc:GetVisionMode()
				local movie = GetConVar("vj_avp_moviepred"):GetBool()
				if mode == 0 then
					ply:EmitSound(movie && "cpthazama/avp/predator/vision/Vision_Start_Movie.ogg" or "cpthazama/avp/predator/vision/prd_vision_mode_start_mono.ogg",65)
				elseif mode == 3 then
					ply:EmitSound(movie && "cpthazama/avp/predator/vision/Vision_End_Movie.ogg" or "cpthazama/avp/predator/vision/prd_vision_mode_end.ogg",65)
				else
					ply:EmitSound(movie && "cpthazama/avp/predator/vision/Vision_Switch_Movie.ogg" or VJ.PICK({
						"cpthazama/avp/predator/vision/vision_change_01.ogg",
						"cpthazama/avp/predator/vision/vision_change_02.ogg",
						"cpthazama/avp/predator/vision/vision_change_04.ogg",
						"cpthazama/avp/predator/vision/vision_change_05.ogg",
					}),65)
					-- ply:EmitSound("cpthazama/avp/predator/Vision_Change.ogg",65)
				end
				npc:SetVisionMode(mode +1 > 3 && 0 or mode +1)
				-- local snd = CreateSound(ply,"cpthazama/avp/predator/vision_change_01.wav")
				-- snd:SetSoundLevel(0)
				-- snd:Play()
				-- snd:ChangeVolume(70)
			elseif npc.VJ_AVP_Xenomorph then
				npc:SetVision(!npc:GetVision())
				ply:EmitSound("cpthazama/avp/weapons/alien/alien_vision.wav",0)
				ply:ScreenFade(SCREENFADE.IN,Color(255,255,255),0.35,0.1)
			end
		end
		
		local fov = ply:GetFOV()
		-- if button == KEY_H then
		-- 	if cent.VJC_Camera_Mode == 1 && fov != GetConVarNumber("fov_desired") then
		-- 		ply:SetFOV(GetConVarNumber("fov_desired"),0.1)
		-- 		ply:EmitSound("cpthazama/avp/predator/prd_vision_mode_zoom_out.wav",65)
		-- 	end
		-- end
		if cent.VJC_Camera_Mode == 2 && npc.VJ_AVP_Predator then
			if npc:GetBodygroup(npc:FindBodygroupByName("mask")) == 1 then
				if button == KEY_MOUSESCROLL_UP then
					ply:SetFOV(fov <= 1 && GetConVarNumber("fov_desired") or math.Clamp(fov -20,1,180),0.25)
					ply:EmitSound("cpthazama/avp/predator/vision/prd_vision_mode_zoom.ogg",65)
					cent.VJC_Camera_CurZoom = Vector(0,0,0)
					ply.VJ_AVP_IsUsingZoom = true
				elseif button == KEY_MOUSESCROLL_DOWN then
					ply:SetFOV(GetConVarNumber("fov_desired"),0.1)
					ply:EmitSound("cpthazama/avp/predator/vision/prd_vision_mode_zoom_out.ogg",65)
					cent.VJC_Camera_CurZoom = Vector(0,0,0)
					ply.VJ_AVP_IsUsingZoom = false
				end
			else
				if ply.VJ_AVP_IsUsingZoom == true then
					ply:SetFOV(GetConVarNumber("fov_desired"),0.1)
					cent.VJC_Camera_CurZoom = Vector(0,0,0)
					ply.VJ_AVP_IsUsingZoom = false
				end
			end
		end
	end
end)

if CLIENT then
	local string_lower = string.lower
	local string_find = string.find
	local scale0 = Vector(0,0,0)
	local scale1 = Vector(1,1,1)
	local matLaser = Material("sprites/avp/turret_laser_fade")
	local matLaserStart = Material("vj_base/effects/muzzlestarlarge_01")
	local laserColor = Color(255,0,0,135)
	local matNil = Material(" ")
	-- local matGradientThermal = Material("hud/cpthazama/avp/heatmap.png")
	local matGradientThermal = Material("hud/cpthazama/avp/thermal_gradient.png")
	local matGradientThermal2 = Material("hud/cpthazama/avp/thermal_gradient_cold_b.png")
	local matGradientXeno = Material("hud/cpthazama/avp/grey_gradient.png")
	local matGradientTech = Material("hud/cpthazama/avp/tech_gradient.png")
	local matGradientNoMask = Material("hud/cpthazama/avp/tech_world_gradient_darker.png")
    function ENT:Initialize()
		self.Mat_cloakfactor = 0
		self.CL_PreviousVisionMode = 0

		-- hook.Add("PreDrawOpaqueRenderables",self,function(self)
		-- 	local ply = LocalPlayer()
		-- 	if IsValid(ply) && ply.VJCE_NPC == self && ply.VJC_Camera_Mode == 2 then
		-- 		local vm = ply:GetViewModel()
		-- 		if IsValid(vm) then
		-- 			cam.Start3D(EyePos(),EyeAngles())
		-- 				render.ClearStencil()
		-- 				render.SetStencilEnable(true) 
		-- 				render.SetStencilWriteMask(255)
		-- 				render.SetStencilTestMask(255)
		-- 				render.SetStencilReferenceValue(1)
		-- 				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
		-- 				render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		-- 				render.SetStencilFailOperation(STENCILOPERATION_KEEP)
		-- 				render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
		-- 				vm:DrawModel()
		-- 				render.SuppressEngineLighting(true)
		-- 				if self:GetCloaked() then
		-- 					render.MaterialOverride(matTT_Thermal)
		-- 				end
		-- 				render.SetColorModulation(1.65,1.65,1.65)
		-- 				render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		-- 				render.SetStencilPassOperation(STENCILOPERATION_KEEP)
		-- 				vm:DrawModel()
		-- 				render.SetColorModulation(1,1,1)
		-- 				render.MaterialOverride(0)
		-- 				render.SuppressEngineLighting(false)
		-- 				render.SetStencilEnable(false)
		-- 			cam.End3D()
		-- 		end
		-- 	end
		-- end)

		-- local attStart = self:LookupAttachment("laser")
        -- hook.Add("PreDrawEffects",self,function(self)
		-- 	if !self:GetBeam() then return end
        --     local att = self:GetAttachment(attStart)
        --     local startPos = att.Pos
        --     local endPos = att.Ang:Forward() *2000
		-- 	local ent = false
		-- 	if IsValid(self:GetLockOn()) then
		-- 		endPos = self:GetLockOn():EyePos()
		-- 		ent = true
		-- 	end
        --     render.SetMaterial(matLaserStart)
        --     render.DrawSprite(startPos,5,5,laserColor)
        --     for i = 1,3 do
		-- 		startPos = startPos +att.Ang:Right() *(i == 1 && -0.1 or i == 2 && 0.3 or 0) +att.Ang:Up() *(i == 3 && 0.3 or 0)
        --         local tr = util.TraceLine({
        --             start = startPos,
        --             endpos = ent && endPos or startPos +endPos,
        --             filter = self,
        --             mask = MASK_SHOT
        --         })
        --         render.SetMaterial(matLaser)
        --         render.DrawBeam(startPos, tr.HitPos, 0.3, 0, 0.98, laserColor)
        --     end
        -- end)
	end

	local math_abs = math.abs
	local blueFX = Vector(0,0.4,6)
	local androidFX = Vector(2,2,2)
	local whiteFX = Vector(1,1,1)
    matproxy.Add({
        name = "AVP_ArmorTint",
        init = function(self,mat,values)
            self.Result = values.resultvar
        end,
		bind = function(self,mat,ent)
			-- print(mat,ent)
			if !IsValid(ent) then return end
			local vm = false
			if ent:GetClass() == "viewmodel" then
				ent = ent:GetOwner().VJCE_NPC
				vm = true
			end
			if !IsValid(ent) then return end
			local col = ent.GetArmorColor && ent:GetArmorColor() or ent:GetNW2Vector("AVP.ArmorTint",whiteFX)
			if col == nil then return end
			if vm then
				if col.x <= 0.7 or col.y <= 0.7 or col.z <= 0.7 then
					col = col *1.75
				else
					col = col *2.5
				end
			end
			mat:SetVector(self.Result,col)
		end
	})
    matproxy.Add({
        name = "AVP_Cloak",
        init = function(self,mat,values)
            self.Result = values.resultvar
			self.CloakColorTint = mat:GetVector("$cloakcolortint") or whiteFX
        end,
        bind = function(self,mat,ent)
            if (!IsValid(ent)) then return end
			local ply = LocalPlayer()

			local parent = ent:GetParent()
			local checkEnt = IsValid(parent) && parent or ent
			-- if checkEnt:GetClass() == "viewmodel" then
				-- checkEnt = checkEnt:GetOwner()
			-- end
			ent.Mat_cloakfactor = ent.Mat_cloakfactor or (IsValid(parent) && parent.Mat_cloakfactor or 0)
			local curValue = ent.Mat_cloakfactor
			local finalResult = curValue or 0
			local disruptTime = ent.VJ_AVP_Predator && checkEnt:GetCloakDisruptTime() or 0
			if checkEnt.GetCloaked then
				if checkEnt:GetCloaked() then
					if disruptTime > CurTime() then
						local remaining = disruptTime -CurTime()
						finalResult = 0.97 +math.sin(CurTime() *2) *0.03
					else
						finalResult = checkEnt:IsNPC() && (checkEnt:GetSprinting() or (checkEnt.GetJumpPosition && checkEnt:GetJumpPosition() != scale0)) && 0.97 or 0.997
					end
				else
					finalResult = 0
					finalResultRefract = 0
				end
			end
			-- print(finalResult,checkEnt)
			ent.Mat_cloakfactor = Lerp(FrameTime() *0.3,curValue,finalResult)
			self.CloakColorTint = LerpVector(FrameTime() *0.3,self.CloakColorTint,math_abs(curValue -finalResult) > 0.1 && blueFX or whiteFX)
			if IsValid(ply.VJCE_NPC) && ply.VJCE_NPC.VJ_AVP_Predator && ent:GetClass() == "viewmodel" && ent:GetOwner() == ply then
				ent.Mat_cloakfactor = ply.VJCE_NPC.Mat_cloakfactor
				ent.CloakColorTint = ply.VJCE_NPC.CloakColorTint
			end
			mat:SetVector("$cloakcolortint",self.CloakColorTint)
			mat:SetFloat(self.Result,ent.Mat_cloakfactor)

			-- print(ent,ent.Mat_cloakfactor,self.CloakColorTint)
        end
    })

	local faceBones = {
		"Bip01 mouth_bottom_left",
		"Bip01 mouth_bottom_left02",
		"Bip01 mouth_bottom_right",
		"Bip01 mouth_bottom_right02",
		"Bip01 mouth_top_left",
		"Bip01 mouth_top_left02",
		"Bip01 mouth_top_right",
		"Bip01 mouth_top_right02"
	}
	local math_angDif = math.AngleDifference
	function ENT:Draw()
		local ply = LocalPlayer()
		local checkEnt = self
		if IsValid(ply) && ply.VJCE_NPC == self && ply.VJC_Camera_Mode == 2 then
			checkEnt = ply:GetViewModel()

			local vm = ply:GetViewModel()
			if IsValid(vm) then
				vm:SetSkin(self.VJ_AVP_Predator_IsDark && 1 or 0)
				if self:GetVisionMode() == 1 then
					vm:SetBodygroup(1,self:GetCloaked() && 2 or 1)
					-- vm:SetNoDraw(true)
					-- vm:SetMaterial(self:GetCloaked() && "hud/cpthazama/avp/tt_thermal" or "hud/cpthazama/avp/tt_thermal_overlay")
					-- cam.Start3D(EyePos(),EyeAngles(),94)
					-- 	render.ClearStencil()
					-- 	render.SetStencilEnable(true)
					-- 	render.SetStencilWriteMask(255)
					-- 	render.SetStencilTestMask(255)
					-- 	render.SetStencilReferenceValue(1)
					-- 	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
					-- 	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
					-- 	render.SetStencilFailOperation(STENCILOPERATION_KEEP)
					-- 	render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
					-- 	vm:DrawModel()
					-- 	render.SuppressEngineLighting(true)
					-- 	render.SetColorModulation(1.65,1.65,1.65)
					-- 	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
					-- 	render.SetStencilPassOperation(STENCILOPERATION_KEEP)
					-- 	vm:DrawModel()
					-- 	DrawBloom(0,1,1,1,1,2,1,0.8,0.8)
					-- 	DrawTexturize(0,matGradientThermal)
					-- 	render.SetColorModulation(1,1,1)
					-- 	render.MaterialOverride(0)
					-- 	render.SuppressEngineLighting(false)
					-- 	render.SetStencilEnable(false)
					-- cam.End3D()
				else
					vm:SetBodygroup(1,0)
					-- vm:SetNoDraw(false)
					-- vm:SetMaterial("")
				end

				if self:GetEquipment() == 5 then
					if vm:GetBodygroup(2) != 1 then
						vm:SetBodygroup(2,5)
					end
				else
					if vm:GetBodygroup(2) == 5 then
						vm:SetBodygroup(2,0)
					end
				end

				for _,v in pairs(self:GetChildren()) do
					v:SetNoDraw(true)
				end
			end
		else
			for _,v in pairs(self:GetChildren()) do
				v:SetNoDraw(false)
			end
		end

		if checkEnt == self then
			self:DrawModel()
		end

		local mode = self:GetVisionMode()
		if mode != self.CL_PreviousVisionMode then
			self.CL_PreviousVisionMode = mode
			if IsValid(ply) && ply.VJCE_NPC == self && ply.VJC_Camera_Mode == 2 then return end
			self.EyeGlowFX = self.EyeGlowFX or {}
			for _,v in pairs(self.EyeGlowFX) do
				if IsValid(v) then
					v:StopEmission(false,true)
				end
			end
			for i = 1,2 do
				local attID = self:LookupAttachment(i == 1 && "leye" or "reye")
				self.EyeGlowFX[i] = CreateParticleSystem(self,"vj_avp_predator_eyes",PATTACH_POINT_FOLLOW,attID)
			end
		end
		
		local attStart = checkEnt:LookupAttachment("laser")
		if self:GetBeam() then
			local att = checkEnt:GetAttachment(attStart)
			local startPos = att.Pos
			local endPos = att.Ang:Forward() *2000
			local ent = false
			local lockOn = self:GetLockOn()
			if IsValid(lockOn) then
				ent = true
				endPos = lockOn:EyePos() -(lockOn:OBBCenter() /2)
				local angDif = math_angDif((lockOn:GetPos() -self:GetPos()):Angle().y, self:GetAngles().y)
				if math_abs(angDif) > 80 then
					endPos = startPos +att.Ang:Forward() *2000
					endPos.z = lockOn:GetPos().z
				end
			end
			render.SetMaterial(matLaserStart)
			render.DrawSprite(startPos,5,5,laserColor)
			for i = 1,3 do
				startPos = startPos +att.Ang:Right() *(i == 1 && -0.1 or i == 2 && 0.3 or 0) +att.Ang:Up() *(i == 3 && 0.3 or 0)
				local tr = util.TraceLine({
					start = startPos,
					endpos = ent && endPos or startPos +endPos,
					filter = self,
					mask = MASK_SHOT
				})
				render.SetMaterial(matLaser)
				render.DrawBeam(startPos, tr.HitPos, 0.3, 0, 0.98, laserColor)
			end
		end
	end

	function ENT:OnRemove()
		if IsValid(self.LandingParticle) then
			self.LandingParticle:StopEmission(false,true)
			self.LandingParticle = nil
		end
		local vm = self.VM
		if IsValid(vm) then
			vm:Remove()
		end
		self.EyeGlowFX = self.EyeGlowFX or {}
		for _,v in pairs(self.EyeGlowFX) do
			if IsValid(v) then
				v:StopEmission(false,true)
			end
		end
	end

	local vec0 = Vector(0, 0, 0)
	local vec1 = Vector(1, 1, 1)
	local debugT = 0
	function ENT:Controller_CalcView(ply, origin, angles, myFOV, camera, cameraMode)
		local pos = origin -- The position that will be set
		local ang = ply:EyeAngles()
		local newFOV = myFOV
		local refreshRate = nil
		self.VJC_FP_Bone = ply.VJC_FP_Bone
		if cameraMode == 2 then -- First person
			local setPos = self:EyePos() + self:GetForward()*20
			local offset = ply.VJC_FP_Offset
			//camera:SetLocalPos(camera:GetLocalPos() + ply.VJC_TP_Offset) -- Help keep the camera stable
			if ply.VJC_FP_Bone != -1 then -- If the bone does exist, then use the bone position
				local bonePos, boneAng = self:GetBonePosition(ply.VJC_FP_Bone)
				setPos = bonePos
				-- if ply.VJC_FP_CameraBoneAng > 0 then
				-- 	ang[3] = boneAng[ply.VJC_FP_CameraBoneAng] + ply.VJC_FP_CameraBoneAng_Offset
				-- end
				if ply.VJC_FP_ShrinkBone then
					-- self:ManipulateBoneScale(ply.VJC_FP_Bone, vec0) -- Bone manipulate to make it easier to see
					-- for _,v in pairs(self:GetChildBones(ply.VJC_FP_Bone)) do
					-- 	self:ManipulateBoneScale(v, vec0)
					-- end
				end
				-- local addAng = boneAng.r
				-- if addAng > 180 then
				-- 	addAng = addAng -360
				-- end
				-- addAng = addAng *0.1
				-- ang.r = Lerp(FrameTime() *2,ang.r,ang.r +addAng)
				-- if CurTime() > debugT then
				-- 	ply:ChatPrint(math.Round(ang.r,2))
				-- 	debugT = CurTime() +1
				-- end
			end
			local vm = ply:GetViewModel()
			local att = vm:LookupAttachment("pov")
			pos = setPos +(self:GetForward() *offset.x +self:GetRight() *offset.y +self:GetUp() *offset.z)
			-- if string_find(self:GetSequenceName(self:GetSequence()),"_jump_") then -- Simulate view punch by lerp the ang
			-- 	ang = LerpAngle(FrameTime() *5,ang,ang +Angle(-40,0,0))
			-- 	ply:ChatPrint("AA")
			-- end

			-- if att > 0 then
				-- local attDat = vm:GetAttachment(att)
				-- if attDat then
					-- local attAng = attDat.Ang
					-- if CurTime() > debugT then
					-- 	ply:ChatPrint("Yaw = "..math.Round(attAng.y,2).." Pitch = "..math.Round(attAng.p,2).." Roll = "..math.Round(attAng.r,2))
					-- 	debugT = CurTime() +1
					-- end
					-- ang.p = ang.p +attAng.p
					-- ang.r = ang.r +attAng.r
				-- 	local diff = attDat.Pos -pos
				-- 	pos = pos +diff
				-- end
			-- end
			newFOV = 90
			refreshRate = 0
		else
			if ply.VJC_FP_Bone != -1 then
				self:ManipulateBoneScale(ply.VJC_FP_Bone, vec1)
				for _,v in pairs(self:GetChildBones(ply.VJC_FP_Bone)) do
					self:ManipulateBoneScale(v, vec1)
				end
			end
			local offset = ply.VJC_TP_Offset + Vector(0, 0, 95) // + vectp
			local tr = util.TraceHull({
				start = self:GetPos() + self:OBBCenter(),
				endpos = self:GetPos() + self:OBBCenter() + angles:Forward()*-camera.Zoom + (self:GetForward()*offset.x + self:GetRight()*offset.y + self:GetUp()*offset.z),
				filter = {ply, camera, self},
				mins = Vector(-5, -5, -5),
				maxs = Vector(5, 5, 5),
				mask = MASK_SHOT,
			})
			pos = tr.HitPos + tr.HitNormal*2
			newFOV = 75
		end
		if self:GetSprinting() or self:GetJumpPosition() != vec0 then
			newFOV = newFOV +20
		end
		newFOV = Lerp(FrameTime() *5,self.LastFOV or myFOV,newFOV)
		if ply:GetFOV() != GetConVarNumber("fov_desired") then
			newFOV = nil
		end
		self.LastFOV = newFOV
		self.VJ_AVP_ViewModelData = {origin = pos, angles = ang, fov = newFOV}
		return {origin = pos, angles = ang, fov = newFOV, speed = refreshRate}
	end

	local function GetLandingPosition(self,ply)
		local aimVec = IsValid(ply) && ply:GetAimVector()
		local tr1 = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +(IsValid(ply) && aimVec *2000 or self:GetForward() *800),
			filter = {self,ply},
			mask = MASK_SOLID_BRUSHONLY
		})
		local firstHit = tr1.HitPos
		local upCheck1 = util.TraceLine({
			start = firstHit,
			endpos = firstHit +self:GetUp() *600,
			filter = {self,ply},
			mask = MASK_SOLID_BRUSHONLY
		})
		local trSt
		if upCheck1 then
			local pos = upCheck1.HitPos +(upCheck1.HitPos -self:GetPos()):GetNormalized() *64
			trSt = util.TraceLine({
				start = pos,
				endpos = pos +self:GetUp() *-2000,
				filter = {self,ply},
				mask = MASK_SOLID_BRUSHONLY
			})
		else
			trSt = util.TraceLine({
				start = firstHit,
				endpos = firstHit +self:GetUp() *-2000,
				filter = {self,ply},
				mask = MASK_SOLID_BRUSHONLY
			})
		end
		local startPos = trSt.HitPos +trSt.HitNormal *4
		return trSt.HitPos
	end

	local matTT_Thermal = Material("hud/cpthazama/avp/tt_thermal")
	local matTT_Thermal_Overlay = Material("hud/cpthazama/avp/tt_thermal_overlay")
	local matXenoOverlay = Material("models/cpthazama/avp/xenovision")
	local matColdOverlay = Material("hud/cpthazama/avp/tt_tech_overlay")
	local matColdOverlay_Cloaked = Material("hud/cpthazama/avp/tt_tech_overlay_cloaked")
	local matHUD = Material("hud/cpthazama/avp/predator_hud.png","smooth additive")
	local matHUD_Cloaked = Material("hud/cpthazama/avp/predator_cloak_hud.png","smooth additive")
	local matHUDZoom = Material("hud/cpthazama/avp/predator_zoom.png","smooth additive")
	local matHUDTarget = Material("hud/cpthazama/avp/predator_target.png","smooth additive")
	local matHUDEquip_Spear = Material("hud/cpthazama/avp/avp_p_wps_realspear_highlight_v2.png","smooth additive")
	local matHUDEquip_Disc = Material("hud/cpthazama/avp/avp_p_wps_disc_highlight_v2.png","smooth additive")
	local matHUDEquip_Mine = Material("hud/cpthazama/avp/avp_p_wps_mine_highlight_v3.png","smooth additive")
	local matHUDCrosshair_Plasma = Material("hud/cpthazama/avp/avp_p_reticle_plasma.png","smooth additive")
	local matHUDCrosshair_Other = Material("hud/cpthazama/avp/avp_p_reticle_other.png","smooth additive")
	local matHUDCrosshair_Spear = Material("hud/cpthazama/avp/avp_p_reticle_spear.png","smooth additive")
	local matHUDEquipSelect_Base = Material("hud/cpthazama/avp/pred_wepicon.png","smooth additive")
	local matHUDEquipSelect_Plasma = Material("hud/cpthazama/avp/avp_p_hud_wpnicon_plasma.png","smooth additive")
	local matHUDEquipSelect_Mine = Material("hud/cpthazama/avp/avp_p_hud_wpnicon_mine.png","smooth additive")
	local matHUDEquipSelect_Disc = Material("hud/cpthazama/avp/avp_p_hud_wpnicon_disc.png","smooth additive")
	local matHUDEquipSelect_Spear = Material("hud/cpthazama/avp/avp_p_hud_wpnicon_spear.png","smooth additive")
	local matHUDEquipSelect_Speargun = Material("hud/cpthazama/avp/avp_p_hud_wpnicon_speargun.png","smooth additive")
	local matHUD_HP = Material("hud/cpthazama/avp/pred_hp.png","smooth additive")
	local matHUD_HP_Warning = Material("hud/cpthazama/avp/pred_hp_warning.png","smooth additive")
	local matHUD_HP_Base = Material("hud/cpthazama/avp/pred_hp_bar.png","smooth additive")
	local matHUD_EP = Material("hud/cpthazama/avp/pred_energy.png","smooth additive")
	local matHUD_Item_HP = Material("hud/cpthazama/avp/predhealthicon.png","smooth additive")
	local matHUDCloak_Solid = Material("hud/cpthazama/avp/predmask_solid.png","smooth additive")
	local matHUDCloak_Outline = Material("hud/cpthazama/avp/predmask_outline.png","smooth additive")

	local matHUD_Blood = {
		Material("hud/cpthazama/avp/blood/green_1.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/green_2.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/green_3.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/green_4.png","smooth additive")
	}

	local acceptableClasses = {viewmodel=true}

	// Credits to Dopey and/or Umbree for the below functions; I suck doo-doo at HUD scaling/UV stuff so I nabbed this. Full credits will be given on release
	local function ScreenPos(x,y)
		local w = ScrW()
		local h = ScrH()
		local pos = {}
		pos.x = w *0.5 +w *x *0.01
		pos.y = h *0.5 +w *y *0.01

		return pos
	end

	local function ScreenScale(x,y)
		local w = ScrW()
		local h = ScrH()
		local size = {}
		size.x = (w *x *0.01)
		size.y = (w *y *0.01)

		return size
	end

	local function DrawIcon(mat,x,y,width,height,r,g,b,a,ang)
		surface.SetDrawColor(Color(r or 255,g or 255,b or 255,a or 255))
		surface.SetMaterial(mat)
		local pos = ScreenPos(x,y)
		local size = ScreenScale(width,height)
		surface.DrawTexturedRectRotated(pos.x,pos.y,size.x,size.y,ang or 0)
	end

	local function DrawIcon_UV(mat,x,y,width,height,uv,r,g,b,a)
		local uv = uv or {0,0,1,1}
		surface.SetDrawColor(Color(r or 255,g or 255,b or 255,a or 255))
		surface.SetMaterial(mat)
		local pos = ScreenPos(x,y)
		local size = ScreenScale(width,height)
		surface.DrawTexturedRectUV(pos.x,pos.y,size.x,size.y,uv[1],uv[2],uv[3],uv[4])
	end

	local stimsA = {255,255,255,255,255}
	local energysA = {255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255}
	local cloakA = 0

	local debugEquipT = CurTime() +1.5
	local equipPoints = {
		{x=0,y=-10}, // Plasma
		{x=-9,y=-2}, // Mine
		{x=9,y=-2}, // Disc
		{x=-6,y=8}, // Spear
		{x=6,y=8}, // Spear-Gun
	}

	local matSurf = {
		alienflesh=true,
		antlion=true,
		antlion_eggshell=true,
		armorflesh=true,
		bloodyflesh=true,
		flesh=true,
		zombieflesh=true,
	}
	
	local render_GetLightColor = render.GetLightColor
	local math_Clamp = math.Clamp
	net.Receive("VJ_AVP_Predator_Client",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()
		local cont = net.ReadEntity()
		local ply = cont
		
		ent.PreviousVisionMode = 0

		if delete == true then
			cont:AllowFlashlight(true)
			if cont.VisionHeart then cont.VisionHeart:Stop() end
			if cont.VisionBuzz then cont.VisionBuzz:Stop() end
			if cont.VisionIdle then cont.VisionIdle:Stop() end
			hook.Remove("PlayerButtonDown","VJ_AVP_Predator_Buttons")
			if ply.VJC_FP_Bone != -1 && IsValid(ent) then
				ent:ManipulateBoneScale(ply.VJC_FP_Bone, vec1)
				local child = ent:GetChildBones(ply.VJC_FP_Bone)
				if child then
					for _,v in pairs(child) do
						ent:ManipulateBoneScale(v, vec1)
					end
				end
			end
		else
			ent.VJ_TheControllerEntity = cont
			ent.VJ_TheController = ply
		end

		local index = ent:EntIndex()

		hook.Add("HUDPaint","VJ_AVP_Predator_HUD",function()
			if !IsValid(ent) then return end
			local r = 255
			local g = 0
			local b = 0
			local a = 250
			local hpColor = Color(r,g,b)
			local energyColor = Color(197,220,230)

			local mode = ent:GetVisionMode()
			if mode == 0 then -- No Mask
				-- a = 250
				hpColor = Color(255,150,0)
			elseif mode == 1 then -- Thermal mode
				r = 0
				g = 90
				b = 255
				hpColor = Color(0,221,255)
			elseif mode == 2 then -- Alien mode
				r = 0
				g = 255
				b = 0
				hpColor = Color(255,247,0)
			elseif mode == 3 then -- Tech mode
				r = 180
				g = 0
				b = 220
				hpColor = Color(0,173,78)
			end
			local maskBG = ent:FindBodygroupByName("mask")
			local hasMask = true
			if maskBG > -1 then
				local mask = ent.PredLord && 1 or ent:GetBodygroup(maskBG)
				if mask == 0 then
					a = 0
					hasMask = false
				end
			end

			local FT = FrameTime()
			local HP = ent:GetHP()
			local maxHP = ent:GetMaxHealth()
			local hpPer = HP /maxHP

			local dmgSplatter = ply.VJ_AVP_NPCDamageSplatter or {}
			if #dmgSplatter > 0 then
				for id,data in ipairs(dmgSplatter) do
					if data.Pos == nil then
						data.Pos = {math.random(-50,50),math.random(-30,30)}
						data.MatID = math.random(1,4)
						data.Size = math.random(20,40)
						data.Ang = math.random(0,360)
					end
					local time = data.Remain -CurTime()
					local alpha = math_Clamp(time *255,0,255)
					if alpha <= 0 then
						table.remove(dmgSplatter,id)
						continue
					end
					DrawIcon(matHUD_Blood[data.MatID],data.Pos[1],data.Pos[2],data.Size,data.Size,255,255,255,alpha,data.Ang)
				end
			end

			local cloaked = ent:GetCloaked()
			cloakA = Lerp(FT,cloakA,cloaked && 50 or 0)
			if cloaked then
				surface.SetDrawColor(Color(r,g,b,cloakA))
				surface.SetMaterial(matHUD_Cloaked)
				surface.DrawTexturedRect(0,0,ScrW(),ScrH())
			end

			surface.SetDrawColor(Color(r,g,b,a))
			surface.SetMaterial(matHUD)
			surface.DrawTexturedRect(0,0,ScrW(),ScrH())

			DrawIcon(cloaked && matHUDCloak_Outline or matHUDCloak_Solid,0,25.5,4.5,4.5,r,g,b,a)

			local equip = ent:GetEquipment()
			DrawIcon(equip == 1 && matHUDCrosshair_Plasma or (equip == 4 or equip == 5) && matHUDCrosshair_Spear or matHUDCrosshair_Other,0,0,2,2,r,g,b,a)

			local equipShowT = ent:GetEquipmentShowTime()
			if equipShowT > CurTime() then
				for i = 1,5 do
					local curEquip = equip == i
					local x,y = equipPoints[i].x,equipPoints[i].y
					local alpha = !hasMask && 0 or (curEquip && a or 50) *(equipShowT -CurTime())
					DrawIcon(matHUDEquipSelect_Base,x,y,curEquip && 12 or 10,curEquip && 8.5 or 8,r,g,b,alpha)
					DrawIcon(i == 1 && matHUDEquipSelect_Plasma or i == 2 && matHUDEquipSelect_Mine or i == 3 && matHUDEquipSelect_Disc or i == 4 && matHUDEquipSelect_Spear or matHUDEquipSelect_Speargun,x,y,8,6,r,g,b,alpha)
				end
			end

			local stimCount = ent:GetStimCount()
			local maxStimCount = 5
			local stimPos = 9
			local stimX = 0
			for i = 1,maxStimCount do
				stimX = stimX +1.1
				stimsA[i] = Lerp(FT *4,stimsA[i],!hasMask && 0 or (stimCount < i && 50 or a))
				DrawIcon(matHUD_Item_HP,stimPos +stimX,26.5,3.25,3.25,r,g,b,stimsA[i])
			end

			DrawIcon(matHUD_HP_Base,23.5,22.3,27,4,hpColor.r,hpColor.g,hpColor.b,a)
			DrawIcon_UV(matHUD_HP,9,19,hpPer *30,6,{0,0,hpPer,1},hpColor.r,hpColor.g,hpColor.b,a)
			DrawIcon(matHUD_HP_Warning,24,22,30,6,hpColor.r *1.25,hpColor.g *1.25,hpColor.b *1.25,hpPer <= 0.4 && math.abs(math.sin(CurTime() *4) *a) or a)

			if hasMask then
				local energy = ent:GetEnergy()
				local maxEnergy = 200
				local energyPer = energy /maxEnergy
				local energyPosX = -35
				local energyPosY = 22.4
				local energySize = 5
				local maxEnergyTiles = 20
				for i = 1,maxEnergyTiles do
					energysA[i] = Lerp(FT *4,energysA[i],energyPer < i /maxEnergyTiles && 25 or a)
					DrawIcon(matHUD_EP,energyPosX,energyPosY,energySize,energySize,energyColor.r,energyColor.g,energyColor.b,energysA[i])
					energyPosX = energyPosX +1.25
					energyPosY = energyPosY -0.09
					energySize = energySize -0.1
				end
			end
			
			local fov = ply:GetFOV()
			local isZoomed = fov != GetConVarNumber("fov_desired")
			ent.VJ_AVP_FOV = ent.VJ_AVP_FOV or 0
			ent.VJ_AVP_FOV = Lerp(FrameTime() *5,ent.VJ_AVP_FOV,isZoomed && 255 or 0)
			surface.SetDrawColor(Color(r,g,b,ent.VJ_AVP_FOV))
			surface.SetMaterial(matHUDZoom)
			surface.DrawTexturedRect(0,0,ScrW(),ScrH())
	
			local spear = ent:GetSpear()
			if IsValid(spear) then
				local entPos = (spear:GetPos() +spear:OBBCenter() +spear:GetForward() *-15):ToScreen()
				local size = 125
				size = size +math.sin(CurTime() *10) *10
				surface.SetDrawColor(Color(r,g,b,a *math.Clamp(spear:GetPos():Distance(ent:GetPos()) /1000,0,1)))
				surface.SetMaterial(matHUDEquip_Spear)
				surface.DrawTexturedRect(entPos.x -(size /2),entPos.y -(size /2),size,size)
			end
	
			local disc = ent:GetDisc()
			if IsValid(disc) then
				local entPos = (disc:GetPos() +disc:OBBCenter()):ToScreen()
				local size = 125
				size = size +math.sin(CurTime() *10) *10
				surface.SetDrawColor(Color(r,g,b,a *math.Clamp(disc:GetPos():Distance(ent:GetPos()) /1500,0,1)))
				surface.SetMaterial(matHUDEquip_Disc)
				surface.DrawTexturedRect(entPos.x -(size /2),entPos.y -(size /2),size,size)
			end

			for i, v in ents.Iterator() do
				if IsValid(v) && v:GetClass() == "obj_vj_avp_projectile" && v:GetTagOwner() == ent then
					local entPos = (v:GetPos() +v:OBBCenter()):ToScreen()
					local size = 75
					size = size +math.sin(CurTime() *10) *10
					surface.SetDrawColor(Color(r,g,b,a *math.Clamp(v:GetPos():Distance(ent:GetPos()) /1000,0,1)))
					surface.SetMaterial(matHUDEquip_Mine)
					surface.DrawTexturedRect(entPos.x -(size /2),entPos.y -(size /2),size,size)
				elseif IsValid(v) && v:GetClass() == "sent_vj_avp_battery" && v:GetActive() then
					local entPos = (v:GetPos() +v:OBBCenter()):ToScreen()
					local size = 75
					local alpha = math.Clamp(v:GetPos():Distance(ent:GetPos()) /1750,0,1)
					if alpha == 1 then
						alpha = 0
					end
					size = size +math.sin(CurTime() *10) *10
					surface.SetDrawColor(Color(r,g,b,a *alpha))
					surface.SetMaterial(matHUDTarget)
					surface.DrawTexturedRect(entPos.x -(size /2),entPos.y -(size /2),size,size)
				end
			end

			if equip != 1 then return end
			local lockOn = ent:GetLockOn()
			if lockOn != ent.LastLockOn then
				if IsValid(ent.LastLockOn) then
					ply:EmitSound("cpthazama/avp/weapons/predator/plasma_caster/plasma_caster_aquiretarget_01.ogg",65)
					ply:EmitSound("cpthazama/avp/weapons/predator/plasma_caster/plasma_caster_confirmtarget_01.ogg",65)
				end
				ent.LastLockOn = lockOn
			end
			if ent:GetBeam() && IsValid(lockOn) && lockOn:GetClass() != "obj_vj_bullseye" then
				if ent.VJ_AVP_LockOn == nil then
					ent.VJ_AVP_LockOn = CreateSound(ent,"cpthazama/avp/weapons/predator/plasma_caster/plasma_caster_trackingtarget_01.wav")
					ent.VJ_AVP_LockOn:SetSoundLevel(0)
					ent.VJ_AVP_LockOn:Play()
					ent.VJ_AVP_LockOn:ChangeVolume(0.7)
				end
				local entPos = (lockOn:EyePos() -(lockOn:OBBCenter() /2)):ToScreen()
				local size = 75
				size = size +math.sin(CurTime() *10) *50
				surface.SetDrawColor(Color(r,g,b,a))
				surface.SetMaterial(matHUDTarget)
				surface.DrawTexturedRect(entPos.x -(size /2),entPos.y -(size /2),size,size)
			else
				if ent.VJ_AVP_LockOn then
					ent.VJ_AVP_LockOn:Stop()
					ent.VJ_AVP_LockOn = nil
				end
			end
		end)
		if delete == true then hook.Remove("HUDPaint","VJ_AVP_Predator_HUD") end

		hook.Add("Think","VJ_AVP_Predator_VisionLight",function()
			if IsValid(ent) then
				-- local light = DynamicLight(ent:EntIndex())
				-- if (light) then
				-- 	light.Pos = ent:GetPos()
				-- 	light.r = 2
				-- 	light.g = 0
				-- 	light.b = 0
				-- 	light.Brightness = 0
				-- 	light.Size = 550
				-- 	light.Decay = 0
				-- 	light.DieTime = CurTime() +0.2
				-- 	light.Style = 0
				-- end
				
				local mode = ent:GetVisionMode()
				local maskBG = ent:FindBodygroupByName("mask")
				local hasMask = true
				if maskBG > -1 then
					local mask = ent.PredLord && 1 or ent:GetBodygroup(maskBG)
					if mask == 0 then
						mode = 0
						hasMask = false
					end
				end
				local landPos = ent:GetJumpPosition()
				-- if hasMask && landPos != scale0 then
				if hasMask && ply:KeyDown(IN_SPEED) then
					local targetPos = GetLandingPosition(ent,ply)
					targetPos = landPos != scale0 && landPos +Vector(0,0,3) or targetPos +Vector(0,0,3)
					net.Start("VJ.AVP.PredatorLandingPos")
						net.WriteEntity(ent)
						net.WriteVector(targetPos)
					net.SendToServer()
					if !IsValid(ent.LandingParticle) or IsValid(ent.LandingParticle) && mode != ent.LandingParticleMode then
						if IsValid(ent.LandingParticle) then
							ent.LandingParticle:StopEmission(false,true)
							ent.LandingParticle = nil
						end
						ent.LandingParticle = CreateParticleSystemNoEntity(mode == 0 && "vj_avp_predator_hud_landing" or mode == 1 && "vj_avp_predator_hud_landing_heat" or mode == 2 && "vj_avp_predator_hud_landing_xeno" or mode == 3 && "vj_avp_predator_hud_landing_mech",targetPos)
						ent.LandingParticleMode = mode
						-- SafeRemoveEntity(ent.LandingParticle)
					end
					if IsValid(ent.LandingParticle) then
						-- ent.LandingParticle:SetPos(targetPos)
						ent.LandingParticle:SetControlPoint(0,targetPos)
					end
				else
					if IsValid(ent.LandingParticle) then
						ent.LandingParticle:StopEmission(false,true)
						ent.LandingParticle = nil
					end
				end
				local movie = GetConVar("vj_avp_moviepred"):GetBool()
				if !hasMask then
					if mode > 0 then
						ply:EmitSound(movie && "cpthazama/avp/predator/vision/Vision_End_Movie.ogg" or "cpthazama/avp/predator/vision/prd_vision_mode_end.ogg",65)
					end
					mode = 0
				end
				if mode > 0 then
					if movie then
						if cont.VisionIdle == nil then
							cont.VisionIdle = CreateSound(cont,"cpthazama/avp/predator/vision/Vision_Movie.wav")
							-- cont.VisionIdle = CreateSound(cont,"cpthazama/avp/predator/vision_loop_original.wav")
							cont.VisionIdle:SetSoundLevel(0)
							cont.VisionIdle:Play()
							cont.VisionIdle:ChangeVolume(1)
						end
					else
						if cont.VisionHeart == nil then
							cont.VisionHeart = CreateSound(cont,"cpthazama/avp/predator/vision/prd_vision_mode_heartbeat_loop.wav")
							cont.VisionHeart:SetSoundLevel(0)
							cont.VisionHeart:Play()
							cont.VisionHeart:ChangeVolume(0.6)
						end
	
						if cont.VisionBuzz == nil then
							cont.VisionBuzz = CreateSound(cont,"cpthazama/avp/predator/vision/pred_vision_mode_buzz_loop.wav")
							cont.VisionBuzz:SetSoundLevel(0)
							cont.VisionBuzz:Play()
							cont.VisionBuzz:ChangeVolume(0.3)
						end
	
						cont.VisionBuzz:ChangePitch(mode == 1 && 100 or mode == 2 && 120 or mode == 3 && 80)
					end
				elseif mode == 0 then
					if cont.VisionHeart then
						cont.VisionHeart:Stop()
						cont.VisionHeart = nil
					end
					if cont.VisionBuzz then
						cont.VisionBuzz:Stop()
						cont.VisionBuzz = nil
					end
					if cont.VisionIdle then
						cont.VisionIdle:Stop()
						cont.VisionIdle = nil
					end
				end
			end
		end)
		if delete == true then
			if GetConVar("mat_fullbright"):GetInt() != 0 then
				RunConsoleCommand("mat_fullbright","0")
			end
			-- SafeRemoveEntity(ent.LandingParticle)
			if IsValid(ent) && IsValid(ent.LandingParticle) then
				ent.LandingParticle:StopEmission(false,true)
				ent.LandingParticle = nil
			end
			hook.Remove("Think","VJ_AVP_Predator_VisionLight")
			if cont.VisionHeart then
				cont.VisionHeart:Stop()
			end
			if cont.VisionBuzz then
				cont.VisionBuzz:Stop()
			end
			if ent.VJ_AVP_LockOn then
				ent.VJ_AVP_LockOn:Stop()
			end
			if cont.VisionIdle then
				cont.VisionIdle:Stop()
			end
		end

		local gDefault = {
			["$pp_colour_addr"] = 0,
			["$pp_colour_addg"] = 0,
			["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 1,
			["$pp_colour_colour"] = 1,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0,
			["$pp_colour_inv"] = 0,
		}
		local tab_nomask = {
			["$pp_colour_addr"] 		= -0.5,
			["$pp_colour_addg"] 		= -0.5,
			["$pp_colour_addb"] 		= -0.5,
			["$pp_colour_brightness"] 	= .25,
			["$pp_colour_contrast"] 	= 0.2,
			["$pp_colour_colour"] 		= 2,
			["$pp_colour_mulr"] 		= 1,
			["$pp_colour_mulg"] 		= 1,
			["$pp_colour_mulb"] 		= 2,
			["$pp_colour_inv"] = 0,
		}
		local tab_thermal = {
			["$pp_colour_addr"] 		= -.5,
			["$pp_colour_addg"] 		= -.5,
			["$pp_colour_addb"] 		= -.8,
			["$pp_colour_brightness"] 	= 0.6,
			["$pp_colour_contrast"] 	= 0.12,
			["$pp_colour_colour"] 		= 1,
			["$pp_colour_mulr"] 		= 10,
			["$pp_colour_mulg"] 		= 0,
			["$pp_colour_mulb"] 		= 0,
			["$pp_colour_inv"] = 0,
		}
		local tab_xeno = {
			["$pp_colour_addr"] 		= .5,
			["$pp_colour_addg"] 		= .5,
			["$pp_colour_addb"] 		= .5,
			["$pp_colour_brightness"] 	= -0.9,
			["$pp_colour_contrast"] 	= -0.25,
			["$pp_colour_colour"] 		= 1,
			["$pp_colour_mulr"] 		= 0,
			["$pp_colour_mulg"] 		= 10,
			["$pp_colour_mulb"] 		= 0,
			["$pp_colour_inv"] = 0,
		}
		local tab_tech = {
			["$pp_colour_addr"] 		= -.5,
			["$pp_colour_addg"] 		= -.5,
			["$pp_colour_addb"] 		= -.5,
			["$pp_colour_brightness"] 	= 0.6,
			["$pp_colour_contrast"] 	= 0.12,
			["$pp_colour_colour"] 		= 1,
			["$pp_colour_mulr"] 		= 10,
			["$pp_colour_mulg"] 		= 0,
			["$pp_colour_mulb"] 		= 0,
			["$pp_colour_inv"] = 0,
		}
		local acceptClasses = {prop_ragdoll=true}
		-- local acceptClasses = {viewmodel=true,prop_ragdoll=true}
		hook.Add("RenderScreenspaceEffects","VJ_AVP_Predator_Vision",function()
			if !IsValid(ent) then return end
			local mode = ent:GetVisionMode()
			if mode != ent.PreviousVisionMode then
				DrawColorModify(gDefault)
				DrawBloom(0.65,1,4,4,4,2,255,255,255)
				DrawTexturize(0,matNil)
				ent.PreviousVisionMode = mode
				ply:ScreenFade(SCREENFADE.IN,mode == 1 && Color(255,255,0,128) or mode == 2 && Color(0,52,53) or mode == 3 && Color(8,86,41) or Color(124,0,0),0.3,0)
			end

			local hasMask = true
			local maskBG = ent:FindBodygroupByName("mask")
			if maskBG > -1 then
				local mask = ent.PredLord && 1 or ent:GetBodygroup(maskBG)
				if mask == 0 then
					hasMask = false
				end
			end

			local lightLevel = math_Clamp(render_GetLightColor(ent:GetPos() +ent:OBBCenter()):Length(),0,1)
			local isDark = lightLevel <= 0.1
			ent.AVP_LastDark = ent.AVP_LastDark or isDark
			ent.AVP_LastDarkT = ent.AVP_LastDarkT or 0
			if hasMask && mode > 0 && isDark != ent.AVP_LastDark && CurTime() > ent.AVP_LastDarkT then
				local movie = GetConVar("vj_avp_moviepred"):GetBool()
				ply:EmitSound(movie && "cpthazama/avp/predator/vision/Vision_Switch_Movie.ogg" or "cpthazama/avp/predator/vision/prd_vision_adjust" .. math.random(1,4) .. ".ogg",0,mode == 1 && math.random(95,110) or mode == 2 && math.random(115,125) or mode == 3 && math.random(75,90))
				ply:ScreenFade(SCREENFADE.IN,mode == 1 && Color(106,0,91,128) or mode == 2 && Color(0,0,0) or mode == 3 && Color(64,117,126) or Color(124,0,0),0.3,0)
				ent.AVP_LastDark = isDark
				ent.AVP_LastDarkT = CurTime() +1.5
			end

			tab_thermal["$pp_colour_brightness"] = Lerp(FrameTime() *2,tab_thermal["$pp_colour_brightness"],(1 -lightLevel) *0.72)
			tab_thermal["$pp_colour_contrast"] = Lerp(FrameTime() *2,tab_thermal["$pp_colour_contrast"],math_Clamp((1 -lightLevel) *0.14,0.07,0.15))

			tab_xeno["$pp_colour_brightness"] = Lerp(FrameTime() *2,tab_xeno["$pp_colour_brightness"],math_Clamp(lightLevel *-1.3,-1.2,-0.8))
			tab_xeno["$pp_colour_contrast"] = Lerp(FrameTime() *2,tab_xeno["$pp_colour_contrast"],math_Clamp((1 -lightLevel) *-0.2,-0.35,-0.2))

			tab_tech["$pp_colour_brightness"] = Lerp(FrameTime() *2,tab_tech["$pp_colour_brightness"],(1 -lightLevel) *0.72)
			tab_tech["$pp_colour_contrast"] = Lerp(FrameTime() *2,tab_tech["$pp_colour_contrast"],math_Clamp((1 -lightLevel) *0.14,0.07,0.15))

			tab_nomask["$pp_colour_brightness"] = Lerp(FrameTime() *2,tab_nomask["$pp_colour_brightness"],math_Clamp((1 -lightLevel) *0.9,0.6,1))

			if !hasMask then
				DrawColorModify(tab_nomask)
				DrawBloom(0,0.5,1,1,0,0,10,10,10)
				DrawTexturize(0,matGradientNoMask)
				if IsValid(cont) then
					cont:SetDSP(1)
				end
				mode = 0
				return
			end

			if mode > 0 then
				local dLight = DynamicLight(ent:EntIndex())
				if dLight then
					dLight.Pos = ent:GetPos() +ent:OBBCenter()
					dLight.r = 5
					dLight.g = 5
					dLight.b = 5
					dLight.Brightness = 1
					dLight.Size = 4000
					dLight.Decay = 0
					dLight.DieTime = CurTime() +0.2
					dLight.Style = 0
				end
				DrawMotionBlur(0.4,0.8,0.015)
				if mode == 1 then
					-- DrawColorModify(tab_thermal)
					DrawBloom(0,1,1,1,0,-10,0.6,0.6,0.6)
					DrawTexturize(10,matGradientThermal2)
				elseif mode == 2 then
					DrawColorModify(tab_xeno)
					DrawBloom(0,0.5,1,1,0,0,10,10,10)
					DrawTexturize(10,matGradientXeno)
				elseif mode == 3 then
					DrawColorModify(tab_tech)
					DrawBloom(0,0.5,1,1,0,0,10,10,10)
					DrawTexturize(10,matGradientTech)
				end
				for _,v in ents.Iterator() do
					if mode == 1 then
						if v:IsNPC() or v:IsPlayer() or v:IsNextBot() or v:GetClass() == "prop_ragdoll" /*or v:GetClass() == "viewmodel"*/ then
							if v:GetNoDraw() == true or v:IsFlagSet(FL_NOTARGET) == true or v.IsVJBaseBullseye or (v:GetNW2Bool("AVP.IsTech",false) or v.VJ_AVP_IsTech) or (v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) then continue end
							local isVM = v:GetClass() == "viewmodel"
							-- if v:GetClass() == "prop_ragdoll" then
							-- 	print(v:GetModel(),v:GetBoneSurfaceProp(0),matSurf[v:GetBoneSurfaceProp(0)] != true)
							-- end
							if v:GetClass() == "prop_ragdoll" && matSurf[v:GetBoneSurfaceProp(0)] != true then continue end
							cam.Start3D(EyePos(),EyeAngles(),isVM && 92)
								if !isVM && util.IsValidModel(v:GetModel()) or isVM then
								-- if util.IsValidModel(v:GetModel()) then
									render.ClearStencil()
									render.SetStencilEnable(true)
									render.SetStencilWriteMask(255)
									render.SetStencilTestMask(255)
									render.SetStencilReferenceValue(1)
									render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
									render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
									render.SetStencilFailOperation(STENCILOPERATION_KEEP)
									render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
									v:DrawModel()
									render.SuppressEngineLighting(true)
									if v.VJ_AVP_Predator && v:GetCloaked() then
										render.MaterialOverride(matTT_Thermal)
									end
									render.SetColorModulation(1.65,1.65,1.65)
									render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
									render.SetStencilPassOperation(STENCILOPERATION_KEEP)
									v:DrawModel()
									if !(v.VJ_AVP_Predator && v:GetCloaked()) then
										DrawMotionBlur(1,0.15,1)
										DrawBloom(0,1,1,1,1,2,1,0.8,0.8)
										DrawTexturize(0,matGradientThermal)
									end
									render.SetColorModulation(1,1,1)
									render.MaterialOverride(0)
									render.SuppressEngineLighting(false)
									render.SetStencilEnable(false)

									-- render.OverrideDepthEnable(true,false)
									-- render.SetLightingMode(2)
									-- render.SetColorModulation(2,0,0)
									-- if v.VJ_AVP_Predator && v:GetCloaked() then
									-- 	render.MaterialOverride(matTT_Thermal)
									-- end
									-- v:DrawModel()
									-- render.SetColorModulation(1,1,1)
									-- render.MaterialOverride(0)
									-- render.SetLightingMode(0)
									-- render.OverrideDepthEnable(false,false)
									-- for _,x in pairs(v:GetChildren()) do
									-- 	if IsValid(x) then
									-- 		local mdl = x:GetModel()
									-- 		if mdl && util.IsValidModel(mdl) then
									-- 			render.OverrideDepthEnable(true,false)
									-- 			render.SetLightingMode(2)
									-- 			render.SetColorModulation(2,0,0)
									-- 			if v.VJ_AVP_Predator && v:GetCloaked() then
									-- 				render.MaterialOverride(matTT_Thermal)
									-- 			end
									-- 			x:DrawModel()
									-- 			render.SetColorModulation(1,1,1)
									-- 			render.MaterialOverride(0)
									-- 			render.SetLightingMode(0)
									-- 			render.OverrideDepthEnable(false,false)
									-- 		end
									-- 	end
									-- end
								end
							cam.End3D()
						end

					elseif mode == 2 && (v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) && v:IsNPC() then
						cam.Start3D(EyePos(),EyeAngles())
							if util.IsValidModel(v:GetModel()) then
								render.OverrideDepthEnable(true,false)
								render.SetLightingMode(2)
								-- render.MaterialOverride(matXenoOverlay)
								v:DrawModel()
								-- render.MaterialOverride(0)
								render.SetLightingMode(0)
								render.OverrideDepthEnable(false,false)
							end
						cam.End3D()
					elseif mode == 3 && (v:GetNW2Bool("AVP.IsTech",false) or v.VJ_AVP_IsTech) then
						cam.Start3D(EyePos(),EyeAngles())
							if util.IsValidModel(v:GetModel()) then
								render.OverrideDepthEnable(true,false)
								render.SetLightingMode(2)
								render.SetBlend(1)
								if v.GetCloaked && v:GetCloaked() then
									render.MaterialOverride(matColdOverlay_Cloaked)
								else
									render.MaterialOverride(matColdOverlay)
								end
								v:DrawModel()
								render.OverrideDepthEnable(false,false)
								render.SetLightingMode(0)
								render.MaterialOverride(0)
								render.SetBlend(1)
							end
						cam.End3D()
					end
				end
				if IsValid(cont) then
					cont:SetDSP(31)
				end
			end
			if mode == 0 then
				if IsValid(cont) then
					cont:SetDSP(1)
				end
			end
		end)
		-- hook.Add("RenderScreenspaceEffects","VJ_AVP_Predator_XenoVision",function()
		-- 	if !IsValid(ent) then return end
		-- 	local mode = ent:GetVisionMode()

		-- 	local hasMask = true
		-- 	local maskBG = ent:FindBodygroupByName("mask")
		-- 	if maskBG > -1 then
		-- 		local mask = ent:GetBodygroup(maskBG)
		-- 		if mask == 0 then
		-- 			hasMask = false
		-- 		end
		-- 	end

		-- 	if mode > 0 && hasMask then
		-- 		local dLight = DynamicLight(ent:EntIndex())
		-- 		if dLight then
		-- 			dLight.Pos = ent:GetPos() +ent:OBBCenter()
		-- 			dLight.r = 5
		-- 			dLight.g = 5
		-- 			dLight.b = 5
		-- 			dLight.Brightness = 1
		-- 			dLight.Size = 4000
		-- 			dLight.Decay = 0
		-- 			dLight.DieTime = CurTime() +0.2
		-- 			dLight.Style = 0
		-- 		end
		-- 		for _,v in ents.Iterator() do
		-- 			if mode == 2 && (v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) && v:IsNPC() then
		-- 				cam.Start3D(EyePos(),EyeAngles())
		-- 					if util.IsValidModel(v:GetModel()) then
		-- 						render.OverrideDepthEnable(true,false)
		-- 						render.SetLightingMode(2)
		-- 						v:DrawModel()
		-- 						render.OverrideDepthEnable(false,false)
		-- 						render.SetLightingMode(0)
		-- 					end
		-- 					-- if util.IsValidModel(v:GetModel()) then
		-- 					-- 	-- render.SetBlend(0.6)
		-- 					-- 	-- render.MaterialOverride(matXenoOverlay)
		-- 					-- 	v:DrawModel()
		-- 					-- 	render.MaterialOverride(0)
		-- 					-- 	render.SetBlend(1)
		-- 					-- end
		-- 				cam.End3D()
		-- 			elseif mode == 3 && (v:GetNW2Bool("AVP.IsTech",false) or v.VJ_AVP_IsTech) then
		-- 				cam.Start3D(EyePos(),EyeAngles())
		-- 					if util.IsValidModel(v:GetModel()) then
		-- 						render.OverrideDepthEnable(true,false)
		-- 						render.SetLightingMode(2)
		-- 						render.SetBlend(1)
		-- 						render.MaterialOverride(matColdOverlay)
		-- 						v:DrawModel()
		-- 						render.OverrideDepthEnable(false,false)
		-- 						render.SetLightingMode(0)
		-- 						render.MaterialOverride(0)
		-- 						render.SetBlend(1)
		-- 					end
		-- 				cam.End3D()
		-- 			end
		-- 		end
		-- 	end
		-- end)
		if delete == true then
			-- if GetConVar("mat_fullbright"):GetInt() != 0 then
			-- 	RunConsoleCommand("mat_fullbright","0")
			-- end
			hook.Remove("RenderScreenspaceEffects","VJ_AVP_Predator_Vision")
			-- hook.Remove("RenderScreenspaceEffects","VJ_AVP_Predator_XenoVision")
			if IsValid(cont) then
				cont:SetDSP(1)
				cont.VJCE_NPC = nil
				local vm = cont:GetViewModel()
				if IsValid(vm) then
					vm:SetMaterial("")
				end
			end
		end
	end)
end