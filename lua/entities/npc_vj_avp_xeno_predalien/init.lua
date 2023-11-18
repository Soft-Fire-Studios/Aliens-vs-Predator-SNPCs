AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/predalien.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 1750
ENT.VJ_IsHugeMonster = true
ENT.HullType = HULL_LARGE
ENT.FindEnemy_CanSeeThroughWalls = true
ENT.HasHealthRegeneration = true -- Can the SNPC regenerate its health?
ENT.HealthRegenerationAmount = 1 -- How much should the health increase after every delay?
ENT.HealthRegenerationDelay = VJ_Set(1,1) -- How much time until the health increases
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.VJ_NPC_Class = {"CLASS_XENOMORPH"} -- NPCs with the same class with be allied to each other

ENT.MeleeAttackDamage = 45
ENT.MeleeAttackDamageDistance = 105
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackAnimationAllowOtherTasks = true
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events

ENT.VJC_Data = {
    CameraMode = 2, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
    ThirdP_Offset = Vector(0, 0, -35), -- The offset for the controller when the camera is in third person
    FirstP_Bone = "Bip01 Head", -- If left empty, the base will attempt to calculate a position for first person
    FirstP_Offset = Vector(10, 0, 3), -- The offset for the controller when the camera is in first person
}

ENT.GeneralSoundPitch1 = 100

ENT.SoundTbl_FootStep = {
	"cpthazama/avp/xeno/queen/alien_queen_footstep_01.wav",
	"cpthazama/avp/xeno/queen/alien_queen_footstep_02.wav",
	"cpthazama/avp/xeno/queen/alien_queen_footstep_03.wav",
}
ENT.SoundTbl_Alert = {
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_01.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_02.wav",
}
ENT.SoundTbl_BeforeMeleeAttack = {
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_01.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_02.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_03.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_04.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_05.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_taunt_06.wav",
}
ENT.SoundTbl_Pain = {
	"cpthazama/avp/xeno/praetorian/praetorian_pain_01.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_02.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_04.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_05.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_06.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_07.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_08.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_09.wav",
	"cpthazama/avp/xeno/praetorian/praetorian_pain_10.wav",
}
ENT.SoundTbl_Death = {
	"cpthazama/avp/xeno/predalien/predalien_death_scream_01.wav"
}
ENT.HasSoundTrack = true
ENT.SoundTbl_SoundTrack = {
	"cpthazama/avp/xeno/theme_abomination.wav"
}

util.AddNetworkString("VJ_AVP_Xeno_Client")
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply)
    net.Start("VJ_AVP_Xeno_Client")
		net.WriteBool(false)
		net.WriteEntity(self)
		net.WriteEntity(ply)
    net.Send(ply)

	function self.VJ_TheControllerEntity:CustomOnStopControlling()
		net.Start("VJ_AVP_Xeno_Client")
			net.WriteBool(true)
			net.WriteEntity(self)
			net.WriteEntity(ply)
		net.Send(ply)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Breathe()
	if CurTime() > self.NextBreathT then
		local snd = "cpthazama/avp/xeno/queen/alien_queen_breathe_in_0" .. math.random(1,3) .. ".wav"
		local sndB = "cpthazama/avp/xeno/queen/alien_queen_breathe_out_0" .. math.random(1,3) .. ".wav"
		VJ_CreateSound(self,snd,62)
		timer.Simple(SoundDuration(snd) +0.15,function()
			if IsValid(self) then
				VJ_CreateSound(self,sndB,62)
			end
		end)
		self.NextBreathT = CurTime() +SoundDuration(snd) +SoundDuration(sndB) +0.3
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	-- self:SetCollisionBounds(Vector(16,16,70),Vector(-16,-16,0))
	-- for i = 1,11 do
		-- self:ManipulateBoneJiggle(78 +i,1)
	-- end
	self.NextBreathT = CurTime() +0.1
	self.NextPoundAttackT = CurTime() +math.Rand(5,15)
	self.NextJumpT = CurTime() +0.1
	self.JumpStartT = nil
	self.InJump = false
	self.GrabbedEntity = NULL
	if GetConVar("vj_avp_bosstheme_a"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/The Unstoppable.mp3"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack()
	local ply = self.VJ_TheController
	if IsValid(ply) then
		if ply:KeyDown(IN_ATTACK2) then
			if !self:BusyWithActivity() && CurTime() > self.NextPoundAttackT then
				self:VJ_ACT_PLAYACTIVITY("pound_ground",true,false,false)
				self.NextPoundAttackT = CurTime() +math.Rand(8,12)
			end
		end
		return
	end
	local dist = self:GetEnemy():GetPos():Distance(self:GetPos())
	if !self:BusyWithActivity() && self.HasMeleeAttack && CurTime() > self.NextPoundAttackT && math.random(1,10) == 1 && dist > 350 && dist <= 2000 then
		self:VJ_ACT_PLAYACTIVITY("pound_ground",true,false,false)
		self.NextPoundAttackT = CurTime() +math.Rand(8,25)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeStartTimer()
	local type = VJ_PICK({"left","right"})
	local gesture = self:AddGestureSequence(self:LookupSequence("swipe_" .. type .. "_start"))
	self:SetLayerPriority(gesture,1)
	self:SetLayerPlaybackRate(gesture,0.5)
	local t = VJ_GetSequenceDuration(self,"swipe_" .. type) +VJ_GetSequenceDuration(self,"swipe_" .. type .. "_start")
	self.NextAnyAttackTime_Melee = t
	timer.Simple(VJ_GetSequenceDuration(self,"swipe_" .. type .. "_start"),function()
		if IsValid(self) then
			local gesture = self:AddGestureSequence(self:LookupSequence("swipe_" .. type))
			self:SetLayerPriority(gesture,1)
			self:SetLayerPlaybackRate(gesture,0.5)
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "tear_body" then
		local ent = self.GrabbedEntity
		if IsValid(ent) && ent:IsNPC() then
			ent:TakeDamage(999999999,self,self)
			ent:SetNWBool("VJ_AVP_TrophyKill",false)
		end
	end
	if key == "step" then
		self:FootStepSoundCode()
		util.ScreenShake(self:GetPos(),10,100,0.125,400)
	end
	if key == "pound" then
		VJ_CreateSound(self,"cpthazama/avp/xeno/praetorian/praetorian_hit_wall_01.wav",120)
		util.ScreenShake(self:GetPos(),16,100,3.5,1800)
		for _,v in pairs(ents.FindInSphere(self:GetPos(),2000)) do
			if v != self && IsValid(v:GetPhysicsObject()) && v:IsOnGround() then
				v:SetGroundEntity(NULL)
				v:SetVelocity(v:GetUp() *math.random(250,350))
				if v:IsPlayer() && IsValid(v:GetActiveWeapon()) then
					v:DropWeapon(v:GetActiveWeapon())
				end
				if (self.VJ_IsBeingControlled == true && self.VJ_TheControllerBullseye == v) or (v:IsPlayer() && v.IsControlingNPC == true) then continue end
				if v:GetClass() != self:GetClass() && (((v:IsNPC() or (v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0)) && self:Disposition(v) != D_LI) or VJ_IsProp(v) == true or v:GetClass() == "func_breakable_surf" or self.EntitiesToDestroyClass[v:GetClass()] or v.VJ_AddEntityToSNPCAttackList == true) then
					v:TakeDamage(10,self,self)
				end
			end
		end
	end
	if key == "swipe" then
		self:MeleeAttackCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Gibs()
	local bloodeffect = EffectData()
	bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
	bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
	bloodeffect:SetScale(300)
	util.Effect("VJ_Blood1",bloodeffect)

	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Small")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:Breathe()
	self:SetEnemyCS(self:GetEnemy())
	local enemy = self:GetEnemy()
	if IsValid(self.GrabbedEntity) then
		local ent = self.GrabbedEntity
		local pos,ang = self:GetBonePosition(self:LookupBone("Bip01 Spine1"))
		
		if ent:IsNPC() then
			ent:SetPos(pos +self:GetForward() *75)
		end
	end
	if IsValid(enemy) then
		local dist = enemy:GetPos():Distance(self:GetPos())
		local npc = enemy:IsNPC()
		if dist <= 125 && !self.MeleeAttacking && ((enemy:IsNPC() && enemy:GetHullType() == HULL_HUMAN && (enemy:Health() <= enemy:GetMaxHealth() /3)) or enemy:IsPlayer()) then
			if math.random(1,4) == 1 && !IsValid(self.GrabbedEntity) && self:GetState() != VJ_STATE_ONLY_ANIMATION then
				self:SetState(VJ_STATE_ONLY_ANIMATION)
				self:StopMoving()
				self:VJ_ACT_PLAYACTIVITY("grab_lift",true,false,true)
				self.HasMeleeAttack = false
				local t1 = VJ_GetSequenceDuration(self,"grab_lift")
				local t2 = VJ_GetSequenceDuration(self,"grab_kill")
				local t = t1 +t2
				self.GrabbedEntity = enemy
				timer.Simple(t1,function()
					if IsValid(self) then
						self:VJ_ACT_PLAYACTIVITY("grab_kill",true,false,true)
					end
				end)
				if npc then
					for i = 1,t *10 do
						timer.Simple(i *0.1,function()
							if IsValid(enemy) then
								enemy:StopMoving()
								enemy:ClearSchedule()
								enemy:ClearGoal()
							end
						end)
					end
				else
					local pos,ang = self:GetBonePosition(self:LookupBone("Bip01 Head"))
					enemy:SetEyeAngles((self:GetPos() +self:OBBCenter() -enemy:EyePos()):Angle())
					enemy:Freeze(true)
					enemy:SetNWBool("VJ_AVP_TrophyKill",true)
					enemy:SetNWEntity("VJ_AVP_TrophyKillEntity",self)
					local forward,right,up = 50,0,15
					enemy:SetNWVector("VJ_AVP_TrophyKillVector",Vector(forward,right,up))
					enemy:SetNWInt("VJ_AVP_TrophyKillBone",self:LookupBone("Bip01 Head"))
					timer.Simple(t,function()
						if IsValid(enemy) then
							enemy:Freeze(false)
							enemy:SetNWBool("VJ_AVP_TrophyKill",false)
							if IsValid(self) then enemy:TakeDamage(999999999,self,self) end
						end
					end)
				end
				timer.Simple(t,function()
					if IsValid(self) then
						self:SetState()
						self.GrabbedEntity = NULL
						self.HasMeleeAttack = true
					end
				end)
			end
		end
	end
	-- if self.InJump then
		-- if CurTime() -self.JumpStartT >= 0.6 then
			-- self:VJ_ACT_PLAYACTIVITY(ACT_GLIDE,true,false,true)
			-- local pos = self:GetPos()
			-- local tr = util.TraceHull({
				-- start = pos,
				-- endpos = pos +Vector(0,0,-15),
				-- filter = self,
				-- mins = self:OBBMins(),
				-- maxs = self:OBBMaxs()
			-- })
			-- if tr.Hit then
				-- self:VJ_ACT_PLAYACTIVITY(ACT_LAND,true,false,false)
				-- self.JumpStartT = nil
				-- self.InJump = false
				-- timer.Simple(VJ_GetSequenceDuration(self,ACT_LAND),function()
					-- if IsValid(self) then
						-- self:StartEngineTask(GetTaskList("TASK_RESET_ACTIVITY"),0)
						-- self:DoIdleAnimation(2)
						-- self:SetState()
						-- self.NextJumpT = CurTime() +2
						-- self.NextPoundAttackT = CurTime() +math.Rand(5,15)
					-- end
				-- end)
			-- end
		-- end
	-- end
	-- local ply = self.VJ_TheController
	-- if IsValid(ply) then
		-- if ply:KeyDown(IN_JUMP) && !self.InJump && CurTime() > self.NextJumpT then
			-- local gettr = util.GetPlayerTrace(ply)
			-- local tr = util.TraceLine({start = gettr.start, endpos = gettr.endpos, filter = {self,ply}})

			-- self:SetGroundEntity(NULL)
			-- self.InJump = true
			-- local ang = (tr.HitPos -self:GetPos()):Angle()
			-- self:SetVelocity(ang:Forward() *1000)
			-- self:SetState(VJ_STATE_ONLY_ANIMATION)
			-- self:VJ_ACT_PLAYACTIVITY(ACT_JUMP,true,false,true)
			-- self.JumpStartT = CurTime()
			-- self.NextPoundAttackT = CurTime() +999999999
			-- self.NextJumpT = CurTime() +999999999
		-- end
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_OnBleed(dmginfo,hitgroup)
	self:Acid(dmginfo:GetDamagePosition(),25,200,5)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled()
	self:Acid(self:GetPos(),25,375,25)
end