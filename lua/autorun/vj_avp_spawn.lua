/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "Aliens vs Predator SNPCs"
local AddonName = "Aliens vs Predator"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_avp_spawn.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "Aliens vs Predator"
	local vCat_M = "Aliens vs Predator - Humans"
	local vCat_P = "Aliens vs Predator - Predators"
	local vCat_A = "Aliens vs Predator - Xenomorphs"
	VJ.AddCategoryInfo(vCat_M,{Icon = "vj_icons/avp.png"})
	VJ.AddCategoryInfo(vCat_P,{Icon = "vj_icons/avp.png"})
	VJ.AddCategoryInfo(vCat_A,{Icon = "vj_icons/avp.png"})
	
	VJ.AddNPC("Xenomorph Chestburster","npc_vj_avp_xeno_chestburster",vCat_A)
	VJ.AddNPC("Xenomorph Facehugger","npc_vj_avp_xeno_facehugger",vCat_A)
	VJ.AddNPC("Xenomorph Royal Facehugger","npc_vj_avp_xeno_facehugger_queen",vCat_A)
	VJ.AddNPC("Xenomorph Queen","npc_vj_avp_xeno_queen",vCat_A)
	VJ.AddNPC("Xenomorph Warrior","npc_vj_avp_xeno_warrior",vCat_A)
	VJ.AddNPC("Xenomorph Drone","npc_vj_avp_xeno_drone",vCat_A)
	VJ.AddNPC("Xenomorph Runner","npc_vj_avp_xeno_jungle",vCat_A)
	VJ.AddNPC("Xenomorph Warrior Ridged","npc_vj_avp_xeno_ridged",vCat_A)
	VJ.AddNPC("Xenomorph Praetorian","npc_vj_avp_xeno_praetorian",vCat_A)
	VJ.AddNPC("The Abomination","npc_vj_avp_xeno_predalien",vCat_A)
	VJ.AddNPC("Nethead","npc_vj_avp_xeno_nethead",vCat_A)
	VJ.AddNPC("Specimen Six","npc_vj_avp_xeno_six",vCat_A)
	VJ.AddNPC("The Matriarch","npc_vj_avp_xeno_matriarch",vCat_A)

	VJ.AddNPC("Young Blood","npc_vj_avp_pred",vCat_P)
	VJ.AddNPC("Dark","npc_vj_avp_pred_dark",vCat_P)
	VJ.AddNPC("Claw","npc_vj_avp_pred_claw",vCat_P)
	VJ.AddNPC("Stalker","npc_vj_avp_pred_stalker",vCat_P)
	VJ.AddNPC("Hunter","npc_vj_avp_pred_hunter",vCat_P)
	VJ.AddNPC("Wolf","npc_vj_avp_pred_wolf",vCat_P)
	VJ.AddNPC("Spartan","npc_vj_avp_pred_spartan",vCat_P)
	VJ.AddNPC("Lord","npc_vj_avp_pred_lord",vCat_P)
	VJ.AddNPC("Serpent Hunter","npc_vj_avp_pred_alien",vCat_P)

	VJ.AddNPC("Sentry Gun","npc_vj_avp_hum_sentrygun",vCat_M)
	VJ.AddNPC_HUMAN("Marine Base (Male)","npc_vj_avp_hum_male",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Marine Base (Female)","npc_vj_avp_hum_female",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Van Zandt","npc_vj_avp_hum_van",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Connor","npc_vj_avp_hum_connor",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Franco","npc_vj_avp_hum_franco",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Gibson","npc_vj_avp_hum_gibson",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Johnson","npc_vj_avp_hum_johnson",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Rookie","npc_vj_avp_hum_rookie",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Kaneko","npc_vj_avp_hum_kaneko",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Colonist","npc_vj_avp_hum_colonist",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Security Guard","npc_vj_avp_hum_secuirty",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Teresa Aquila","npc_vj_avp_hum_tequila",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Roper","npc_vj_avp_hum_roper",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Combat Android","npc_vj_avp_hum_android",{"weapon_vj_avp_pistol"},vCat_M)
	VJ.AddNPC_HUMAN("Weyland Yutani","npc_vj_avp_hum_weyland",{"weapon_vj_avp_pistol"},vCat_M)

	VJ.AddParticle("particles/vj_avp_blood.pcf",{
		"vj_avp_blood_predator",
		"vj_avp_blood_xeno",
	})
	VJ.AddParticle("particles/vj_avp_predator.pcf",{})
	VJ.AddParticle("particles/vj_avp_predator_hud.pcf",{
		"vj_avp_predator_hud_landing",
		"vj_avp_predator_hud_landing_heat",
		"vj_avp_predator_hud_landing_xeno",
		"vj_avp_predator_hud_landing_mech",
	})

	local function AddWep(name,class)
		VJ.AddNPCWeapon("VJ_" .. name, class, vCat)
		VJ.AddWeapon(name, class, false, vCat)
	end

	AddWep("VP78 Pistol","weapon_vj_avp_pistol")

	KEY_MOUSESCROLL_UP = 112
	KEY_MOUSESCROLL_DOWN = 113
	VJ_AVP_HALOS = {}
	VJ_AVP_HALOS.Xenomorphs = {}
	VJ_AVP_HALOS.Predators = {}
	VJ_AVP_HALOS.Tech = {}
	VJ_AVP_HALOS.Other = {}

	VJ_AVP_XENOS = {}

	local NPC = FindMetaTable("NPC")
	
	function NPC:Acid(pos,scale,dist,dmg)
		-- util.VJ_SphereDamage(self,self,pos,dist,dmg,DMG_ACID,false,true)
	end

	if CLIENT then
		local P_LerpVec = Vector(0,0,0)
		local P_LerpAng = Angle(0,0,0)
		hook.Add("CalcView","VJ_AVP_TrophyKillView",function(ply,pos,angles,fov)
			local canView = ply:GetNWBool("VJ_AVP_TrophyKill")
			local viewVec = ply:GetNWVector("VJ_AVP_TrophyKillVector")
			local viewBone = ply:GetNWInt("VJ_AVP_TrophyKillBone")
			local viewEntity = ply:GetNWEntity("VJ_AVP_TrophyKillEntity")
			if canView then
				if IsValid(ply:GetViewEntity()) && ply:GetViewEntity():GetClass() == "gmod_cameraprop" then
					return
				end
				local forward,right,up = viewVec[1],viewVec[2],viewVec[3]
				local bpos,bang = viewEntity:GetBonePosition(viewBone)
				local function Position(ply,origin,angles,dist,cPos)
					local tr = util.TraceHull({
						start = bpos +viewEntity:GetForward() *forward +viewEntity:GetRight() *right +viewEntity:GetUp() *up,
						endpos = bpos,
						mask = MASK_SHOT,
						filter = player.GetAll(),
						mins = Vector(-8,-8,-8),
						maxs = Vector(8,8,8)
					})
					return tr.HitPos +tr.HitNormal *5
				end

				pos = Position(ply,viewVec,angles,40,viewVec)
				P_LerpVec = LerpVector(FrameTime() *15,P_LerpVec,pos)
				P_LerpAng = LerpAngle(FrameTime() *15,P_LerpAng,ply:EyeAngles())

				local view = {}
				view.origin = P_LerpVec
				view.angles = P_LerpAng
				view.fov = fov
				return view
			end
		end)
	end
	if SERVER then
		function VJ_AVP_QueenExists(self)
			for _,v in ipairs(VJ_AVP_XENOS) do
				if v.VJ_AVP_Xenomorph_Queen && v != self then
					return true
				end
			end
			return false
		end

		function VJ_AVP_MatriarchExists(self)
			for _,v in ipairs(VJ_AVP_XENOS) do
				if v.VJ_AVP_Xenomorph_Matriarch && v != self then
					return true
				end
			end
			return false
		end

		local specialDmgEnts = {npc_strider=true, npc_combinedropship=true, npc_combinegunship=true, npc_helicopter=true} -- Entities that need special code to be damaged
		local math_clamp = math.Clamp
		local math_round = math.Round
		local math_floor = math.floor
		local math_clamp = math.Clamp
		--
		function VJ.AVP_ApplyRadiusDamage(attacker, inflictor, startPos, dmgRadius, dmgMax, dmgType, ignoreInnocents, realisticRadius, extraOptions, customFunc)
			startPos = startPos or attacker:GetPos()
			dmgRadius = dmgRadius or 150
			dmgMax = dmgMax or 15
			extraOptions = extraOptions or {}
				local disableVisibilityCheck = extraOptions.DisableVisibilityCheck or false
				local baseForce = extraOptions.Force or false
			local dmgFinal = dmgMax
			local hitEnts = {}
			for _, v in ipairs((isnumber(extraOptions.UseConeDegree) and VJ.FindInCone(startPos, extraOptions.UseConeDirection or attacker:GetForward(), dmgRadius, extraOptions.UseConeDegree or 90, {AllEntities=true})) or ents.FindInSphere(startPos, dmgRadius)) do
				if (v.IsVJBaseBullseye && v.VJ_IsBeingControlled) or v.VJTag_IsControllingNPC then continue end -- Don't damage bulleyes used by the NPC controller OR entities that are controlling others (Usually players)
				local nearestPos = v:NearestPoint(startPos) -- From the enemy position to the given position
				if realisticRadius != false then -- Decrease damage from the nearest point all the way to the enemy point then clamp it!
					dmgFinal = math_clamp(dmgFinal * ((dmgRadius - startPos:Distance(nearestPos)) + 150) / dmgRadius, dmgMax / 2, dmgFinal)
				end
				
				if (disableVisibilityCheck == false && (v:VisibleVec(startPos) or v:Visible(attacker))) or (disableVisibilityCheck == true) then
					local function DoDamageCode()
						local shouldContinue = true
						if (customFunc) then
							shouldContinue = customFunc(v)
						end
						if shouldContinue == false then return end
						hitEnts[#hitEnts + 1] = v
						if specialDmgEnts[v:GetClass()] then
							v:TakeDamage(dmgFinal, attacker, inflictor)
						else
							local dmgInfo = DamageInfo()
							dmgInfo:SetDamage(dmgFinal)
							dmgInfo:SetAttacker(attacker)
							dmgInfo:SetInflictor(inflictor)
							dmgInfo:SetDamageType(dmgType or DMG_BLAST)
							dmgInfo:SetDamagePosition(nearestPos)
							if baseForce != false then
								local force = baseForce
								local forceUp = extraOptions.UpForce or false
								if VJ.IsProp(v) or v:GetClass() == "prop_ragdoll" then
									local phys = v:GetPhysicsObject()
									if IsValid(phys) then
										if forceUp == false then forceUp = force / 9.4 end
										//v:SetVelocity(v:GetUp()*100000)
										if v:GetClass() == "prop_ragdoll" then force = force * 1.5 end
										phys:ApplyForceCenter(((v:GetPos() + v:OBBCenter() + v:GetUp() * forceUp) - startPos) * force) //+attacker:GetForward()*vForcePropPhysics
									end
								else
									force = force * 1.2
									if forceUp == false then forceUp = force end
									dmgInfo:SetDamageForce(((v:GetPos() + v:OBBCenter() + v:GetUp() * forceUp) - startPos) * force)
								end
							end
							VJ.DamageSpecialEnts(attacker, v, dmgInfo)
							v:TakeDamageInfo(dmgInfo)
						end
					end
					-- Self
					if v:EntIndex() == attacker:EntIndex() then
						if extraOptions.DamageAttacker then DoDamageCode() end -- If it can't self hit, then skip
					-- Other entities
					elseif (ignoreInnocents == false) or (!v:IsNPC() && !v:IsPlayer()) or (v:IsNPC() && v:GetClass() != attacker:GetClass() && v:Health() > 0 && (attacker:IsPlayer() or (attacker:IsNPC() && attacker:Disposition(v) != D_LI))) or (v:IsPlayer() && v:Alive() && (attacker:IsPlayer() or (!VJ_CVAR_IGNOREPLAYERS && !v:IsFlagSet(FL_NOTARGET)))) then
						DoDamageCode()
					end
				end
			end
			return hitEnts
		end

		local table_insert = table.insert
		local table_remove = table.remove
		local noAccept = {npc_grenade_frag=true,npc_bullseye=true,obj_vj_bullseye=true}
		hook.Add("OnEntityCreated","VJ_AVP_Classify",function(ent)
			if ent:IsNPC() && ent.VJ_AVP_Xenomorph then
				table_insert(VJ_AVP_XENOS,ent)
			end
			if ent:IsNPC() && !noAccept[ent:GetClass()] && ent.VJ_AVP_IsTech == nil then
				timer.Simple(0,function()
					if IsValid(ent) then
						local class = ent:Classify()
						if !ent.IsVJBaseSNPC then
							if class == 10 or class == 9 or class == 13 or class == 16 or class == 25 or class == 26 or class == 24 or class == 15 then
								ent:SetNW2Bool("AVP.IsTech",true)
								ent.VJ_AVP_IsTech = true
							end
						else
							local isCombine = VJ.HasValue(ent.VJ_NPC_Class,"CLASS_COMBINE")
							local pos = ent:EyePos()
							local tr = util.TraceLine({
								start = pos +ent:GetForward() *-30,
								endpos = pos +ent:GetForward() *30,
								mask = MASK_SHOT,
								mins = Vector(-4,-4,-4),
								maxs = Vector(4,4,4)
							})
							local mat = tr.MatType
							if (isCombine && ent.IsVJBaseSNPC_Human && ent.VJTag_ID_Police != true) or (isCombine && !ent.IsVJBaseSNPC_Human) or ent.VJTag_ID_Vehicle == true or (mat == MAT_METAL or mat == MAT_GLASS) then
								ent:SetNW2Bool("AVP.IsTech",true)
								ent.VJ_AVP_IsTech = true
							end
						end
					end
				end)
			end
		end)

		hook.Add("EntityRemoved","VJ_AVP_XenoRemoveCheck",function(ent)
			if ent:IsNPC() && ent.VJ_AVP_Xenomorph then
				for k,v in ipairs(VJ_AVP_XENOS) do
					if v == ent then
						table_remove(VJ_AVP_XENOS,k)
					end
				end
			end
		end)
	end

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end