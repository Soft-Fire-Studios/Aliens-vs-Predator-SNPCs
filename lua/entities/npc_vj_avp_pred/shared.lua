ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

include("vj_base/extensions/avp_viewmodel_module.lua")

ENT.VJ_AVP_NPC = true
ENT.VJ_AVP_Creature = true
ENT.VJ_AVP_Predator = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity",0,"LockOn")
	self:NetworkVar("Entity",1,"VM")
	self:NetworkVar("Int",0,"VisionMode")
	self:NetworkVar("Bool",0,"Cloaked")
	self:NetworkVar("Bool",1,"Sprinting")
	self:NetworkVar("Bool",2,"Beam")
	self:NetworkVar("Vector",0,"JumpPosition")
end

hook.Add("PlayerButtonDown","VJ_AVP_Predator_Buttons",function(ply,button)
	if ply.VJTag_IsControllingNPC == true && IsValid(ply.VJ_TheControllerEntity) then
		local cent = ply.VJ_TheControllerEntity
		local npc = cent.VJCE_NPC
		if npc.VJ_AVP_Creature then
			ply:AllowFlashlight(false)
		end

		if button == KEY_F && npc.VJ_AVP_Predator then
			local mode = npc:GetVisionMode()
			if mode == 0 then
				ply:EmitSound("cpthazama/avp/predator/vision/prd_vision_mode_start_mono.ogg",65)
			elseif mode == 3 then
				ply:EmitSound("cpthazama/avp/predator/vision/prd_vision_mode_end.ogg",65)
			else
				ply:EmitSound(VJ.PICK({
					"cpthazama/avp/predator/vision/vision_change_01.ogg",
					"cpthazama/avp/predator/vision/vision_change_02.ogg",
					"cpthazama/avp/predator/vision/vision_change_04.ogg",
					"cpthazama/avp/predator/vision/vision_change_05.ogg",
				}),65)
			end
			npc:SetVisionMode(mode +1 > 3 && 0 or mode +1)
			-- local snd = CreateSound(ply,"cpthazama/avp/predator/vision_change_01.wav")
			-- snd:SetSoundLevel(0)
			-- snd:Play()
			-- snd:ChangeVolume(70)
		end
		
		local fov = ply:GetFOV()
		-- if button == KEY_H then
		-- 	if cent.VJC_Camera_Mode == 1 && fov != GetConVarNumber("fov_desired") then
		-- 		ply:SetFOV(GetConVarNumber("fov_desired"),0.1)
		-- 		ply:EmitSound("cpthazama/avp/predator/prd_vision_mode_zoom_out.wav",65)
		-- 	end
		-- end
		if cent.VJC_Camera_Mode == 2 then
			if button == KEY_MOUSESCROLL_UP then
				ply:SetFOV(fov <= 1 && GetConVarNumber("fov_desired") or math.Clamp(fov -20,1,180),0.25)
				ply:EmitSound("cpthazama/avp/predator/vision/prd_vision_mode_zoom.ogg",65)
				cent.VJC_Camera_CurZoom = Vector(0,0,0)
			elseif button == KEY_MOUSESCROLL_DOWN then
				ply:SetFOV(GetConVarNumber("fov_desired"),0.1)
				ply:EmitSound("cpthazama/avp/predator/vision/prd_vision_mode_zoom_out.ogg",65)
				cent.VJC_Camera_CurZoom = Vector(0,0,0)
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
    function ENT:Initialize()
		self.Mat_cloakfactor = 0

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

		-- hook.Add("PlayerBindPress",self,function(self,ply,bind,pressed)
		-- 	if ply.VJTag_IsControllingNPC == true && IsValid(ply.VJCE_NPC) && ply.VJCE_NPC == self then
		-- 		-- local cent = ply.VJ_TheControllerEntity
		-- 		if pressed && ply.VJC_Camera_Mode == 2 then
		-- 		-- if pressed then
		-- 			bind = string_lower(bind)
		-- 			local fov = ply:GetFOV()
		-- 			if string_find(bind,"invprev") then
		-- 				ply:SetFOV(fov <= 1 && GetConVarNumber("fov_desired") or math.Clamp(fov -20,1,180),0.25)
		-- 				ply:EmitSound("cpthazama/avp/predator/prd_vision_mode_zoom.wav",65)
		-- 				-- cent.VJC_Camera_CurZoom = Vector(0,0,0)
		-- 				return true
		-- 			elseif string_find(bind,"invnext") then
		-- 				ply:SetFOV(GetConVarNumber("fov_desired"),0.1)
		-- 				ply:EmitSound("cpthazama/avp/predator/prd_vision_mode_zoom_out.wav",65)
		-- 				-- cent.VJC_Camera_CurZoom = Vector(0,0,0)
		-- 				return true
		-- 			end
		-- 		end
		-- 	end
		-- end)
	end

	local math_abs = math.abs
	local blueFX = Vector(0.5,2,6)
	local whiteFX = Vector(1,1,1)
    matproxy.Add({
        name = "AVP_Cloak",
        init = function(self,mat,values)
            self.Result = values.resultvar
			self.CloakColorTint = mat:GetVector("$cloakcolortint") or whiteFX
        end,
        bind = function(self,mat,ent)
            if (!IsValid(ent)) then return end

			ent.Mat_cloakfactor = ent.Mat_cloakfactor or 0
			local curValue = ent.Mat_cloakfactor
			local finalResult = curValue or 0
			if ent.GetCloaked then
				if ent:GetCloaked() then
					finalResult = ent:IsNPC() && (ent:GetSprinting() or ent:GetJumpPosition() != scale0) && 0.97 or 0.997
				else
					finalResult = 0
					finalResultRefract = 0
				end
			end
			ent.Mat_cloakfactor = Lerp(FrameTime() *0.3,curValue,finalResult)
			self.CloakColorTint = LerpVector(FrameTime() *0.3,self.CloakColorTint,math_abs(curValue -finalResult) > 0.1 && blueFX or whiteFX)
			mat:SetVector("$cloakcolortint",self.CloakColorTint)
			mat:SetFloat(self.Result,ent.Mat_cloakfactor)
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
		self:DrawModel()
		
		local attStart = self:LookupAttachment("laser")
		if !self:GetBeam() then return end
		local att = self:GetAttachment(attStart)
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
		-- local vm = self.VM
		-- local ply = self.VJ_TheController
		-- if IsValid(vm) then
		-- 	if IsValid(ply) && ply.VJC_Camera_Mode == 2 then
		-- 		local pos = ply:GetShootPos()
		-- 		local ang = ply:EyeAngles()
		-- 		vm:SetRenderOrigin(pos)
		-- 		vm:SetRenderAngles(ang)
		-- 		vm:SetNoDraw(false)
		-- 		if CurTime() > vm.CurrentAnimTime then
		-- 			self:VM_PlayAnimation("fire",1)
		-- 		end
		-- 	elseif !IsValid(ply) then
		-- 		vm:Remove()
		-- 	elseif IsValid(ply) && ply.VJC_Camera_Mode == 1 then
		-- 		vm:SetNoDraw(true)
		-- 	end
		-- else
		-- 	if IsValid(ply) && ply.VJC_Camera_Mode == 2 then
		-- 		local ent = self:VM_Initialize("models/weapons/v_pistol.mdl",ply)
		-- 		self:SetVM(ent)
		-- 		ent:SetParent(ply.VJCE_Camera)
		-- 		ent:AddEffects(EF_PARENT_ANIMATES)
		-- 	end
		-- end

		-- local ply = self.VJ_TheController
		-- local bone = self:LookupBone("Bip01 Mask")
		-- if IsValid(ply) && ply.VJC_Camera_Mode == 2 then
		-- 	if bone then
		-- 		self:ManipulateBoneScale(bone,scale0)
		-- 	end
		-- else
		-- 	if bone then
		-- 		self:ManipulateBoneScale(bone,scale1)
		-- 	end
		-- end

		-- local maskBG = self:FindBodygroupByName("mask")
		-- if maskBG == -1 then return end
		-- local mask = self:GetBodygroup(maskBG)
		-- if mask != 0 then
		-- 	for _,v in pairs(faceBones) do
		-- 		local bone = self:LookupBone(v)
		-- 		if bone then
		-- 			self:ManipulateBoneScale(bone,scale0)
		-- 		end
		-- 	end
		-- else
		-- 	for _,v in pairs(faceBones) do
		-- 		local bone = self:LookupBone(v)
		-- 		if bone then
		-- 			self:ManipulateBoneScale(bone,scale1)
		-- 		end
		-- 	end
		-- end
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
	local matHUD = Material("hud/cpthazama/avp/predator_hud.png")
	local matHUDZoom = Material("hud/cpthazama/avp/predator_zoom.png")
	local matHUDTarget = Material("hud/cpthazama/avp/predator_target.png")
	local matNil = Material(" ")
	local matGradientThermal = Material("hud/cpthazama/avp/thermal_gradient.png")
	local matGradientXeno = Material("hud/cpthazama/avp/grey_gradient.png")
	local matGradientTech = Material("hud/cpthazama/avp/tech_gradient.png")
	local matGradientNoMask = Material("hud/cpthazama/avp/tech_world_gradient_darker.png")
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
			-- if cont.VisionIdle then cont.VisionIdle:Stop() end
			hook.Remove("PlayerButtonDown","VJ_AVP_Predator_Buttons")
		else
			ent.VJ_TheControllerEntity = cont
			ent.VJ_TheController = ply
		end

		local index = ent:EntIndex()
		hook.Add("RenderScreenspaceEffects","VJ_AVP_Predator_XenoFX", function()
			if !IsValid(ent) then return end
			for _,v in pairs(ents.GetAll()) do
				if ent.PreviousVisionMode == 1 then
					if v:IsNPC() or v:IsPlayer() or v:IsNextBot() then
						if v:GetNoDraw() == true or v:IsFlagSet(FL_NOTARGET) == true or v.IsVJBaseBullseye or (v:GetNW2Bool("AVP.IsTech",false) or v.VJ_AVP_IsTech) or (v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) then continue end
						cam.Start3D(EyePos(),EyeAngles())
							if util.IsValidModel(v:GetModel()) then
								render.SetBlend(1)
								render.MaterialOverride(v.VJ_AVP_Predator && v:GetCloaked() && matTT_Thermal or matTT_Thermal_Overlay)
								v:DrawModel()
								render.MaterialOverride(0)
								render.SetBlend(1)
							end
						cam.End3D()
					end
				elseif ent.PreviousVisionMode == 2 && (v.VJ_AVP_Xenomorph or v:GetNW2Bool("AVP.Xenomorph",false)) then
					cam.Start3D(EyePos(),EyeAngles())
						if util.IsValidModel(v:GetModel()) then
							render.SetBlend(0.6)
							render.MaterialOverride(matXenoOverlay)
							v:DrawModel()
							render.MaterialOverride(0)
							render.SetBlend(1)
						end
					cam.End3D()
				elseif ent.PreviousVisionMode == 3 && (v:GetNW2Bool("AVP.IsTech",false) or v.VJ_AVP_IsTech) then
					cam.Start3D(EyePos(),EyeAngles())
						if util.IsValidModel(v:GetModel()) then
							render.SetBlend(1)
							render.MaterialOverride(matColdOverlay)
							v:DrawModel()
							render.MaterialOverride(0)
							render.SetBlend(1)
						end
					cam.End3D()
				end
			end
		end)
		if delete == true then hook.Remove("PreDrawHalos","VJ_AVP_Predator_XenoFX") end

		hook.Add("HUDPaint","VJ_AVP_Predator_HUD",function()
			if !IsValid(ent) then return end
			local r = 255
			local g = 0
			local b = 0
			local a = 250

			local mode = ent:GetVisionMode()
			if mode == 0 then -- No Mask
				-- a = 250
			elseif mode == 1 then -- Thermal mode
				r = 0
				g = 90
				b = 255
			elseif mode == 2 then -- Alien mode
				r = 0
				g = 255
				b = 0
			elseif mode == 3 then -- Tech mode
				r = 80
				g = 80
				b = 80
			end
			local maskBG = ent:FindBodygroupByName("mask")
			if maskBG > -1 then
				local mask = ent:GetBodygroup(maskBG)
				if mask == 0 then
					a = 0
				end
			end

			surface.SetDrawColor(Color(r,g,b,a))
			surface.SetMaterial(matHUD)
			surface.DrawTexturedRect(0,0,ScrW(),ScrH())
			
			local fov = ply:GetFOV()
			local isZoomed = fov != GetConVarNumber("fov_desired")
			ent.VJ_AVP_FOV = ent.VJ_AVP_FOV or 0
			ent.VJ_AVP_FOV = Lerp(FrameTime() *5,ent.VJ_AVP_FOV,isZoomed && 255 or 0)
			surface.SetDrawColor(Color(r,g,b,ent.VJ_AVP_FOV))
			surface.SetMaterial(matHUDZoom)
			surface.DrawTexturedRect(0,0,ScrW(),ScrH())

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
				local light = DynamicLight(ent:EntIndex())
				if (light) then
					light.Pos = ent:GetPos()
					light.r = 2
					light.g = 0
					light.b = 0
					light.Brightness = 0
					light.Size = 550
					light.Decay = 0
					light.DieTime = CurTime() +0.2
					light.Style = 0
				end
				
				local mode = ent:GetVisionMode()
				local maskBG = ent:FindBodygroupByName("mask")
				local hasMask = true
				if maskBG > -1 then
					local mask = ent:GetBodygroup(maskBG)
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
				if mode > 0 then
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

					-- if cont.VisionIdle == nil then
					-- 	cont.VisionIdle = CreateSound(cont,"cpthazama/avp/predator/vision_loop_original.wav")
					-- 	cont.VisionIdle:SetSoundLevel(0)
					-- 	cont.VisionIdle:Play()
					-- 	cont.VisionIdle:ChangeVolume(0.5)
					-- end
				elseif mode == 0 then
					if cont.VisionHeart then
						cont.VisionHeart:Stop()
						cont.VisionHeart = nil
					end
					if cont.VisionBuzz then
						cont.VisionBuzz:Stop()
						cont.VisionBuzz = nil
					end
					-- if cont.VisionIdle then
					-- 	cont.VisionIdle:Stop()
					-- 	cont.VisionIdle = nil
					-- end
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
			-- if cont.VisionIdle then
			-- 	cont.VisionIdle:Stop()
			-- end
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
			["$pp_colour_mulb"] = 0
		}
		local tab_nomask = {
			["$pp_colour_addr"] 		= -0.5,
			["$pp_colour_addg"] 		= -0.5,
			["$pp_colour_addb"] 		= -0.5,
			["$pp_colour_brightness"] 	= .25,
			["$pp_colour_contrast"] 	= 1,
			["$pp_colour_colour"] 		= 2,
			["$pp_colour_mulr"] 		= 1,
			["$pp_colour_mulg"] 		= 1,
			["$pp_colour_mulb"] 		= 2,
		}
		local tab_thermal = {
			["$pp_colour_addr"] 		= -.5,
			["$pp_colour_addg"] 		= -.5,
			["$pp_colour_addb"] 		= -.5,
			["$pp_colour_brightness"] 	= 0.6,
			["$pp_colour_contrast"] 	= 0.12,
			["$pp_colour_colour"] 		= 1,
			["$pp_colour_mulr"] 		= 10,
			["$pp_colour_mulg"] 		= 0,
			["$pp_colour_mulb"] 		= 0,
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
		}
		local tab_tech = {
			["$pp_colour_addr"] 		= -.5,
			["$pp_colour_addg"] 		= -.5,
			["$pp_colour_addb"] 		= -.5,
			["$pp_colour_brightness"] 	= 0.4,
			["$pp_colour_contrast"] 	= 0.2,
			["$pp_colour_colour"] 		= 1,
			["$pp_colour_mulr"] 		= 10,
			["$pp_colour_mulg"] 		= 0,
			["$pp_colour_mulb"] 		= 0,
		}
		hook.Add("RenderScreenspaceEffects","VJ_AVP_Predator_Vision",function()
			if !IsValid(ent) then return end
			local mode = ent:GetVisionMode()
			if mode != ent.PreviousVisionMode then
				DrawColorModify(gDefault)
				DrawBloom(0.65,1,4,4,4,2,255,255,255)
				DrawTexturize(0,matNil)
				ent.PreviousVisionMode = mode
				ply:ScreenFade(SCREENFADE.IN,mode == 1 && Color(255,255,0,128) or mode == 2 && Color(0,0,0) or mode == 3 && Color(0,213,90) or Color(124,0,0),0.3,0)
			end

			local hasMask = true
			local maskBG = ent:FindBodygroupByName("mask")
			if maskBG > -1 then
				local mask = ent:GetBodygroup(maskBG)
				if mask == 0 then
					hasMask = false
				end
			end
			
			if mode == 1 && hasMask then
				DrawColorModify(tab_thermal)
				DrawBloom(0,0.5,1,1,0,0,10,10,10)
				DrawTexturize(0,matGradientThermal)
			elseif mode == 2 && hasMask then
				DrawColorModify(tab_xeno) 
				DrawBloom(0,0.5,1,1,0,0,10,10,10)
				DrawTexturize(0,matGradientXeno)
			elseif mode == 3 && hasMask then
				DrawColorModify(tab_tech) 
				DrawBloom(0,0.5,1,1,0,0,10,10,10)
				DrawTexturize(0,matGradientTech)
			else
				local maskBG = ent:FindBodygroupByName("mask")
				if maskBG > -1 then
					local mask = ent:GetBodygroup(maskBG)
					if mask == 0 then
						DrawColorModify(tab_nomask) 
						DrawBloom(0,0.5,1,1,0,0,10,10,10)
						DrawTexturize(0,matGradientNoMask)
					end
				end
			end
		end)
		if delete == true then hook.Remove("RenderScreenspaceEffects","VJ_AVP_Predator_Vision") end
	end)
end