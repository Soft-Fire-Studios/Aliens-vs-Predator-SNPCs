AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.StartHealth = 100

ENT.VJC_Data = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, -35),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(6.5, 0, 4.5),
}

ENT.BloodColor = "Red"

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
ENT.FriendsWithAllPlayerAllies = true

ENT.HasMeleeAttack = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetBodyData()
	return self.ModelData
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GenderInit(gender)
	return "models/cpthazama/avp/marines/alex.mdl"
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPreInitialize()
	self.Gender = 1 // math.random(1,2)
	self.Model = self:GenderInit(self.Gender)

	if self.VJ_AVP_IsTech then
		self:SynthInitialize()
	elseif self.VJ_AVP_Colonist then
		self:ColonistInitialize()
	else
		self:MarineInitialize(self.Gender)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MarineInitialize(gender)
	local VO = self.VO or 1
	if gender == 1 then
		if VO == 1 then
			self.SoundTbl_LostEnemy = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/AGGRESSIVE_TO_ALERT_MAR01_10.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ALERT_TO_PASSIVE_MAR01_04.ogg",
			}
			self.SoundTbl_Alert = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_08.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ATTACKING_MAR01_09.ogg",
			}
			self.SoundTbl_Death = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/DEATH_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DEATH_MAR01_02.ogg",
			}
			self.SoundTbl_SeeBody = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISCOVER_BODY_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISCOVER_BODY_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISCOVER_BODY_MAR01_03.ogg",
			}
			self.SoundTbl_DistractionSuccess = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISTRACTION_SUCCESS_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISTRACTION_SUCCESS_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/DISTRACTION_SUCCESS_MAR01_03.ogg",
			}
			self.SoundTbl_Suppressing = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/ENTERING_COVER_MAR01_05.ogg",
			}
			self.SoundTbl_OnReceiveOrder = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FLANKING_MAR01_05.ogg",
			}
			self.SoundTbl_DamageByPlayer = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/FRIENDLY_FIRE_MAR01_06.ogg",
			}
			self.SoundTbl_InvestigateComplete = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_ARRIVAL_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_ARRIVAL_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/INVESTIGATE_END_MAR01_04.ogg",
			}
			self.SoundTbl_OnKilledEnemy = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/KILLED_THREAT_MAR01_05.ogg",
			}
			self.SoundTbl_MotionTracker_Far = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_FAR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_FAR_MAR01_02.ogg",
			}
			self.SoundTbl_MotionTracker_Mid = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_MID_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_MID_MAR01_02.ogg",
			}
			self.SoundTbl_MotionTracker_Close = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_NEAR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/MOTION_TRACK_NEAR_MAR01_02.ogg",
			}
			self.SoundTbl_Pain = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/PAIN_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/PAIN_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mm01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mar01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/pain_mar01_04.ogg",
			}
			self.SoundTbl_Investigate = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/PASSIVE_TO_ALERT_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/PASSIVE_TO_ALERT_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/PASSIVE_TO_ALERT_MAR01_03.ogg",
			}
			self.SoundTbl_WeaponReload = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/RELOADING_MAR01_05.ogg",
			}
			self.SoundTbl_Spot_XenoLarge = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_LARGE_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_LARGE_MAR01_02.ogg",
			}
			self.SoundTbl_Spot_Xeno = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_06.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_07.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ALIEN_MAR01_08.ogg",
			}
			self.SoundTbl_Spot_Android = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ANDROID_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_ANDROID_MAR01_02.ogg",
			}
			self.SoundTbl_Spot_PredatorCloaked = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_CLOAKED_PREDATOR_MAR01_05.ogg",
			}
			self.SoundTbl_Spot_Predator = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SPOTTED_PREDATOR_MAR01_04.ogg",
			}
			self.SoundTbl_AllyDeath_Xeno = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ALIEN_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ALIEN_MAR01_02.ogg",
			}
			self.SoundTbl_AllyDeath_Android = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ANDROID_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_ANDROID_MAR01_02.ogg",
			}
			self.SoundTbl_AllyDeath_Predator = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_PREDATOR_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_BY_PREDATOR_MAR01_02.ogg",
			}
			self.SoundTbl_AllyDeath = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SQUAD_DEATH_MAR01_05.ogg",
			}
			self.SoundTbl_Surprised = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_05.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/SURPRISE_MAR01_06.ogg",
			}
			self.SoundTbl_Alert_Horde = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/TARGETS_MANY_MAR01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/TARGETS_MANY_MAR01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/TARGETS_MANY_MAR01_03.ogg",
			}
			self.SoundTbl_Death = {
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mar01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mar01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_01.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_02.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_03.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_04.ogg",
				"cpthazama/avp/humans/vocals/Male_Marine_01/death_mm01_05.ogg",
			}
		end
	else

	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	self:VJ_ACT_PLAYACTIVITY("ohwn_oh_shit",true,false,true)
	if ent:IsNPC() then
		if ent.VJ_AVP_Xenomorph then
			self:PlaySoundSystem("Alert", ent.VJ_AVP_XenomorphLarge && self.SoundTbl_Spot_XenoLarge or self.SoundTbl_Spot_Xeno)
			return
		elseif ent.VJ_AVP_IsTech then
			self:PlaySoundSystem("Alert", self.SoundTbl_Spot_Android)
			return
		elseif ent.VJ_AVP_Predator then
			self:PlaySoundSystem("Alert", ent:GetCloaked() && self.SoundTbl_Spot_PredatorCloaked or self.SoundTbl_Spot_Predator)
			return
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local toSeq = VJ.SequenceToActivity
--
function ENT:CustomOnInitialize()
	if self.OnInit then
		self:OnInit()
	end

	self.SprintT = 0
	self.NextSprintT = 0
	self.Moveset = 0
	self.Ping_ClosestDist = 0
	self.Ping_NextPingT = CurTime() +1

	self.AnimTbl_ScaredBehaviorMovement = {toSeq(self,"nwn_Panic_run_fwd_look_fwd")}

	local att = self:LookupAttachment("flashlight")
	if att > 0 then
		local envLight = ents.Create("env_projectedtexture")
		envLight:SetLocalPos(self:GetPos())
		envLight:SetLocalAngles(self:GetAngles())
		envLight:SetKeyValue("lightcolor","255 247 206")
		envLight:SetKeyValue("lightfov","40")
		envLight:SetKeyValue("farz","1000")
		envLight:SetKeyValue("nearz","10")
		envLight:SetKeyValue("shadowquality","1")
		envLight:Input("SpotlightTexture",NULL,NULL,"effects/flashlight001")
		envLight:SetOwner(self)
		envLight:SetParent(self)
		envLight:Spawn()
		envLight:Fire("setparentattachment","flashlight")
		self:DeleteOnRemove(envLight)

        local spotlight = ents.Create("beam_spotlight")
        spotlight:SetPos(self:GetPos())
        spotlight:SetAngles(self:GetAngles())
        spotlight:SetKeyValue("spotlightlength",700)
        spotlight:SetKeyValue("spotlightwidth",30)
		spotlight:SetKeyValue("spawnflags","2")
        spotlight:Fire("Color","255 247 206")
        spotlight:SetParent(self)
        spotlight:Spawn()
        spotlight:Activate()
		spotlight:Fire("setparentattachment","flashlight")
        spotlight:Fire("lighton")
		spotlight:AddEffects(EF_PARENT_ANIMATES)
        self:DeleteOnRemove(spotlight)

		local glow1 = ents.Create("env_sprite")
		glow1:SetKeyValue("model","sprites/light_ignorez.vmt")
		glow1:SetKeyValue("scale","0.2")
		glow1:SetKeyValue("rendermode","9")
		glow1:SetKeyValue("rendercolor","255 247 206")
		glow1:SetKeyValue("spawnflags","0.1")
		glow1:SetParent(self)
		glow1:SetOwner(self)
		glow1:Fire("SetParentAttachment","flashlight",0)
		glow1:Spawn()
		self:DeleteOnRemove(glow1)

		-- local glowLight = ents.Create("light_dynamic")
		-- glowLight:SetKeyValue("brightness","1.4")
		-- glowLight:SetKeyValue("distance","70")
		-- glowLight:SetLocalPos(self:GetPos() +self:OBBCenter())
		-- glowLight:SetLocalAngles(self:GetAngles())
		-- glowLight:Fire("Color", "255 247 206")
		-- glowLight:SetParent(self)
		-- glowLight:SetOwner(self)
		-- glowLight:Spawn()
		-- glowLight:Fire("TurnOn","",0)
		-- glowLight:Fire("SetParentAttachment","flashlight",0)
		-- self:DeleteOnRemove(glowLight)

		-- self.Light = envLight
		-- self.LightGlow = glow1
		-- self.LightGlowDynamic = glowLight
	end

	hook.Add("PlayerButtonDown", self, function(self, ply, button)
		if ply.VJTag_IsControllingNPC == true && IsValid(ply.VJ_TheControllerEntity) then
			local cent = ply.VJ_TheControllerEntity
            if cent.VJCE_NPC == self then
                cent.VJCE_NPC:OnKeyPressed(ply,button)
            end
        end
    end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply,controlEnt)
	controlEnt.VJC_Player_DrawHUD = false

	function controlEnt:CustomOnThink()
		self.VJC_NPC_CanTurn = self.VJC_Camera_Mode == 2
		self.VJC_BullseyeTracking = self.VJC_Camera_Mode == 2
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnKeyPressed(ply,key)
    if key == KEY_E then
		local tr = util.TraceLine({
			start = self:EyePos(),
			endpos = self:EyePos() +ply:GetAimVector() *125,
			filter = {self,ply}
		})
		local ent = tr.Entity
		if tr.Hit && IsValid(ent) then
			ent:Fire("Use",nil,0,ply,self)
		end
    end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnSetupWeaponHoldTypeAnims(hType)
	//toSeq(self, "walkaimall1_ar2")
	self.WeaponAnimTranslations[ACT_COWER] 								= {toSeq(self, "nwa_Cower1"),toSeq(self, "nwa_stand_alert_PanicA"),toSeq(self, "nwa_panic_idle")}
	if hType == "pistol" then
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1] 					= toSeq(self, "ohwa_pistol_idle")
		self.WeaponAnimTranslations[ACT_GESTURE_RANGE_ATTACK1] 			= "vjges_ohwa_pistol_shoot"
		self.WeaponAnimTranslations[ACT_RANGE_ATTACK1_LOW] 				= toSeq(self, "OHWA_crouch_idle")
		self.WeaponAnimTranslations[ACT_RELOAD] 						= "vjges_ohwa_pistol_reload"
		self.WeaponAnimTranslations[ACT_RELOAD_LOW] 					= "vjges_ohwa_pistol_reload"
		self.WeaponAnimTranslations[ACT_COVER_LOW] 						= toSeq(self, "OHWA_crouch_idle")
		
		self.WeaponAnimTranslations[ACT_IDLE] 							= toSeq(self, "ohwn_pistol_idle")
		self.WeaponAnimTranslations[ACT_IDLE_ANGRY] 					= {toSeq(self, "ohwa_alert_idle_1"),toSeq(self, "ohwa_alert_panic"),toSeq(self, "ohwa_alert_watchfulA")}
		-- self.WeaponAnimTranslations[ACT_JUMP] 							= ACT_HL2MP_JUMP_PISTOL
		-- self.WeaponAnimTranslations[ACT_GLIDE] 							= ACT_HL2MP_JUMP_PISTOL
		-- self.WeaponAnimTranslations[ACT_LAND] 							= ACT_HL2MP_IDLE_PISTOL
		
		self.WeaponAnimTranslations[ACT_WALK] 							= toSeq(self, "ohwn_Walk")
		self.WeaponAnimTranslations[ACT_WALK_AIM] 						= toSeq(self, "OHWA_Walk")
		
		self.WeaponAnimTranslations[ACT_RUN] 							= toSeq(self, "ohwn_Run")
		self.WeaponAnimTranslations[ACT_RUN_AIM] 						= toSeq(self, "ohwa_Run_fwd_Look_fwd")
		self.WeaponAnimTranslations[ACT_SPRINT] 						= toSeq(self, "ohwn_sprint")
	end
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
local table_insert = table.insert
local math_abs = math.abs
local math_cos = math.cos
local math_rad = math.rad

local function FindEntitiesInConeAndRadius(self)
	local origin = self:GetPos()
	local radius = 1500
	local coneAngle = 360
	-- local coneAngle = 180
	local height = 1000
	local zPosition = origin.z
    local entities = ents.FindInSphere(origin, radius)
    local result = {}

    for _, ent in pairs(entities) do
		if ent == self then continue end
		if !(ent:IsNPC() or ent:IsPlayer() or VJ.IsProp(ent)) then continue end
		if (ent:IsNPC() or ent:IsPlayer()) && self:CheckRelationship(ent) == D_LI then continue end
		if ent:IsPlayer() && VJ_CVAR_IGNOREPLAYERS then continue end
		if (ent:IsNPC() && (ent:GetMoveVelocity():Length() > 0 && ent:GetMoveVelocity():Length() or ent:GetVelocity():Length()) or ent:GetVelocity():Length()) <= 0 then continue end
        local direction = (ent:GetPos() - origin):GetNormalized()
        local forward = self:GetForward()
        local dot = direction:Dot(forward)
        local deltaZ = math_abs(ent:GetPos().z - origin.z)

        if dot >= math_cos(math_rad(coneAngle / 2)) and deltaZ <= height then
            table_insert(result, ent)
        end
    end

    return result
end
--
function ENT:CustomOnThink()
	local curTime = CurTime()

	local cont = self.VJ_TheController
	if IsValid(cont) then
		local walk = cont:KeyDown(IN_WALK)
		local sprint = cont:KeyDown(IN_SPEED)
		if walk && self.Moveset != 1 then
			self.Moveset = 1
			self.AnimTbl_Walk = {ACT_WALK}
			self.AnimTbl_Run = {ACT_WALK}
			self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK_AIM}
			self.AnimTbl_ShootWhileMovingRun = {ACT_WALK_AIM}
		elseif !walk && self.Moveset != 2 then
			self.Moveset = 2
			self.AnimTbl_Walk = {ACT_RUN}
			self.AnimTbl_Run = {ACT_SPRINT}
			self.AnimTbl_ShootWhileMovingWalk = {ACT_RUN_AIM}
			self.AnimTbl_ShootWhileMovingRun = {ACT_RUN_AIM}
		elseif !walk && self.Moveset != 3 && curTime < self.NextSprintT then
			self.Moveset = 3
			self.AnimTbl_Walk = {ACT_RUN}
			self.AnimTbl_Run = {ACT_RUN}
			self.AnimTbl_ShootWhileMovingWalk = {ACT_RUN_AIM}
			self.AnimTbl_ShootWhileMovingRun = {ACT_RUN_AIM}
			sprint = false
		end
		self:SetSprinting(sprint)
	else
		if self.Moveset != 0 then
			self.Moveset = 0
			self.AnimTbl_Walk = {ACT_WALK}
			self.AnimTbl_Run = {ACT_RUN}
			self.AnimTbl_ShootWhileMovingWalk = {ACT_WALK_AIM}
			self.AnimTbl_ShootWhileMovingRun = {ACT_RUN_AIM}
			self:SetSprinting(false)
		end
	end
	if self:GetSprinting() then
		self.SprintT = self.SprintT +0.2
		if self.SprintT >= 4 then
			self.NextSprintT = curTime +3
		end
	else
		if self.SprintT > 0 then
			self.SprintT = self.SprintT -0.2
		end
	end

	if curTime > self.Ping_NextPingT then
		self.Ping_NextPingT = curTime +0.85
		local pingEnts = FindEntitiesInConeAndRadius(self)
		local closestEnt = NULL
		local closestDist = 0
		for _,v in pairs(pingEnts) do
			if IsValid(v) then
				local dist = self:GetPos():Distance(v:GetPos())
				if closestEnt == NULL or dist < closestDist then
					closestEnt = v
					closestDist = dist
				end
			end
		end
		if IsValid(closestEnt) then
			self.Ping_ClosestDist = closestDist
			self.Ping_ClosestEnt = closestEnt
			local perDist = (closestDist /1500)
			local sndPitch = 100
			if closestDist <= 100 then
				sndPitch = 140
			else
				sndPitch = 100 +((1 -perDist) *40)
			end
			VJ.EmitSound(self,"cpthazama/avp/shared/motion_tracker_bleep_stevie.ogg",55,sndPitch)
			if self.CanInvestigate && self.NextInvestigationMove < CurTime() then
				if !VJ.IsProp(closestEnt) then
					if self:Visible(closestEnt) then
						self:StopMoving()
						self:SetTarget(closestEnt)
						self:VJ_TASK_FACE_X("TASK_FACE_TARGET")
						self.NextInvestigationMove = CurTime() +0.3
					elseif self.IsFollowing == false && math.random(1,15) == 1 then
						self:SetLastPosition(closestEnt:GetPos())
						self:VJ_TASK_GOTO_LASTPOS("TASK_WALK_PATH")
						self.NextInvestigationMove = CurTime() +10
					end
					self:CustomOnInvestigate(v)
				end
				if math.random(1,6) == 1 then
					self:PlaySoundSystem("InvestigateSound",perDist > 0.8 && self.SoundTbl_MotionTracker_Far or perDist <= 0.8 && perDist > 0.4 && self.SoundTbl_MotionTracker_Mid or self.SoundTbl_MotionTracker_Close)
				end
			end
		else
			VJ.EmitSound(self,"cpthazama/avp/shared/motion_tracker_pulse_01.ogg",55)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled()
	if self:GetState() == VJ_STATE_NONE then
		for i = 1,self:GetBoneCount() -1 do
			if math.random(1,4) <= 3 then continue end
			local bone = self:GetBonePosition(i)
			if bone then
				local particle = ents.Create("info_particle_system")
				particle:SetKeyValue("effect_name", VJ.PICK(self.CustomBlood_Particle))
				particle:SetPos(bone +VectorRand() *15)
				particle:Spawn()
				particle:Activate()
				particle:Fire("Start")
				particle:Fire("Kill", "", 0.1)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if self.WhenRemoved then
		self:WhenRemoved()
	end

	-- if IsValid(self.Flashlight) then
	-- 	self.Flashlight:Fire("TurnOff","",0)
	-- 	self.Flashlight:Fire("Kill","",0)
	-- 	SafeRemoveEntity(self.Flashlight)
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnChangeActivity(newAct)
	//print(newAct)
	local funcCustom = self.CustomOnChangeActivity; if funcCustom then funcCustom(self, newAct) end
	if newAct == ACT_TURN_LEFT or newAct == ACT_TURN_RIGHT then
		self.NextIdleStandTime = CurTime() + VJ.AnimDuration(self, self:GetSequenceName(self:GetSequence()))
		//self.NextIdleStandTime = CurTime() + 1.2
	end
end