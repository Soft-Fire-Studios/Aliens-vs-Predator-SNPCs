AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.Type 			= "anim"
ENT.PrintName 		= "RC Controller"
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= ""
ENT.Instructions 	= ""
ENT.Category		= "Aliens vs Predator"

ENT.Spawnable = false
ENT.AdminOnly = false
ENT.AutomaticFrameAdvance = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetupDataTables()
	self:NetworkVar("Bool",0,"Active")
	self:NetworkVar("Bool",1,"On")
	self:NetworkVar("Entity",0,"LinkedObject")
end
---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	local mat = Material("vj_base/sprites/vj_trial1")
	local colOn = Color(0,255,0,255)
	local colOff = Color(255,0,0,255)
	function ENT:Draw()
		self:DrawModel()

		local linkedObj = self:GetLinkedObject()
		if IsValid(linkedObj) && LocalPlayer():GetPos():Distance(self:GetPos()) <= 100 then
			render.SetMaterial(mat)
			render.DrawBeam(self:GetAttachment(1).Pos,linkedObj:GetPos() +linkedObj:OBBCenter(),25,0,0,self:GetOn() && colOn or colOff)
		end
	end
	
	function ENT:DrawTranslucent()
		self:Draw()
	end

	local halo_Add = halo.Add
	local table_insert = table.insert
	local table_remove = table.remove
	function ENT:Initialize()
		hook.Add("PreDrawHalos",self,function(self)
			local linkedObj = self:GetLinkedObject()
			if IsValid(linkedObj) && LocalPlayer():GetPos():Distance(self:GetPos()) <= 100 then
				halo_Add({linkedObj},self:GetOn() && colOn or colOff,1,1,5,true,true)
			end
		end)
	end
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/cpthazama/avp/misc/rc_controller.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	-- local light = ents.Create("light_dynamic")
	-- light:SetKeyValue("brightness", "2")
	-- light:SetKeyValue("distance", "100")
	-- light:SetLocalPos(self:GetPos())
	-- light:SetLocalAngles(self:GetAngles())
	-- light:Fire("Color", "155 155 255")
	-- light:SetParent(self)
	-- light:Spawn()
	-- light:Activate()
	-- light:Fire("SetParentAttachment", "fx", 0)
	-- self:DeleteOnRemove(light)
	-- self.Light = light

	self:SetOn(true)
	self:SetActive(true)
	self:SetNW2Bool("AVP.IsTech",true)
	self.VJ_AVP_IsTech = true
	self.NextRequestRestartT = 0

	-- timer.Simple(3,function() self:DrainBattery() end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Think()
	if !VJ_CVAR_AI_ENABLED then return end

	local linkedObj = self:GetLinkedObject()
	if !self:GetOn() && IsValid(linkedObj) && CurTime() > self.NextRequestRestartT then
		for _,v in ipairs(ents.FindInSphere(self:GetPos(),1000)) do
			if v:IsNPC() && v != linkedObj && v.VJ_AVP_Marine && !IsValid(v:GetEnemy()) && linkedObj:CheckRelationship(v) == D_LI && self:Visible(v) then
				v:SetLastPosition(self:GetPos() +self:GetForward() *35)
				v:VJ_TASK_GOTO_LASTPOS("TASK_WALK_PATH", function(x)
					x.CanShootWhenMoving = true
					x.FaceData = {Type = VJ.NPC_FACE_ENEMY}
					x.RunCode_OnFinish = function()
						timer.Simple(0.01, function()
							if IsValid(self) && IsValid(v) && IsValid(linkedObj) && v:BusyWithActivity() == false then
								self.NextRequestRestartT = CurTime() +math.random(30,45)
								-- v:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
								v:VJ_ACT_PLAYACTIVITY("vjseq_sentry_gun_into",true,false,false,0,{OnFinish=function(int1)
									if int1 then return end
									v:VJ_ACT_PLAYACTIVITY("vjseq_sentry_gun_loop",true,false,false,0,{OnFinish=function(int2)
										if int2 then return end
										if linkedObj.OnDeviceEffected then
											linkedObj:OnDeviceEffected(self,self:GetOn() && 2 or 1)
											self:SetOn(true)
										end
										v:VJ_ACT_PLAYACTIVITY("vjseq_sentry_gun_outof",true,false,false)
										-- v:SetState()
									end})
								end})
								v:SetTurnTarget(self,0.2)
							end
						end)
					end
				end)
				self.NextRequestRestartT = CurTime() +math.random(30,45)
				break
			end
		end
		self.NextRequestRestartT = CurTime() +math.random(15,30)
	end

	self:NextThink(CurTime())
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Use(ent)
	if !self:GetActive() then return end
	local linkedObj = self:GetLinkedObject()
	if ent:IsPlayer() && IsValid(linkedObj) && ent:Alive() && !IsValid(ent:GetObserverTarget()) then
		if linkedObj.OnDeviceEffected then
			ent:ChatPrint(self:GetOn() && "The Sentry Gun has been turned off." or "The Sentry Gun has been turned on.")
			linkedObj:OnDeviceEffected(self,self:GetOn() && 2 or 1)
			self:SetOn(!self:GetOn())
			if !self:GetOn() then
				self.NextRequestRestartT = CurTime() +math.random(15,30)
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DestroyObject()
	self:SetOn(false)
	self:SetActive(false)

	local linkedObj = self:GetLinkedObject()
	if IsValid(linkedObj) && linkedObj.OnDeviceEffected then
		linkedObj:OnDeviceEffected(self,4)
	end

	VJ.EmitSound(self,"cpthazama/avp/shared/battery_terminal_electricity_01.ogg",80)
	ParticleEffectAttach("vj_avp_rc_battery_sap",PATTACH_POINT_FOLLOW,self,1)
	timer.Simple(6,function()
		if IsValid(self) then
			self:StopParticles()
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnRemove()
	self:StopParticles()
	-- VJ.STOPSOUND(self.fireLoopSD)
end