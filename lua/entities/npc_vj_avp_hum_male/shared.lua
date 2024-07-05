ENT.Base 			= "npc_vj_human_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "VJ Base"

ENT.VJ_AVP_NPC = true
ENT.VJ_AVP_Marine = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Sprinting")
	self:NetworkVar("Bool",1,"Cloaked")
	self:NetworkVar("Entity",0,"Flare")
end

if CLIENT then
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

	local math_Clamp = math.Clamp
	local distortedColor = Color(170,238,255)

	local function DrawIcon(mat,x,y,width,height,r,g,b,a,ang,noDist)
		local pos
		local size = ScreenScale(width,height)
		if noDist != true then
			local distortionAmount = math.random(1,600) == 1 && 1 or 0.1
			local distortion = math.abs(math.sin(CurTime() *2) *50)
			surface.SetDrawColor(Color(distortedColor.r,distortedColor.g,distortedColor.b,math_Clamp(a +math.random(-distortion,distortion),0,255)))
			surface.SetMaterial(mat)
			pos = ScreenPos(x +math.Rand(-distortionAmount,distortionAmount),y +math.Rand(-distortionAmount,distortionAmount))
			size = ScreenScale(width,height)
			surface.DrawTexturedRectRotated(pos.x,pos.y,size.x,size.y,ang or 0)
		end

		surface.SetDrawColor(Color(r or 255,g or 255,b or 255,a or 255))
		surface.SetMaterial(mat)
		local pos = ScreenPos(x,y)
		surface.DrawTexturedRectRotated(pos.x,pos.y,size.x,size.y,ang or 0)
	end

	local function DrawIcon_UV(mat,x,y,width,height,uv,r,g,b,a)
		local uv = uv or {0,0,1,1}

		local distortionAmount = math.random(1,600) == 1 && 1 or 0.1
		local distortion = math.abs(math.sin(CurTime() *2) *50)
		surface.SetDrawColor(Color(distortedColor.r,distortedColor.g,distortedColor.b,math_Clamp(a +math.random(-distortion,distortion),0,255)))
		surface.SetMaterial(mat)
		local pos = ScreenPos(x +math.Rand(-distortionAmount,distortionAmount),y +math.Rand(-distortionAmount,distortionAmount))
		local size = ScreenScale(width,height)
		surface.DrawTexturedRectUV(pos.x,pos.y,size.x,size.y,uv[1],uv[2],uv[3],uv[4])

		surface.SetDrawColor(Color(r or 255,g or 255,b or 255,a or 255))
		surface.SetMaterial(mat)
		local pos = ScreenPos(x,y)
		surface.DrawTexturedRectUV(pos.x,pos.y,size.x,size.y,uv[1],uv[2],uv[3],uv[4])
	end

	local function DrawIcon_Rotated(mat,x,y,width,height,r,g,b,a,ang)
		local distortionAmount = math.random(1,600) == 1 && 1 or 0.1
		local distortion = math.abs(math.sin(CurTime() *2) *50)
		surface.SetDrawColor(Color(distortedColor.r,distortedColor.g,distortedColor.b,math_Clamp(a +math.random(-distortion,distortion),0,255)))
		surface.SetMaterial(mat)
		local pos = ScreenPos(x +math.Rand(-distortionAmount,distortionAmount),y +math.Rand(-distortionAmount,distortionAmount))
		local size = ScreenScale(width,height)
		surface.DrawTexturedRectRotated(pos.x,pos.y,size.x,size.y,ang or 0)

		surface.SetDrawColor(Color(r or 255,g or 255,b or 255,a or 255))
		surface.SetMaterial(mat)
		local pos = ScreenPos(x,y)
		surface.DrawTexturedRectRotated(pos.x,pos.y,size.x,size.y,ang or 0)
	end

	local function DrawText(text,font,x,y,color,alignX,alignY)
		local textSize = surface.GetTextSize(text) or string.len(text) -- wtf is this error
		local pos = ScreenPos(x,y)
		local size = ScreenScale(textSize,0)
		local distortion = math.abs(math.sin(CurTime() *4) *50)
		local col = Color(distortedColor.r,distortedColor.g,distortedColor.b,math_Clamp(distortedColor.a +math.random(-distortion,distortion),0,255))
	
		draw.SimpleText(text,font,pos.x +math.Rand(-2,2),pos.y +math.Rand(-2,2),col,alignX or 0,alignY or 0)
		draw.SimpleText(text,font,pos.x,pos.y,color or color_white,alignX or 0,alignY or 0)
	end

	local function CalcRelativePosition(ent, vec, maxDist)
		local plyPos = ent:GetPos()
		local diffPos = vec -plyPos

		local plyForward = ent:EyeAngles().y -90
		local ang = math.deg(math.atan2(diffPos.y,diffPos.x) -math.rad(plyForward))
		ang = (ang +360) %360
		if ang >= 180 then
			ang = ang -360
		end

		ang = -ang

		local dist = math_Clamp(diffPos:Length() *(1 /maxDist),0,1)
		return ang, dist
	end

	local matHUD_Test = Material("hud/cpthazama/avp/avp_m_hud_base.png","smooth additive")
	local matHUD_Block = Material("hud/cpthazama/avp/avp_m_hud_block.png","smooth additive")
	local matHUD_BlockShort = Material("hud/cpthazama/avp/avp_m_hud_block_short.png","smooth additive")
	local matHUD_BlockFilling = Material("hud/cpthazama/avp/avp_m_hud_block_fill.png","smooth additive")
	local matHUD_Crosshair = Material("hud/cpthazama/avp/avp_m_hud_crosshair.png","smooth additive")
	local matHUD_Flare = Material("hud/cpthazama/avp/avp_m_hud_flare.png","smooth additive")
	local matHUD_Stims = Material("hud/cpthazama/avp/avp_m_hud_icon_hp.png","smooth additive")
	local matHUD_MotionTracker = Material("hud/cpthazama/avp/avp_m_hud_motiontracker.png","smooth additive")
	local matHUD_MotionTracker_Half = Material("hud/cpthazama/avp/avp_m_hud_motiontracker_half.png","smooth additive")
	local matHUD_MotionTracker_HalfBG = Material("hud/cpthazama/avp/avp_m_hud_motiontracker_half_bg.png","smooth additive")
	local matHUD_MotionTracker_Base = Material("hud/cpthazama/avp/avp_m_hud_motiontracker_base.png","smooth additive")
	local matHUD_MotionTracker_Scan = Material("hud/cpthazama/avp/avp_m_hud_motiontracker_ping.png","smooth additive")
	local matHUD_MotionTracker_Enemy = Material("hud/cpthazama/avp/avp_m_hud_motiontracker_dot_enemy.png","smooth additive")
	local matHUD_MotionTracker_Friendly = Material("hud/cpthazama/avp/avp_m_hud_motiontracker_dot_friendly.png","smooth additive")
	local matHUD_Text = Material("hud/cpthazama/avp/avp_m_hud_text1.png","smooth additive")

	local matHUD_Blood = {
		Material("hud/cpthazama/avp/blood/red_1.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/red_2.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/red_3.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/red_4.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/white_1.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/white_2.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/white_3.png","smooth additive"),
		Material("hud/cpthazama/avp/blood/white_4.png","smooth additive"),
	}

	local stimsA = {255,255,255}
	local flare = 255

	net.Receive("VJ_AVP_PingTable",function(len,pl)
		local ent = net.ReadEntity()
		local tblEnts = net.ReadTable()

		ent.VJ_AVP_PingTable = tblEnts
	end)

	local checkedPingPositions = false
	local closestPing = 0
	local checkedPings = {}

	net.Receive("VJ.AVP.PlayerHUDDamage",function(len,pl)
		local ply = LocalPlayer()
		if ply.VJTag_IsControllingNPC or !ply.VJTag_IsControllingNPC && GetConVar("vj_avp_hud"):GetInt() == 1 then
			local time = CurTime() +math.Rand(3,5)
			local dmg = net.ReadInt(16)
			local count = math.random(1,3) // 1
			-- if dmg <= 0 then return end
			-- if dmg > 75 then
			-- 	count = 3
			-- end
			if !ply.VJTag_IsControllingNPC then
				ply.VJ_AVP_DamageSplatter = ply.VJ_AVP_DamageSplatter or {}
				for i = 1,count do
					ply.VJ_AVP_DamageSplatter[#ply.VJ_AVP_DamageSplatter +1] = {Remain=time,Init=time}
				end
			else
				ply.VJ_AVP_NPCDamageSplatter = ply.VJ_AVP_NPCDamageSplatter or {}
				for i = 1,count do
					ply.VJ_AVP_NPCDamageSplatter[#ply.VJ_AVP_NPCDamageSplatter +1] = {Remain=time,Init=time}
				end
			end
			-- ply:ChatPrint("You have been hit!")
		end
	end)

	hook.Add("HUDPaint","VJ_AVP_Marine_HUD",function()
		local ply = LocalPlayer()
		local ent
		if ply.VJTag_IsControllingNPC == true then
			local npc = ply.VJCE_NPC
			if npc.VJ_AVP_Marine && !npc.VJ_AVP_Civilian then
				ent = npc
			else
				ent = false
			end
		elseif IsValid(ply:GetObserverTarget()) then
			ent = ply:GetObserverTarget()
		end
		if ent == false then return end
		if !IsValid(ent) && GetConVar("vj_avp_hud"):GetInt() == 1 then
			ent = ply
		end
		if !IsValid(ent) or IsValid(ent) && !(ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot()) then return end
		local r = 255
		local g = 255
		local b = 255
		local a = 250
		local hpColor = Color(r,g,b)

		local FT = FrameTime()
		local HP = ent.GetHP && ent:GetHP() or ent:Health()
		local maxHP = ent:GetMaxHealth()
		local hpPer = math_Clamp(HP /maxHP,0,1)

		local dmgSplatter = ply.VJ_AVP_DamageSplatter or {}
		if #dmgSplatter > 0 then
			for id,data in ipairs(dmgSplatter) do
				if data.Pos == nil then
					data.Pos = {math.random(-50,50),math.random(-30,30)}
					data.MatID = data.MatID or math.random(1,4) +((ent.VJ_AVP_IsTech or ent:GetNW2Bool("AVP.IsTech",false)) && 4 or 0)
					data.Size = math.random(20,40)
					data.Ang = math.random(0,360)
				end
				if data.Remain == nil then
					data.Remain = CurTime()
				end
				local time = data.Remain -CurTime()
				local alpha = math_Clamp(time *255,0,255)
				if alpha <= 0 then
					table.remove(dmgSplatter,id)
					continue
				end
				DrawIcon(matHUD_Blood[data.MatID],data.Pos[1],data.Pos[2],data.Size,data.Size,255,255,255,alpha,data.Ang,true)
			end
		end

		local nameData = !ent:IsPlayer() && list.Get("NPC")[ent:GetClass()]
		DrawText((ent:IsPlayer() && ent:Nick() or (nameData && nameData.Name or "")),"VJFont_AVP_MarineSmall",25.5,-21.5)
		DrawIcon(matHUD_Block,34,-19.2,17,2,r,g,b,a)
		DrawIcon_UV(matHUD_BlockFilling,26,-19.75,hpPer *16,1.1,{0,0,hpPer,1},r,g,b,a)

		local stimCount = ent.GetStimCount && ent:GetStimCount() or 0
		local maxStimCount = 3
		local stimPos = 35
		local stimX = 0
		for i = 1,maxStimCount do
			stimX = stimX +2.2
			stimsA[i] = Lerp(FT *4,stimsA[i],stimCount < i && 50 or a)
			DrawIcon(matHUD_Stims,stimPos +stimX,-17,2,2,r,g,b,stimsA[i])
		end

		local flareEnt = ent:IsPlayer() && ent:GetNW2Entity("AVP.Flare") or (ent.GetFlare && ent:GetFlare() or false)
		-- flare = Lerp(FT *4,flare,((ent:IsPlayer() && ent:FlashlightIsOn() && a) or (ent.GetFlare && ent:GetFlare() or false) && a) or 50)
		flare = Lerp(FT *4,flare,IsValid(flareEnt) && a or 50)
		DrawIcon(matHUD_Flare,41.8,15,1.35,3.5,r,g,b,flare)
		DrawIcon(matHUD_Block,38.3,18.5,8,2.5,r,g,b,a)
		DrawIcon(matHUD_Block,38.3,21.8,8,2.5,r,g,b,a)
		DrawIcon(matHUD_Text,34.3,23.8,16,1,r,g,b,a)

		if ent:IsPlayer() then
			local survival = ent:GetNW2Entity("AVP_SurvivalEntity")
			if IsValid(survival) then
				local svHeight = -19.2
				local svWave = survival:GetWave() or 0
				local svWaveSpace = (string.len(svWave) -1) *0.8
				local svRemain = survival:GetKillsRemaining() or 0
				local svRemainSpace = (string.len(svRemain) -1) *0.8
				local svScore = math_Clamp(ent:GetNW2Int("AVP_Score",0),0,99999)
				local svScoreSpace = (string.len(svScore) -1) *0.8

				DrawIcon(matHUD_Block,-39,svHeight,5,2,r,g,b,a)
				DrawText("WAVE","VJFont_AVP_MarineSmall",-36,svHeight -0.6)
				DrawText(svWave,"VJFont_AVP_MarineSmall",-37.6 -svWaveSpace,svHeight -0.6)
				svHeight = -16.8
				DrawIcon(matHUD_Block,-39,svHeight,5,2,r,g,b,a)
				DrawText("ALIENS REMAINING","VJFont_AVP_MarineSmall",-36,svHeight -0.6)
				DrawText(svRemain,"VJFont_AVP_MarineSmall",-37.6 -svRemainSpace,svHeight -0.6)
				svHeight = -14.4
				DrawIcon(matHUD_Block,-39,svHeight,5,2,r,g,b,a)
				DrawText("SCORE","VJFont_AVP_MarineSmall",-36,svHeight -0.6)
				DrawText(svScore,"VJFont_AVP_MarineSmall",-37.6 -svScoreSpace,svHeight -0.6)
			end
		end

		local curwep = ent:GetActiveWeapon()
		if IsValid(curwep) then
			local hasammo = true
			local ammo_not_use = false -- Does it use ammo? = true for things like gravity gun or physgun
			local pri_clip = curwep:Clip1() -- Remaining ammunition for the clip
			local pri_extra = ent:IsNPC() && curwep:GetMaxClip1() or ent:GetAmmoCount(curwep:GetPrimaryAmmoType()) -- Remaining primary fire ammunition (Reserve, not counting current clip!)
			local sec_ammo = ent:IsNPC() && curwep:GetMaxClip2() or ent:GetAmmoCount(curwep:GetSecondaryAmmoType()) -- Remaining secondary fire ammunition
			local ammo_pri = pri_clip.." / "..pri_extra
			local ammo_pri_c = Color(0, 255, 0, 150)
			local ammo_sec = sec_ammo
			local ammo_sec_c = Color(0, 255, 255, 150)
			local empty_blink = math.abs(math.sin(CurTime() * 4) * 255)
			local max_ammo = curwep:GetMaxClip1()

			if max_ammo == nil or max_ammo == 0 or max_ammo == -1 then max_ammo = false end
			if pri_clip <= 0 && pri_extra <= 0 then hasammo = false end

			if hasammo == true && pri_clip <= 0 then -- Mag is empty but has reserve
				ammo_pri = " --- / "..pri_extra
			end
			if pri_clip == -1 && curwep:GetSecondaryAmmoType() == -1 then -- Uses primary only with no ammo reserve, ex: "weapon_rpg" or "weapon_frag"
				ammo_pri = pri_extra
				ammo_sec = "---"
			end
			if curwep:GetPrimaryAmmoType() == -1 then -- Weapons that use secondary as primary, ex: "weapon_slam"
				ammo_pri = sec_ammo
				ammo_sec = "---"
			end
			if curwep:GetPrimaryAmmoType() == -1 && curwep:GetSecondaryAmmoType() == -1 then -- Doesn't use ammo
				ammo_not_use = true
				ammo_pri = " ---"
				ammo_sec = "---"
			elseif hasammo == false then -- Primary empty!
				ammo_pri = "0"
			end
			if curwep:GetSecondaryAmmoType() == -1 then -- Doesn't use secondary ammo
				ammo_sec = "---"
			elseif sec_ammo == 0 then -- Secondary Empty!
				ammo_sec = "0"
			end
			local ammo_pri_len = string.len(ammo_pri)
			local ammo_pri_pos = 110
			if ammo_pri_len > 1 then
				ammo_pri_pos = ammo_pri_pos + (6.5*ammo_pri_len)
			end

			DrawText(ammo_pri,"VJFont_AVP_MarineSmall",34.6,17.85)
			DrawText(ammo_sec,"VJFont_AVP_Marine",35,21.1)

			DrawText("Ammo. >","VJFont_AVP_Marine",28.6,17.8)
			if curwep:GetSecondaryAmmoType() == 9 then
				DrawText("Grenades. >","VJFont_AVP_Marine",26.45,21.1)
			else
				DrawText("Alt. >","VJFont_AVP_Marine",30.6,21.1)
			end
		end

		local radarPosX = -33.5
		local radarPosY = 16.6
		local radarPosW = 14.75
		local radarPosH = 8
		DrawIcon(matHUD_MotionTracker_Base,-33.5,21.6,14.75,2,r,g,b,a)
		DrawIcon(matHUD_MotionTracker_Half,radarPosX,radarPosY,radarPosW,radarPosH,r,g,b,a)
		-- DrawIcon_Rotated(matHUD_MotionTracker,radarPosX,radarPosY,radarPosW,radarPosH,r,g,b,a,ent:EyeAngles().x)

		local pingT = ent:GetNW2Float("AVP.MotionTracker.Ping",0)
		local plyPos = ent:GetPos()
		local plyForward = ent:GetAngles().y
		local pingTable = ent.VJ_AVP_PingTable or {}
		local maxDist = 2250
		local maxRenderSize = 7.5
		local radarCenterX = radarPosX
		local radarCenterY = radarPosY +radarPosH *0.5
		local blipSize = 3
		if pingTable && pingT > CurTime() then
			if ent:IsPlayer() && GetConVar("ai_ignoreplayers"):GetBool() then return end
			local time = pingT - CurTime()
			local alpha = math_Clamp(time *255,0,255)

			DrawIcon(matHUD_MotionTracker_Friendly,radarCenterX,radarCenterY,blipSize,blipSize,0,210,255,alpha)

			if !checkedPingPositions then
				checkedPings = {}
				local lastDist = 999999
				for _, v in pairs(pingTable) do
					if !IsValid(v) then continue end
					local ang, dist = CalcRelativePosition(ent,v:GetPos(),maxDist)
					local blipX = radarCenterX +(maxRenderSize *dist *math.cos(math.rad(ang)))
					local blipY = radarCenterY +(maxRenderSize *dist *math.sin(math.rad(ang)))
					if blipY > radarCenterY then
						blipY = radarCenterY
					end

					local realDist = v:GetPos():Distance(ent:GetPos())
					if realDist < lastDist then
						lastDist = realDist
						closestPing = realDist
					end

					table.insert(checkedPings,{v,blipX,blipY,(v.VJ_AVP_Xenomorph_Matriarch && 8 or v.VJ_AVP_Xenomorph_Queen && 5) or 3})
					-- DrawIcon(matHUD_MotionTracker_Enemy,blipX,blipY,blipSize,blipSize,r,g,b,alpha)
				end
				checkedPingPositions = true
			else
				for _, v in pairs(checkedPings) do
					if !IsValid(v[1]) then continue end
					DrawIcon(matHUD_MotionTracker_Enemy,v[2],v[3],v[4],v[4],r,g,b,alpha)
				end
			end
			local scanY = radarCenterY -0.5 *(8 *(1 -time))
			DrawIcon(matHUD_MotionTracker_Scan,radarCenterX,scanY,14.75 *(1 -time),8 *(1 -time),r,g,b,alpha)
		else
			checkedPingPositions = false
			closestPing = 0
		end

		if closestPing != 0 then
			local text = math.Round((closestPing /16) /3.281,1) .. "M"
			local spacing = string.len(text) *0.24
			DrawText(text,"VJFont_AVP_MarinePing",radarCenterX -spacing,radarCenterY)
		end
	end)
	
	local render_GetLightColor = render.GetLightColor
	net.Receive("VJ_AVP_Marine_Client",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()
		local cont = net.ReadEntity()
		local ply = cont
	end)
end