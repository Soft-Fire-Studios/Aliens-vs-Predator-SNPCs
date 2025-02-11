AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2023 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/avp/xeno/queen.mdl"} -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 3000
ENT.HullType = HULL_LARGE
ENT.VJ_ID_Boss = true

ENT.ControllerVars = {
    CameraMode = 2,
    ThirdP_Offset = Vector(0, 0, 20),
    FirstP_Bone = "head",
    FirstP_Offset = Vector(10, 0, 3),
    FirstP_ShrinkBone = false
}

ENT.AnimTbl_RangeAttack = {"vjges_Alien_Queen_spit"}
ENT.RangeAttackAnimationStopMovement = false

ENT.HasBreath = true

ENT.CanSpit = true
ENT.CanLeap = false
ENT.CanSetGroundAngle = false
ENT.AlwaysStand = true
ENT.CanBeKnockedDown = false
ENT.DisableFatalities = true
ENT.CanBlock = false

ENT.StandingBounds = Vector(23,23,112)
ENT.CrawlingBounds = Vector(23,23,112)
ENT.AnimTranslations = {
	[ACT_IDLE] = ACT_IDLE
}

local sdClawFlesh = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_03.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_04.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_flesh_05.ogg",
}
local sdClawMiss = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_03.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_04.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_05.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_06.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_07.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_08.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_09.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_swipe_10.ogg",
}
local sdMM = {
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_01.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_02.ogg",
	"cpthazama/avp/weapons/alien/claws/alien_claw_impact_mn_03.ogg",
}
local sdTail = {
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_01.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_02.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_heavyattack_tailstab_mn_03.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_01.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_02.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_03.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_04.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tail_impact_flesh_05.ogg",
}
local sdTailMiss = {
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_1.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_2.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_3.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_4.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_5.ogg",
	"cpthazama/avp/weapons/alien/tail/alien_tailswipe_tp_6.ogg",
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInit()
	if VJ_AVP_QueenExists(self) then
		self:Remove()
		if game.SinglePlayer() then
			Entity(1):ChatPrint("There can only be one Queen at a time!")
		else
			if IsValid(self:GetCreator()) then
				self:GetCreator():ChatPrint("There can only be one Queen at a time!")
			end
		end
		return
	end

	self.PropInteraction = true
	self.HasRangeAttack = true
	self.PropInteraction_MaxScale = 1.65
	self.FootStepSoundLevel = 75
	self.FootStepPitch1 = 60
	self.FootStepPitch2 = 70
	self.SoundTbl_FootSteps = {
		[MAT_CONCRETE] = {
			"cpthazama/avp/xeno/alien queen/alien_queen_footstep_01.ogg",
			"cpthazama/avp/xeno/alien queen/alien_queen_footstep_02.ogg",
			"cpthazama/avp/xeno/alien queen/alien_queen_footstep_03.ogg",
		}
	}
	self.SoundTbl_Alert = {
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_02.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_09.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_10.ogg",}
	self.SoundTbl_Attack = {
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_01.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_03.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_04.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_07.ogg",
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_08.ogg",
	}
	self.SoundTbl_CombatIdle = {}
	self.SoundTbl_BeforeRangeAttack = {}
	self.SoundTbl_RangeAttack = {}
	self.SoundTbl_Jump = {}
	self.SoundTbl_Pain = {
		"cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_06.ogg"
	}
	self.SoundTbl_Death = {
		"^cpthazama/avp/xeno/alien/vocals/queen death.ogg"
	}
	if GetConVar("vj_avp_bosstheme_a"):GetBool() then
		self.HasSoundTrack = true
		self.SoundTbl_SoundTrack = {"cpthazama/avp/music/boss/Full Tilt Rampage.mp3"}
	end

	self.FootData = {
		["lfoot"] = {Range=42,OnGround=true},
		["rfoot"] = {Range=42,OnGround=true}
	}
	
	self.AnimTbl_Fatalities = nil
	self.AnimTbl_FatalitiesResponse = nil

	self.CanFlinch = 1
	self.FlinchChance = 30
	self.NextFlinchTime = 8
	self.AnimTbl_Flinch = {"Alien_Queen_charge_collide_injured"}
	self.AnimTbl_FlinchCrouch = {"Alien_Queen_charge_collide_injured"}
	self.AnimTbl_FlinchStand = {"Alien_Queen_charge_collide_injured"}

	self.InBirth = false
	-- self.NextLookForBirthT = CurTime() +60
	self.NextLookForBirthT = CurTime() +10
	self.NextSpawnEggT = 0
	self.NextCommandXenosT = 0
	self.Eggs = {}
	self.InCharge = false
	self.ChargeT = 0
	self.NextSpecialEggCheckT = CurTime() +5

	self:SetStepHeight(50)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRangeAttack_AfterStartTimer(seed)
	self.NextChaseTime = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward() *math.random(700,850) +self:GetUp() *100
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnHitEntity(ent,isProp)
	if isProp then
		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:ApplyForceCenter(self:GetForward() *(self.VJ_AVP_Xenomorph_Matriarch && 3500 or 2000) +self:GetUp() *250)
		end
	else
		if ent.MovementType != VJ_MOVETYPE_STATIONARY && (!ent.VJ_ID_Boss or ent.IsVJBaseSNPC_Tank) then
			ent:SetGroundEntity(NULL)
			ent:SetVelocity(self:MeleeAttackKnockbackVelocity(ent))
		end
		if ent:IsPlayer() then -- Simulate getting your shit rocked
			ent:ScreenFade(SCREENFADE.IN,Color(34,0,0),self.VJ_AVP_Xenomorph_Matriarch && 1.2 or 0.2,self.VJ_AVP_Xenomorph_Matriarch && 0.6 or math.Rand(0.1,0.3))
			local impact = self.VJ_AVP_Xenomorph_Matriarch && 140 or 75
			local ang = ent:EyeAngles()
			ang.p = ang.p +math.random(-impact,impact)
			ang.y = ang.y +math.random(-impact,impact)
			ent:SetEyeAngles(ang)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local table_Count = table.Count
local table_insert = table.insert
--
function ENT:OnThink2()
	local curTime = CurTime()
	local cont = self.VJ_TheController
	if self.Alerted && !IsValid(cont) then
		self.NextLookForBirthT = curTime +60
		if self.InBirth && self.NearestPointToEnemyDistance <= 1000 && IsValid(self:GetEnemy()) && self:Visible(self:GetEnemy()) then
			self.InBirth = false
			for _,v in pairs(VJ_AVP_XENOS) do
				if IsValid(v) && v != self && v:CheckRelationship(self) == D_LI then
					v:Follow(self)
					v:SetLastPosition(self:GetPos() +self:GetForward() *math.random(200,200) +self:GetRight() *math.random(-200,200))
					v:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH")
				end
			end
			self:PlayAnim("Alien_Queen_eggsack_exit",true,false,false)
			self:PlaySound({"^cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_05.ogg"},120)
			self.AnimTranslations[ACT_IDLE] = ACT_IDLE
			self:SetState()
			SafeRemoveEntity(self.EggSack)
		end
	end
	if !self.InBirth && self.InCharge then
		if self:IsBusy() then return end
		self:SetMoveVelocity(self:GetMoveVelocity() *1.25)
		self:SetArrivalSpeed(9999)
		if curTime > self.ChargeT then
			self:SetMaxYawSpeed(self.TurningSpeed)
			self:PlayAnim("Alien_Queen_charge_into_idle",true,false,false)
			self.InCharge = false
			self.HasRangeAttack = true
			return
		end
		self.HasRangeAttack = false
		self:SetMaxYawSpeed(2)
		self:SetTurnTarget("Enemy")
		local tr = util.TraceHull({
			start = self:GetPos() +self:OBBCenter(),
			endpos = self:GetPos() +self:OBBCenter() +self:GetForward() *175,
			filter = self,
			mins = self:OBBMins() *0.85,
			maxs = self:OBBMaxs() *0.85,
		})
		self:SetLastPosition(tr.HitPos +tr.HitNormal *300)
		self:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH",function(x) x:EngTask("TASK_FACE_ENEMY", 0) x.TurnData = {Type = VJ.FACE_ENEMY} end)
		if self:OnGround() then
			self:SetVelocity(VJ.GetMoveVelocity(self) *1)
		end
		if tr.Hit then
			if tr.HitWorld then
				self:PlayAnim("Alien_Queen_charge_collide_injured",true,false,false)
				self:OnCollision(tr.HitEntity,3)
			else
				self:PlayAnim("Alien_Queen_charge_collide",true,false,false)
				self:OnCollision(tr.HitEntity,2)
			end
			-- VJ.DEBUG_TempEnt(tr.HitPos, self:GetAngles(), Color(255,0,0), 5)
			self:SetMaxYawSpeed(self.TurningSpeed)
			self.InCharge = false
			return
		end
		for _,v in pairs(ents.FindInSphere(self:GetPos(),200)) do
			if (v:IsNPC() or v:IsPlayer() or v:IsNextBot()) && self:CheckRelationship(v) == D_HT then
				self:PlayAnim("Alien_Queen_charge_into_idle",true,false,false)
				self:OnCollision(v,1)
				self.InCharge = false
				return
			end
		end
		-- local trMove = util.TraceHull({
		-- 	start = self:GetPos() +self:OBBCenter(),
		-- 	endpos = self:GetPos() +self:GetForward() *300,
		-- 	filter = self,
		-- 	mins = self:OBBMins(),
		-- 	maxs = self:OBBMaxs(),
		-- 	mask = MASK_SOLID_BRUSHONLY
		-- })
		-- VJ.DEBUG_TempEnt(trMove.HitPos, self:GetAngles(), Color(0,247,255), 5)
		-- self:SetLastPosition(trMove.HitPos +trMove.HitNormal *10)
		-- self:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH")
		return
	end
	if !IsValid(cont) && !self.InBirth && curTime > self.NextLookForBirthT && !self.Alerted && !self.SpawnedUsingMutator then
		if !self:IsBusy() && !self:IsMoving() then
			local vsched = vj_ai_schedule.New("SCHEDULE_IDLE_WANDER")
			vsched:EngTask("TASK_GET_PATH_TO_RANDOM_NODE", 2000)
			vsched:EngTask("TASK_WAIT_FOR_MOVEMENT", 0)
			vsched.HasMovement = true
			-- self:SetMovementActivity(VJ.PICK(self.AnimTbl_Run))
			vsched.MoveType = 1
			if (customFunc) then customFunc(vsched) end
			self:StartSchedule(vsched)
		end
		local check = Vector(self:OBBMaxs().x,self:OBBMaxs().y,0)
		local trHull = util.TraceHull({
			start = self:GetPos(),
			endpos = self:GetPos(),
			filter = self,
			mins = check *-1,
			maxs = check,
		})
		if !trHull.Hit then
			self.InBirth = true
		end
	elseif self.InBirth then
		if !IsValid(self.EggSack) then
			local eggsack = ents.Create("prop_vj_animatable")
			eggsack:SetModel("models/cpthazama/avp/xeno/queen_eggsack.mdl")
			eggsack:SetPos(self:GetPos() +self:GetForward() *18 +self:GetUp() *-10)
			eggsack:SetAngles(self:GetAngles())
			eggsack:SetOwner(self)
			eggsack:SetParent(self)
			eggsack:Spawn()
			eggsack:Activate()
			eggsack:SetModelScale(self.VJ_AVP_Xenomorph_Matriarch && 1.3 or 1)
			eggsack:SetRenderMode(RENDERMODE_TRANSALPHA)
			eggsack:SetColor(Color(255,255,255,0))
			eggsack:SetRenderFX(kRenderFxSolidSlow)
			timer.Simple(1,function() if IsValid(eggsack) then eggsack:SetRenderFX(kRenderFxNone) eggsack:SetColor(Color(255,255,255,255)) end end)
			eggsack:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			eggsack:AddEffects(EF_PARENT_ANIMATES)
			eggsack:ResetSequence("idle")
			-- eggsack:SetNW2Bool("AVP.Xenomorph",true)
			self:DeleteOnRemove(eggsack)
			self.EggSack = eggsack
			self:PlayAnim("Alien_Queen_eggsack_enter",true,false,false)
			self:PlaySound({"^cpthazama/avp/xeno/alien/hud/queen_message_new_objective_01.ogg","^cpthazama/avp/xeno/alien/hud/queen_message_objective_complete_01.ogg"},120)
			self.AnimTranslations[ACT_IDLE] = ACT_IDLE_RELAXED
			self.NextSpawnEggT = curTime +5
			self.NextCommandXenosT = curTime +math.random(5,10)
			for _,v in pairs(VJ_AVP_XENOS) do
				if IsValid(v) && v:CheckRelationship(self) == D_LI && v.FollowData && v.FollowData.Ent == self then
					v:ResetFollowBehavior()
				end
			end
		else
			if IsValid(cont) && cont:KeyDown(IN_JUMP) then
				self:PlayAnim("Alien_Queen_eggsack_exit",true,false,false)
				self:PlaySound({"^cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_05.ogg"},120)
				self.InBirth = false
				self.AnimTranslations[ACT_IDLE] = ACT_IDLE
				self:SetState()
				for _,v in pairs(VJ_AVP_XENOS) do
					if IsValid(v) && v != self && v:CheckRelationship(self) == D_LI then
						v:Follow(self)
						v:SetLastPosition(self:GetPos() +self:GetForward() *math.random(200,200) +self:GetRight() *math.random(-200,200))
						v:SCHEDULE_GOTO_POSITION("TASK_RUN_PATH")
					end
				end
				SafeRemoveEntity(self.EggSack)
				return
			end
		end
		if self:IsMoving() then
			self:StopMoving()
		end
		self:SetState(VJ_STATE_ONLY_ANIMATION)
		if curTime > self.NextCommandXenosT && math.random(1,20) == 1 then
			self.NextCommandXenosT = curTime +math.random(20,40)
			local command = {}
			local tbl = {}
			tbl.Drones = {}
			tbl.Warriors = {}
			tbl.Praetorian = {}

			for _,v in ents.Iterator() do
				if v.VJ_AVP_Xenomorph && v != self && !v.VJ_AVP_Xenomorph_Queen && self:CheckRelationship(v) == D_LI then
					if v.VJ_AVP_XenomorphID == "drone" then
						table_insert(tbl.Drones,v)
						command.Drone = true
						-- print("Found drone",v)
					elseif v.VJ_AVP_XenomorphID == "warrior" then
						table_insert(tbl.Warriors,v)
						command.Warrior = true
						-- print("Found warrior",v)
					elseif v.VJ_AVP_XenomorphID == "praetorian" then
						if v.VJ_AVP_XenomorphCarrier && v:GetFacehuggerCount() > 6 then
							table_insert(tbl.Warriors,v)
							command.Warrior = true
						else
							table_insert(tbl.Praetorian,v)
							command.Praetorian = true
							-- print("Found praetorian",v)
						end
					end
				end
			end

			if !command.Drone && !command.Warrior && !command.Praetorian then return end

			self:PlaySound({"^cpthazama/avp/xeno/alien/hud/queen_message_new_objective_01.ogg","^cpthazama/avp/xeno/alien/hud/queen_message_objective_complete_01.ogg"},100)
			RunConsoleCommand("ai_clear_bad_links")

			local nodegraph = table.Copy(VJ_Nodegraph.Data.Nodes)
			if command.Drone then
				local possibleNodes = {}
				for _,node in pairs(nodegraph) do
					local dist = self:GetPos():Distance(node.pos)
					if node.type == 2 && dist < 1500 && dist > 500 then
						table_insert(possibleNodes,node.pos)
					end
				end
				for _,v in pairs(tbl.Drones) do
					local node = VJ.PICK(possibleNodes)
					if node then
						-- print("Sending ",v," to ",node)
						v:StopMoving()
						if v.SetQueenMarker then
							v:SetQueenMarker(node)
							if IsValid(v.VJ_TheController) then
								v.VJ_TheController:ChatPrint("[Dev] The Queen has marked a location for you, go to the black mist!")
							end
						end
						v:SetLastPosition(node)
						v:SCHEDULE_GOTO_POSITION((self:GetPos():Distance(node) > 500 && math.random(1,3) == 1) && "TASK_RUN_PATH" or "TASK_WALK_PATH", function(x)
							x.TurnData = {Type = VJ.FACE_ENEMY_VISIBLE}
							x.CanShootWhenMoving = true
						end)
					end
				end
			end
			if command.Warrior then
				local possibleNodes = {}
				for _,node in pairs(nodegraph) do
					local dist = self:GetPos():Distance(node.pos)
					if node.type == 2 && dist >= 1500 then
						table_insert(possibleNodes,node.pos)
					end
				end
				for _,v in pairs(tbl.Warriors) do
					local node = VJ.PICK(possibleNodes)
					if node then
						-- print("Sending ",v," to ",node)
						v:StopMoving()
						if v.SetQueenMarker then
							v:SetQueenMarker(node)
							if IsValid(v.VJ_TheController) then
								v.VJ_TheController:ChatPrint("[Dev] The Queen has marked a location for you, go to the black mist!")
							end
						end
						v:SetLastPosition(node)
						v:SCHEDULE_GOTO_POSITION((self:GetPos():Distance(node) > 500 && math.random(1,3) == 1) && "TASK_RUN_PATH" or "TASK_WALK_PATH", function(x)
							x.TurnData = {Type = VJ.FACE_ENEMY_VISIBLE}
							x.CanShootWhenMoving = true
						end)
					end
				end
			end
			if command.Praetorian then
				local possibleNodes = {}
				for _,node in pairs(nodegraph) do
					local dist = self:GetPos():Distance(node.pos)
					if node.type == 2 && dist <= 750 && dist > 400 then
						table_insert(possibleNodes,node.pos)
					end
				end
				local count = table_Count(tbl.Praetorian)
				for _,v in pairs(tbl.Praetorian) do
					if !v.VJ_AVP_XenomorphPraetorianSubClass && math.random(1,10) == 1 && count > 1 && v.DoRoyalTransformation then
						v:DoRoyalTransformation(true)
					else
						local node = VJ.PICK(possibleNodes)
						if node then
							-- print("Sending ",v," to ",node)
							v:StopMoving()
							if v.SetQueenMarker then
								v:SetQueenMarker(node)
								if IsValid(v.VJ_TheController) then
									v.VJ_TheController:ChatPrint("[Dev] The Queen has marked a location for you, go to the black mist!")
								end
							end
							v:SetLastPosition(node)
							v:SCHEDULE_GOTO_POSITION((self:GetPos():Distance(node) > 500 && math.random(1,3) == 1) && "TASK_RUN_PATH" or "TASK_WALK_PATH", function(x)
								x.TurnData = {Type = VJ.FACE_ENEMY_VISIBLE}
								x.CanShootWhenMoving = true
							end)
						end
					end
				end
			end
		end
		if curTime > self.NextSpawnEggT && table_Count(self.Eggs) < VJ_AVP_MAX_EGGS then
			self.NextSpawnEggT = curTime +math.random(5,15)
			local didSpawn = false
			local attempts = 0
			local goodPos = true
			local eggSack = self.EggSack
			local eggSackPos = eggSack:GetAttachment(1).Pos
			local filters = {self,eggSack}
			while didSpawn != true do
				attempts = attempts +1
				if attempts >= 50 then break end

				local vecRand = VectorRand() *750
				vecRand.z = self:GetPos().z
				local tr = util.TraceLine({
					start = self:GetPos() +self:GetUp() *150,
					endpos = self:GetPos() +VectorRand() *750,
					filter = filters,
					mask = MASK_SOLID_BRUSHONLY
				})
				local tr2 = util.TraceLine({
					start = tr.HitPos +tr.HitNormal *18,
					endpos = tr.HitPos +tr.HitNormal *18 +self:GetUp() *-750,
					filter = filters,
					mask = MASK_SOLID_BRUSHONLY
				})
				local trBox = util.TraceHull({
					start = tr2.HitPos +tr2.HitNormal *20,
					endpos = tr2.HitPos +tr2.HitNormal *20,
					mins = Vector(-15,-15,-15),
					maxs = Vector(15,15,15),
					mask = MASK_NPCSOLID,
					filter = filters
				})

				if !util.IsInWorld(tr2.HitPos) then continue end

				for _,v in pairs(ents.FindInSphere(tr2.HitPos, 50)) do
					if v:GetClass() == "npc_vj_avp_xeno_egg" then
						goodPos = false
						-- Entity(1):ChatPrint("Egg too close to this point!")
						break
					end
				end

				if goodPos && tr2.Hit && tr2.HitPos:Distance(self:GetPos()) > 150 && !trBox.Hit then
					local particle = ents.Create("info_particle_system")
					particle:SetKeyValue("effect_name", "vj_avp_xeno_spit")
					particle:SetPos(eggSackPos)
					particle:Spawn()
					particle:Activate()
					particle:SetParent(eggSack)
					particle:Fire("SetParentAttachment", "egg")
					particle:Fire("Start")
					particle:Fire("Kill", "", 1)

					local isRoyal = math.random(1,40) == 1
					if CurTime() > self.NextSpecialEggCheckT then
						local tbl = {}
						tbl.Drones = {}
						tbl.Warriors = {}
						tbl.Praetorian = {}
			
						for _,v in ents.Iterator() do
							if v.VJ_AVP_Xenomorph && v != self && !v.VJ_AVP_Xenomorph_Queen && self:CheckRelationship(v) == D_LI then
								if v.VJ_AVP_XenomorphID == "drone" then
									table_insert(tbl.Drones,v)
								elseif v.VJ_AVP_XenomorphID == "warrior" then
									table_insert(tbl.Warriors,v)
								elseif v.VJ_AVP_XenomorphID == "praetorian" then
									table_insert(tbl.Praetorian,v)
								end
							end
						end

						if table_Count(tbl.Praetorian) == 0 && (table_Count(tbl.Drones) > 0 or table_Count(tbl.Warriors) > 0) then
							isRoyal = true
						end

						self.NextSpecialEggCheckT = CurTime() +math.random(20,40)
					end

					local egg = ents.Create("npc_vj_avp_xeno_egg")
					egg:SetPos(tr2.HitPos)
					egg:SetAngles(self:GetAngles())
					egg:SetOwner(self)
					egg:Spawn()
					egg:Activate()
					egg.VJ_NPC_Class = self.VJ_NPC_Class
					if isRoyal then
						egg.VJ_AVP_XenomorphEggRoyal = true
						egg:SetModelScale(1.25,3)
					end
					egg:SetRenderMode(RENDERMODE_TRANSALPHA)
					egg:SetColor(Color(255,255,255,0))
					egg:SetRenderFX(kRenderFxSolidSlow)
					if self.VJ_AVP_K_Xenomorph then
						egg.VJ_AVP_K_Xenomorph = true
						timer.Simple(1,function() if IsValid(egg) then egg:SetRenderFX(kRenderFxNone) egg:SetColor(isRoyal && Color(190,109,65) or Color(186,172,81)) end end)
					else
						timer.Simple(1,function() if IsValid(egg) then egg:SetRenderFX(kRenderFxNone) egg:SetColor(isRoyal && Color(190,65,65) or Color(255,255,255,255)) end end)
					end
					local particle = ents.Create("info_particle_system")
					particle:SetKeyValue("effect_name", "vj_avp_xeno_spit_impact")
					particle:SetPos(egg:GetPos())
					particle:Spawn()
					particle:Activate()
					particle:Fire("Start")
					particle:Fire("Kill", "", 0.1)

					egg.Queen = self
					table_insert(self.Eggs,egg)
					didSpawn = true
					-- Entity(1):ChatPrint("Egg spawned! [" .. egg:EntIndex() .. "] Attempts: " .. attempts .. " | Total Eggs: " .. table_Count(self.Eggs) .. "/" .. VJ_AVP_MAX_EGGS)
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCollision(ent,colType)
	self.AttackDamageDistance = 300
	self.AttackDamageType = bit.bor(DMG_SLASH,DMG_CRUSH,DMG_VEHICLE)
	self.MeleeAttackDamageAngleRadius = 130
	self:RunDamageCode(self.VJ_AVP_Xenomorph_Matriarch && 6 or 2)
	self.MeleeAttackDamageAngleRadius = 100
	self.HasRangeAttack = true
	util.ScreenShake(self:GetPos(),12,150,2,800)
	self:PlaySound(self.SoundTbl_Attack,80)
	self:SetMaxYawSpeed(self.TurningSpeed)
	if colType == 3 then
		ParticleEffect("AntlionFX_UnBurrow",self:GetAttachment(self:LookupAttachment("eyes")).Pos,Angle())
		sound.Play("cpthazama/avp/xeno/praetorian/praetorian_hit_wall_01.ogg",self:GetPos(),110)
		for _,v in pairs(ents.FindInSphere(self:GetPos(),1000)) do
			local isProp = VJ.IsProp(v)
			if v:IsNPC() && v != self or v:IsPlayer() or v:IsNextBot() or isProp then -- Let's shake things up
				local distPercentage = 1 -v:GetPos():Distance(self:GetPos()) /1000
				if isProp then
					local hitDir = (v:GetPos() -self:GetPos()):GetNormalized()
					local phys = v:GetPhysicsObject()
					if IsValid(phys) then
						phys:EnableMotion(true)
						phys:Wake()
						phys:ApplyForceCenter(hitDir *phys:GetMass() *(300 *distPercentage))
					end
				else
					if v.MovementType != VJ_MOVETYPE_STATIONARY && (!v.VJ_ID_Boss or v.IsVJBaseSNPC_Tank) then
						v:SetGroundEntity(NULL)
						v:SetVelocity(v:GetUp() *(math.random(100,200) *distPercentage) +v:GetForward() *(math.random(-500,500) *distPercentage) +v:GetRight() *(math.random(-500,500) *distPercentage))
					end
				end
			end
		end
	else
		sound.Play(VJ.PICK(sdMM),self:GetPos(),80)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Breathe()
	if CurTime() > (self.NextBreathT or 0) then
		local snd = "cpthazama/avp/xeno/alien queen/queen_breath_2.wav"
		VJ.CreateSound(self,snd,72)
		self.NextBreathT = CurTime() +SoundDuration(snd)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectMovementActivity(act)
	-- local act = ACT_RUN
	local ply = self.VJ_TheController
	if IsValid(ply) then
		if ply:KeyDown(IN_WALK) then
			act = ACT_WALK
		elseif self.InCharge then
			act = ACT_SPRINT
		else
			act = ACT_RUN
		end
		return act
	end
	if self.InCharge then
		act = ACT_SPRINT
	-- else
	-- 	local currentSchedule = self.CurrentSchedule
	-- 	if currentSchedule != nil then
	-- 		act = currentSchedule.MoveType == 0 && ACT_WALK or ACT_RUN
	-- 	end
	end
	return act
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectIdleActivity()
	return ACT_IDLE
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SelectTurnActivity(inAct)
	return inAct
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack(ent,visible)
	if self.InFatality or self.DoingFatality then return end
	local cont = self.VJ_TheController
	local dist = self.NearestPointToEnemyDistance
	-- local dist = self.LastEnemyDistance

	if IsValid(cont) then
		if self.InBirth then
			return
		end
		if cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && !self:IsBusy() then
			self:AttackCode()
		elseif !cont:KeyDown(IN_ATTACK) && !cont:KeyDown(IN_ATTACK2) && cont:KeyDown(IN_SPEED) && !self:IsBusy() then
			self:AttackCode(true)
		elseif cont:KeyDown(IN_JUMP) && !self.InBirth && !self:IsBusy() then
			self.InBirth = true
		end
		return
	end

	if visible then
		if self.InBirth then
			return
		end
		if self.CanAttack then
			if dist <= self.AttackDistance *(self.VJ_AVP_Xenomorph_Matriarch && 2 or 1) && !self:IsBusy() then
				local canUse, inFront = self:CanUseFatality(ent)
				if canUse && (inFront && math.random(1,2) == 1 or !inFront) then
					if self:DoFatality(ent,inFront) == false then
						self:AttackCode()
					end
				else
					self:AttackCode()
				end
			elseif dist > self.AttackDistance *5 && dist <= 2500 && !self.InCharge && !self:IsBusy() && math.random(1,100) == 1 then
				self:AttackCode(true)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:AttackCode(charge)
	if self.InFatality or self.DoingFatality then return end
	if !self.CanAttack then return end
	if !charge then
		self.AttackType = 2
		self.AttackSide = self.AttackSide == "right" && "left" or "right"
		self:PlaySound(self.SoundTbl_Attack,75)
		local _,dur = self:PlayAnim("Alien_Queen_claw_swipe_" .. self.AttackSide,true,false,true,0,{AlwaysUseGesture=true,OnFinish=function(interrupted,anim)
			if interrupted or self.InFatality then return end -- Means we hit something
			self:PlayAnim("Alien_Queen_claw_swipe_" .. self.AttackSide .. "_return",true,false,true,0,{AlwaysUseGesture=true})
			self.NextChaseTime = 0
		end})
		timer.Simple(dur *0.6,function()
			if IsValid(self) && !self.InFatality then
				self.AttackDamage = self.VJ_AVP_Xenomorph_Matriarch && 200 or 75
				self.AttackDamageDistance = self.VJ_AVP_Xenomorph_Matriarch && 230 or 140
				self.AttackDamageType = bit.bor(DMG_SLASH,DMG_CRUSH)
				VJ.EmitSound(self,#self:RunDamageCode() > 0 && sdClawFlesh or sdClawMiss,75)
			end
		end)
		self.NextChaseTime = 0
	else
		if !self.InCharge then
			self.InCharge = true
			local _,dur = self:PlayAnim("Alien_Queen_charge_build_up",true,false,true)
			self.ChargeT = CurTime() +dur +5
		end
		// Alien_Queen_charge_build_up
		// Alien_Queen_charge -- ACT_SPRINT
		// Alien_Queen_charge_into_idle or (Alien_Queen_charge_collide or Alien_Queen_charge_collide_injured)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:WhenRemoved()
	if !self.Dead then
		for _, v in ipairs(self.Eggs) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local angY45 = Angle(0, 45, 0)
local angYN45 = Angle(0, -45, 0)
local angY90 = Angle(0, 90, 0)
local angYN90 = Angle(0, -90, 0)
local angY135 = Angle(0, 135, 0)
local angYN135 = Angle(0, -135, 0)
local angY180 = Angle(0, 180, 0)
local defAng = Angle(0, 0, 0)
--
function ENT:Controller_Movement(cont, ply, bullseyePos)
	if self.MovementType != VJ_MOVETYPE_STATIONARY then
		local gerta_lef = ply:KeyDown(IN_MOVELEFT)
		local gerta_rig = ply:KeyDown(IN_MOVERIGHT)
		local gerta_arak = ply:KeyDown(IN_SPEED)
		local aimVector = ply:GetAimVector()
		local FT = FrameTime() *(self.TurningSpeed *2.25)

		self.ControllerVars.TurnAngle = self.ControllerVars.TurnAngle or defAng
		
		if ply:KeyDown(IN_FORWARD) then
			if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
				self:AA_MoveTo(cont.VJCE_Bullseye, true, gerta_arak and "Alert" or "Calm", {IgnoreGround=true})
			else
				self.ControllerVars.TurnAngle = LerpAngle(FT, self.ControllerVars.TurnAngle, gerta_lef && angY45 or gerta_rig && angYN45 or defAng)
				cont:StartMovement(aimVector, self.ControllerVars.TurnAngle)
			end
		elseif gerta_lef then
			self.ControllerVars.TurnAngle = LerpAngle(FT, self.ControllerVars.TurnAngle, angY90)
			cont:StartMovement(aimVector, self.ControllerVars.TurnAngle)
		elseif gerta_rig then
			self.ControllerVars.TurnAngle = LerpAngle(FT, self.ControllerVars.TurnAngle, angYN90)
			cont:StartMovement(aimVector, self.ControllerVars.TurnAngle)
		else
			if !self.InCharge then
				self:StopMoving(false)
				if self.MovementType == VJ_MOVETYPE_AERIAL or self.MovementType == VJ_MOVETYPE_AQUATIC then
					self:AA_StopMoving()
				end
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnStep(pos,name)
	util.ScreenShake(pos,5,100,0.35,1000)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnAlert(ent)
	if math.random(1,2) == 1 && !self:IsBusy() then
		VJ.STOPSOUND(self.CurrentSpeechSound)
		VJ.STOPSOUND(self.CurrentIdleSound)
		self:PlayAnim("Alien_Queen_fidget_roar",true,false,false)
		self:PlaySound("cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_05.ogg",110)
		util.ScreenShake(self:EyePos(),16,200,4,1000,true)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCallForHelp(ally)
	if self:IsBusy() then return end
	VJ.STOPSOUND(self.CurrentSpeechSound)
	VJ.STOPSOUND(self.CurrentIdleSound)
	self:PlayAnim("Alien_Queen_fidget_roar",true,false,false)
	self:PlaySound("cpthazama/avp/xeno/alien queen/vocal/alien_queen_scream_05.ogg",110)
	util.ScreenShake(self:EyePos(),16,200,4,1000,true)
end