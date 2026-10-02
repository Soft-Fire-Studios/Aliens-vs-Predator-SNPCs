/*
	Based on Aliens vs Predator 2010's original source code
*/

local cvEnabled = CreateConVar("vj_avp_xeno_surface_traversal", "1", FCVAR_ARCHIVE, "Allow regular AVP Xenomorphs to traverse walls and ceilings.")
local cvAI = CreateConVar("vj_avp_xeno_surface_traversal_ai", "1", FCVAR_ARCHIVE, "Allow AI AVP Xenomorphs to use wall and ceiling traversal.")
local cvController = CreateConVar("vj_avp_xeno_surface_traversal_controller", "1", FCVAR_ARCHIVE, "Allow possessed AVP Xenomorphs to use wall and ceiling traversal.")
local cvDebug = CreateConVar("vj_avp_xeno_surface_traversal_debug", "0", FCVAR_ARCHIVE, "Draw AVP Xenomorph surface traversal debug traces.")

local WORLD_UP = Vector(0, 0, 1)
local ZERO = Vector(0, 0, 0)
local PROBE_MINS = Vector(-5, -5, -5)
local PROBE_MAXS = Vector(5, 5, 5)
local math_abs = math.abs
local math_max = math.max
local math_min = math.min
local math_Clamp = math.Clamp

local function ProjectOnPlane(vec, normal)
	return vec - normal * vec:Dot(normal)
end

local function NormalizedOr(vec, fallback)
	if vec:LengthSqr() <= 0.0001 then
		return fallback:GetNormalized()
	end
	return vec:GetNormalized()
end

local function IsActor(ent)
	return IsValid(ent) && (ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot())
end

local function IsUsableSurface(self, tr)
	if !tr or !tr.Hit or tr.HitSky then return false end
	if IsActor(tr.Entity) then return false end
	if tr.Entity == self then return false end
	return tr.HitNormal:LengthSqr() > 0.5
end

local function SurfaceType(normal)
	if normal.z > 0.707 then return "floor" end
	if normal.z < -0.707 then return "ceiling" end
	return "wall"
end

local function SurfaceAngle(forward, normal, fallbackForward)
	forward = ProjectOnPlane(forward, normal)
	if forward:LengthSqr() <= 0.0001 then
		forward = ProjectOnPlane(fallbackForward or Vector(1, 0, 0), normal)
	end
	if forward:LengthSqr() <= 0.0001 then
		forward = normal:Cross(Vector(1, 0, 0))
		if forward:LengthSqr() <= 0.0001 then
			forward = normal:Cross(Vector(0, 1, 0))
		end
	end
	forward:Normalize()

	local right = forward:Cross(normal)
	if right:LengthSqr() <= 0.0001 then
		right = Vector(0, -1, 0)
	else
		right:Normalize()
	end

	local up = right:Cross(forward)
	up:Normalize()

	local m = Matrix()
	m:SetForward(forward)
	m:SetRight(right)
	m:SetUp(up)
	return m:GetAngles(), forward
end

local function SurfaceAngleContinuous(self, forward, normal)
	local desiredForward = ProjectOnPlane(forward, normal)
	if desiredForward:LengthSqr() <= 0.0001 then
		desiredForward = ProjectOnPlane(self:GetForward(), normal)
	end
	desiredForward = NormalizedOr(desiredForward, self:GetForward())

	local ang = self:GetAngles()
	local currentUp = ang:Up()
	currentUp:Normalize()
	normal = normal:GetNormalized()

	local upDot = math_Clamp(currentUp:Dot(normal), -1, 1)
	if upDot < 0.99995 then
		local axis = currentUp:Cross(normal)
		if axis:LengthSqr() <= 0.0001 then
			axis = ProjectOnPlane(ang:Right(), currentUp)
			axis = NormalizedOr(axis, ang:Forward())
		else
			axis:Normalize()
		end
		ang:RotateAroundAxis(axis, math.deg(math.acos(upDot)))
	end

	local currentForward = ProjectOnPlane(ang:Forward(), normal)
	currentForward = NormalizedOr(currentForward, desiredForward)
	local dot = math_Clamp(currentForward:Dot(desiredForward), -1, 1)
	local cross = currentForward:Cross(desiredForward)
	local signed = math.deg(math.atan2(normal:Dot(cross), dot))
	if math_abs(signed) > 0.001 then
		ang:RotateAroundAxis(normal, signed)
	end

	return ang, desiredForward
end

local function GetSurfaceAngle(self, forward, normal, fallbackForward)
	if self.SurfaceTraversal_ContinuousOrientation then
		return SurfaceAngleContinuous(self, forward, normal)
	end
	return SurfaceAngle(forward, normal, fallbackForward)
end

local function DebugLine(startPos, endPos, col, duration)
	if !cvDebug:GetBool() then return end
	debugoverlay.Line(startPos, endPos, duration or 0.08, col or Color(0, 255, 0), true)
end

local function DebugCross(pos, size, col, duration)
	if !cvDebug:GetBool() then return end
	debugoverlay.Cross(pos, size or 5, duration or 0.08, col or Color(255, 255, 0), true)
end

function ENT:SurfaceTraversal_Init()
	self.IsOnSurface = false
	self.Surface_IsMoving = false
	self.CurrentSurfaceNormal = WORLD_UP
	self.SurfaceTraversal_TargetNormal = WORLD_UP
	self.SurfaceTraversal_LastForward = self:GetForward()
	self.SurfaceTraversal_LastFacing = self:GetForward()
	self.SurfaceTraversal_AttachCooldown = 0
	self.SurfaceTraversal_TransitionCooldown = 0
	self.SurfaceTraversal_LastGroundPos = self:GetPos()
	self.SurfaceTraversal_LastGroundProgress = CurTime()
	self.SurfaceTraversal_JumpWasDown = false
	self.SurfaceTraversal_LastSafePos = Vector(self:GetPos().x, self:GetPos().y, self:GetPos().z)
	self.SurfaceTraversal_LastSafeTime = CurTime()
	self.SurfaceTraversal_RecoveryCooldown = 0
	self.SurfaceTraversal_Enabled = self.SurfaceTraversal_Enabled != false && !self.VJ_AVP_XenomorphLarge
	self:SetNW2Bool("VJ_AVP_SurfaceTraversal", false)
end

function ENT:SurfaceTraversal_CanUse()
	if !cvEnabled:GetBool() then return false end
	if self.SurfaceTraversal_Enabled == false or self.VJ_AVP_XenomorphLarge or self.CurrentSet == 2 then return false end
	if self.Dead or self.InFatality or self.DoingFatality or self.LongJumping then return false end
	if self.IsLatched or IsValid(self.Carrier) then return false end
	if self.IsCrawler or IsValid(self.Restraint) then return false end
	return true
end

function ENT:SurfaceTraversal_GetOffset(normal)
	if self.SurfaceTraversal_SurfaceOffset then return self.SurfaceTraversal_SurfaceOffset end
	local mins, maxs = self:GetCollisionBounds()
	local ex = math_max(math_abs(mins.x), math_abs(maxs.x))
	local ey = math_max(math_abs(mins.y), math_abs(maxs.y))
	local ez = math_max(math_abs(mins.z), math_abs(maxs.z))
	local n = normal or self.CurrentSurfaceNormal or WORLD_UP
	local extent = math_abs(n.x) * ex + math_abs(n.y) * ey + math_abs(n.z) * ez
	return math_Clamp(extent + 2, 10, 48)
end

local function OrderedBounds(mins, maxs)
	return Vector(
		math_min(mins.x, maxs.x),
		math_min(mins.y, maxs.y),
		math_min(mins.z, maxs.z)
	), Vector(
		math_max(mins.x, maxs.x),
		math_max(mins.y, maxs.y),
		math_max(mins.z, maxs.z)
	)
end

function ENT:SurfaceTraversal_GetSafetyHull()
	local mins, maxs = self:GetCollisionBounds()
	if !mins or !maxs then
		mins, maxs = Vector(-13, -13, 0), Vector(13, 13, 34)
	end
	mins, maxs = OrderedBounds(mins, maxs)

	local center = (mins + maxs) * 0.5
	local half = (maxs - mins) * 0.5
	half.x = math_max(2, half.x * 0.52)
	half.y = math_max(2, half.y * 0.52)
	half.z = math_max(2, half.z * 0.62)
	return center - half, center + half
end

function ENT:SurfaceTraversal_IsCoreClear(pos)
	if !pos or !util.IsInWorld(pos) then return false end
	local mins, maxs = self:SurfaceTraversal_GetSafetyHull()
	local tr = util.TraceHull({
		start = pos,
		endpos = pos,
		mins = mins,
		maxs = maxs,
		filter = self,
		mask = MASK_NPCSOLID_BRUSHONLY,
	})
	return !tr.StartSolid && !tr.AllSolid
end

function ENT:SurfaceTraversal_RecordSafePosition()
	local pos = self:GetPos()
	if self:SurfaceTraversal_IsCoreClear(pos) then
		self.SurfaceTraversal_LastSafePos = Vector(pos.x, pos.y, pos.z)
		self.SurfaceTraversal_LastSafeTime = CurTime()
		return true
	end
	return false
end

function ENT:SurfaceTraversal_RecoverIfEmbedded(curTime)
	if curTime < (self.SurfaceTraversal_RecoveryCooldown or 0) then return false end
	if self:SurfaceTraversal_IsCoreClear(self:GetPos()) then
		self:SurfaceTraversal_RecordSafePosition()
		return false
	end

	local badPos = self:GetPos()
	local safe = self.SurfaceTraversal_LastSafePos
	if safe && util.IsInWorld(safe) && safe:DistToSqr(badPos) <= (160 * 160) && self:SurfaceTraversal_IsCoreClear(safe) then
		self:SetPos(safe)
		self:SetLocalVelocity(ZERO)
		self.SurfaceTraversal_RecoveryCooldown = curTime + 0.20
		if cvDebug:GetBool() then
			DebugCross(badPos, 10, Color(255, 50, 50), 0.5)
			DebugCross(safe, 10, Color(50, 180, 255), 0.5)
		end

		if self.IsOnSurface then
			self:SurfaceTraversal_Detach(false, nil, true)
			self.SurfaceTraversal_AttachCooldown = curTime + 0.55
		end
		return true
	end

	if self.IsOnSurface then
		self:SurfaceTraversal_Detach(false, nil, true)
		self.SurfaceTraversal_AttachCooldown = curTime + 0.55
	end
	self.SurfaceTraversal_RecoveryCooldown = curTime + 0.20
	return true
end

function ENT:SurfaceTraversal_Trace(startPos, endPos, filter)
	local tr = util.TraceHull({
		start = startPos,
		endpos = endPos,
		mins = PROBE_MINS,
		maxs = PROBE_MAXS,
		filter = filter or self,
		mask = MASK_NPCSOLID,
	})
	DebugLine(startPos, endPos, tr.Hit && Color(255, 90, 90) or Color(90, 255, 90))
	if tr.Hit then DebugCross(tr.HitPos, 4, Color(255, 220, 50)) end
	return tr
end

function ENT:SurfaceTraversal_GetControllerFacingDirection(ply, normal)
	local lastFacing = self.SurfaceTraversal_LastFacing or self.SurfaceTraversal_LastForward or self:GetForward()
	local forward = ProjectOnPlane(ply:GetAimVector(), normal)
	if forward:LengthSqr() <= 0.04 then
		forward = ProjectOnPlane(lastFacing, normal)
	end
	if forward:LengthSqr() <= 0.001 then
		forward = ProjectOnPlane(self:GetForward(), normal)
	end
	return NormalizedOr(forward, lastFacing)
end

function ENT:SurfaceTraversal_GetControllerDirection(ply, normal)
	local moveF = (ply:KeyDown(IN_FORWARD) && 1 or 0) - (ply:KeyDown(IN_BACK) && 1 or 0)
	local moveR = (ply:KeyDown(IN_MOVERIGHT) && 1 or 0) - (ply:KeyDown(IN_MOVELEFT) && 1 or 0)
	if moveF == 0 && moveR == 0 then return ZERO, false end
	local forward = self:SurfaceTraversal_GetControllerFacingDirection(ply, normal)
	local right = forward:Cross(normal)
	right = NormalizedOr(right, self:GetRight())
	local dir = forward * moveF + right * moveR
	if dir:LengthSqr() <= 0.001 then return ZERO, false end
	return dir:GetNormalized(), true
end

function ENT:SurfaceTraversal_GetAIDirection(normal)
	local enemy = self:GetEnemy()
	if !IsValid(enemy) then return ZERO, false end

	local myPos = self:WorldSpaceCenter()
	local targetPos = enemy:WorldSpaceCenter()
	local toTarget = targetPos - myPos
	local dir = ProjectOnPlane(toTarget, normal)
	if dir:LengthSqr() <= 900 then
		local st = SurfaceType(normal)
		if st == "wall" then
			local verticalSign = (targetPos.z < myPos.z - 80) && -1 or 1
			dir = ProjectOnPlane(WORLD_UP * verticalSign, normal)
		elseif st == "ceiling" then
			local planar = Vector(toTarget.x, toTarget.y, 0)
			if planar:LengthSqr() < (110 * 110) && toTarget.z < -80 then
				return ZERO, false, true
			end
		end
	end

	if dir:LengthSqr() <= 0.001 then return ZERO, false end
	return dir:GetNormalized(), true, false
end

function ENT:SurfaceTraversal_GetSpeed(controller)
	local speed = self.SurfaceTraversal_Speed
	if !speed then
		speed = self:GetSequenceGroundSpeed(self:GetSequence())
		if !speed or speed < 100 then speed = 300 end
	end

	if IsValid(controller) && controller:KeyDown(IN_SPEED) then
		speed = speed * 1.4
	elseif !IsValid(controller) && self.AI_IsSprinting then
		speed = speed * 1.35
	end
	return math_Clamp(speed, 140, self.SurfaceTraversal_MaxSpeed or 700)
end

function ENT:SurfaceTraversal_SetTargetNormal(normal)
	if !normal or normal:LengthSqr() <= 0.5 then return end
	normal = normal:GetNormalized()
	if normal:Dot(self.SurfaceTraversal_TargetNormal or self.CurrentSurfaceNormal or WORLD_UP) < -0.985 then
		return
	end
	self.SurfaceTraversal_TargetNormal = normal
	self.SurfaceTraversal_TransitionCooldown = CurTime() + 0.08
end

function ENT:SurfaceTraversal_Attach(tr, travelDir)
	if !self:SurfaceTraversal_CanUse() or !IsUsableSurface(self, tr) then return false end
	local normal = tr.HitNormal:GetNormalized()
	if SurfaceType(normal) == "floor" then return false end

	self:SurfaceTraversal_RecordSafePosition()

	self.IsOnSurface = true
	self.Surface_IsMoving = true
	self.CurrentSurfaceNormal = normal
	self.SurfaceTraversal_TargetNormal = normal
	self.SurfaceTraversal_LastForward = NormalizedOr(ProjectOnPlane(travelDir or self:GetForward(), normal), self:GetForward())
	self.SurfaceTraversal_LastFacing = self.SurfaceTraversal_LastForward
	self.SurfaceTraversal_AttachCooldown = CurTime() + 0.2
	self.SurfaceTraversal_TransitionCooldown = CurTime() + 0.08
	self.SurfaceTraversal_LastGroundProgress = CurTime()

	if !self.AlwaysStand then
		self.CurrentSet = 1
		self.AnimTbl_Flinch = self.AnimTbl_FlinchCrouch or self.AnimTbl_Flinch
	end

	self:StopMoving()
	self:DoChangeMovementType(VJ_MOVETYPE_AERIAL)
	self:SetGroundEntity(NULL)
	self:CapabilitiesRemove(CAP_MOVE_GROUND)
	self:SetNW2Bool("VJ_AVP_SurfaceTraversal", true)

	local ang = GetSurfaceAngle(self, self.SurfaceTraversal_LastForward, normal, self:GetForward())
	self:SetAngles(ang)
	self:SetLocalVelocity(ZERO)
	return true
end

function ENT:SurfaceTraversal_Detach(landOnFloor, tr, preserveVelocity)
	if !self.IsOnSurface then return end
	local oldNormal = self.CurrentSurfaceNormal or WORLD_UP
	local oldForward = self.SurfaceTraversal_LastForward or self:GetForward()

	self.IsOnSurface = false
	self.Surface_IsMoving = false
	self.CurrentSurfaceNormal = WORLD_UP
	self.SurfaceTraversal_TargetNormal = WORLD_UP
	self.SurfaceTraversal_AttachCooldown = CurTime() + 0.35
	self.SurfaceTraversal_TransitionCooldown = 0
	self:SetNW2Bool("VJ_AVP_SurfaceTraversal", false)

	self:DoChangeMovementType(VJ_MOVETYPE_GROUND)
	self:CapabilitiesAdd(CAP_MOVE_GROUND)
	self:SetGroundEntity(NULL)

	local flatForward = Vector(oldForward.x, oldForward.y, 0)
	if flatForward:LengthSqr() <= 0.001 then
		flatForward = Vector(self:GetForward().x, self:GetForward().y, 0)
	end
	local yaw = flatForward:LengthSqr() > 0.001 && flatForward:Angle().y or self:GetAngles().y
	self:SetAngles(Angle(0, yaw, 0))

	if !preserveVelocity then
		if landOnFloor then
			local forward = Vector(oldForward.x, oldForward.y, 0)
			if forward:LengthSqr() > 0.001 then forward:Normalize() end
			self:SetLocalVelocity(forward * math_min(self:SurfaceTraversal_GetSpeed(nil), 300) + Vector(0, 0, -45))
		else
			self:SetLocalVelocity(oldNormal * 120 + Vector(0, 0, -100))
		end
	end
end

function ENT:SurfaceTraversal_FindTransition(moveDir, normal)
	local pos = self:GetPos()
	local lookAhead = self.SurfaceTraversal_LookAhead or 34
	local offset = self:SurfaceTraversal_GetOffset(normal)
	local front = self:SurfaceTraversal_Trace(pos + normal * 3, pos + normal * 3 + moveDir * lookAhead, self)
	if IsUsableSurface(self, front) then
		local n = front.HitNormal:GetNormalized()
		if n:Dot(normal) < 0.94 && n:Dot(moveDir) < -0.05 then
			return front, n, "concave"
		end
	end

	local predicted = pos + moveDir * lookAhead
	local supportStart = predicted + normal * (offset * 0.5 + 4)
	local supportEnd = predicted - normal * (offset + 28)
	local support = self:SurfaceTraversal_Trace(supportStart, supportEnd, self)
	if IsUsableSurface(self, support) then
		local n = support.HitNormal:GetNormalized()
		if n:Dot(normal) > 0.72 then
			return support, n, "same"
		end
		if n:Dot(normal) > -0.2 then
			return support, n, "transition"
		end
	end
	local right = moveDir:Cross(normal)
	right = NormalizedOr(right, self:GetRight())
	local probes = {
		-moveDir,
		moveDir,
		-normal,
		normal,
		right,
		-right,
		WORLD_UP,
		-WORLD_UP,
	}
	local bestTr, bestNormal, bestScore
	local probeOrigin = predicted + normal * math_min(offset, 12)
	local searchDist = self.SurfaceTraversal_EdgeSearchDistance or 48
	for i = 1, #probes do
		local probeDir = probes[i]
		local tr = self:SurfaceTraversal_Trace(probeOrigin, probeOrigin + probeDir * searchDist, self)
		if IsUsableSurface(self, tr) then
			local n = tr.HitNormal:GetNormalized()
			local similarity = n:Dot(normal)
			if similarity > -0.96 then
				local tangent = ProjectOnPlane(moveDir, n)
				local tangentScore = tangent:LengthSqr() > 0.001 && tangent:GetNormalized():Dot(moveDir) or -1
				local changeBonus = 1 - math_abs(similarity)
				local score = (1 - tr.Fraction) * 1.2 + tangentScore * 0.55 + changeBonus * 0.35
				if !bestScore or score > bestScore then
					bestScore = score
					bestTr = tr
					bestNormal = n
				end
			end
		end
	end

	if bestTr then return bestTr, bestNormal, "convex" end
	return nil
end

function ENT:SurfaceTraversal_FindGroundEdgeWall(moveDir)
	if !moveDir or moveDir:LengthSqr() <= 0.001 then return nil end

	local dir = Vector(moveDir.x, moveDir.y, 0)
	if dir:LengthSqr() <= 0.001 then return nil end
	dir:Normalize()

	local pos = self:GetPos()
	local mins, maxs = self:GetCollisionBounds()
	local horizontalExtent = math_max(math_abs(mins.x), math_abs(maxs.x), math_abs(mins.y), math_abs(maxs.y))
	local lookAhead = math_Clamp(horizontalExtent + 14, 28, 52)
	local floorStart = pos + dir * lookAhead + WORLD_UP * 18
	local floorProbe = self:SurfaceTraversal_Trace(floorStart, floorStart - WORLD_UP * 58, self)
	if IsUsableSurface(self, floorProbe) && SurfaceType(floorProbe.HitNormal:GetNormalized()) == "floor" then
		return nil
	end

	local outside = pos + dir * (lookAhead + 14)
	local depths = {-6, -16, -28, -42, -58}
	local backDistance = lookAhead + 46
	for i = 1, #depths do
		local startPos = outside + WORLD_UP * depths[i]
		local tr = self:SurfaceTraversal_Trace(startPos, startPos - dir * backDistance, self)
		if IsUsableSurface(self, tr) then
			local n = tr.HitNormal:GetNormalized()
			if SurfaceType(n) == "wall" && n:Dot(dir) > 0.2 then
				local downWall = ProjectOnPlane(-WORLD_UP, n)
				downWall = NormalizedOr(downWall, ProjectOnPlane(moveDir, n))
				return tr, downWall
			end
		end
	end

	return nil
end

function ENT:SurfaceTraversal_ShouldSuppressLedgeAssist(moveDir)
	if self.IsOnSurface then return true end
	if !self:SurfaceTraversal_CanUse() then return false end
	if !IsValid(self.VJ_TheController) or !cvController:GetBool() then return false end

	local tr = self:SurfaceTraversal_FindGroundEdgeWall(moveDir)
	return tr != nil
end

function ENT:SurfaceTraversal_UpdateAttached(curTime, controller)
	if self:SurfaceTraversal_RecoverIfEmbedded(curTime) then return end
	if !self.AlwaysStand then self.CurrentSet = 1 end
	if self:GetMoveType() != MOVETYPE_FLY then
		self:DoChangeMovementType(VJ_MOVETYPE_AERIAL)
	end
	self:CapabilitiesRemove(CAP_MOVE_GROUND)
	self:SetGroundEntity(NULL)

	local normal = self.CurrentSurfaceNormal or WORLD_UP
	local targetNormal = self.SurfaceTraversal_TargetNormal or normal
	local blend = math_Clamp(FrameTime() * (self.SurfaceTraversal_NormalLerp or 10), 0, 1)
	local blended = LerpVector(blend, normal, targetNormal)
	if blended:LengthSqr() > 0.5 then
		blended:Normalize()
		normal = blended
		self.CurrentSurfaceNormal = normal
	end

	local moveDir, moving, wantsDrop
	if IsValid(controller) then
		moveDir, moving = self:SurfaceTraversal_GetControllerDirection(controller, normal)
		local jumpDown = controller:KeyDown(IN_JUMP)
		if jumpDown && !self.SurfaceTraversal_JumpWasDown then wantsDrop = true end
		self.SurfaceTraversal_JumpWasDown = jumpDown
	else
		moveDir, moving, wantsDrop = self:SurfaceTraversal_GetAIDirection(normal)
	end

	if wantsDrop then
		self:SurfaceTraversal_Detach(false)
		return
	end

	local offset = self:SurfaceTraversal_GetOffset(normal)
	local supportStart = self:GetPos() + normal * 6
	local supportEnd = self:GetPos() - normal * (offset + 38)
	local support = self:SurfaceTraversal_Trace(supportStart, supportEnd, self)
	local hasSupport = IsUsableSurface(self, support)
	local adhesion = ZERO
	if hasSupport then
		local supportNormal = support.HitNormal:GetNormalized()
		local dist = math_abs((self:GetPos() - support.HitPos):Dot(normal))
		local correction = math_Clamp((offset - dist) * 11, -190, 190)
		adhesion = normal * correction
		if supportNormal:Dot(normal) > 0.60 then
			self:SurfaceTraversal_SetTargetNormal(supportNormal)
		end
	end

	local busy = self:IsBusy("Activities")
	if busy then moving = false end

	if !moving then
		self.Surface_IsMoving = false
		local holdForward
		if IsValid(controller) then
			holdForward = self:SurfaceTraversal_GetControllerFacingDirection(controller, normal)
		else
			holdForward = ProjectOnPlane(self.SurfaceTraversal_LastFacing or self.SurfaceTraversal_LastForward or self:GetForward(),normal)
		end
		holdForward = NormalizedOr(holdForward,self.SurfaceTraversal_LastFacing or self.SurfaceTraversal_LastForward or self:GetForward())
		self.SurfaceTraversal_LastFacing = holdForward
		local desiredAng = GetSurfaceAngle(self, holdForward, normal, self:GetForward())
		self:SetAngles(LerpAngle(math_Clamp(FrameTime() * (self.SurfaceTraversal_AngleLerp or 12), 0, 1),self:GetAngles(),desiredAng))
		self:SetLocalVelocity(adhesion)
		if !hasSupport && curTime > (self.SurfaceTraversal_AttachCooldown or 0) then
			self:SurfaceTraversal_Detach(false)
			return
		end
		if !busy && self:GetIdealActivity() != ACT_IDLE then
			self:ResetIdealActivity(ACT_IDLE)
		end
		return
	end

	moveDir = ProjectOnPlane(moveDir, normal)
	if moveDir:LengthSqr() <= 0.001 then
		self.Surface_IsMoving = false
		self:SetLocalVelocity(adhesion)
		return
	end
	moveDir:Normalize()

	local transitionTr, transitionNormal, transitionKind = self:SurfaceTraversal_FindTransition(moveDir, normal)
	if transitionTr then
		if SurfaceType(transitionNormal) == "floor" then
			self.SurfaceTraversal_LastForward = moveDir
			self:SurfaceTraversal_Detach(true, transitionTr)
			return
		end
		if transitionKind != "same" or transitionNormal:Dot(normal) < 0.995 then
			self:SurfaceTraversal_SetTargetNormal(transitionNormal)
		end
	else
		if curTime > (self.SurfaceTraversal_AttachCooldown or 0) then
			self:SurfaceTraversal_Detach(false)
			return
		end
	end

	local orientNormal = self.CurrentSurfaceNormal or normal
	moveDir = ProjectOnPlane(moveDir, orientNormal)
	moveDir = NormalizedOr(moveDir, self.SurfaceTraversal_LastForward or self:GetForward())
	self.SurfaceTraversal_LastForward = moveDir
	local faceDir
	if IsValid(controller) then
		faceDir = self:SurfaceTraversal_GetControllerFacingDirection(controller, orientNormal)
	else
		faceDir = moveDir
	end
	faceDir = ProjectOnPlane(faceDir, orientNormal)
	faceDir = NormalizedOr(faceDir,self.SurfaceTraversal_LastFacing or moveDir)
	self.SurfaceTraversal_LastFacing = faceDir
	local desiredAng = GetSurfaceAngle(self,faceDir,orientNormal,self:GetForward())
	self:SetAngles(LerpAngle(math_Clamp(FrameTime() * (self.SurfaceTraversal_AngleLerp or 12), 0, 1),self:GetAngles(),desiredAng))

	self.Surface_IsMoving = true
	local speed = self:SurfaceTraversal_GetSpeed(controller)
	self:SetLocalVelocity(moveDir * speed + adhesion)
	if self:GetIdealActivity() != ACT_RUN then
		self:ResetIdealActivity(ACT_RUN)
	end
end

function ENT:SurfaceTraversal_TryGroundAttach(curTime, controller)
	if curTime < (self.SurfaceTraversal_AttachCooldown or 0) then return false end
	if !self:SurfaceTraversal_CanUse() then return false end

	local dir, moving
	local radialSearch = false
	local verticalSign = 1
	if IsValid(controller) then
		if !cvController:GetBool() then return false end
		dir, moving = self:SurfaceTraversal_GetControllerDirection(controller, WORLD_UP)
	else
		if !cvAI:GetBool() then return false end
		local enemy = self:GetEnemy()
		if !IsValid(enemy) or self:IsBusy("Activities") then return false end

		local velocity = self:GetMoveVelocity()
		if velocity:LengthSqr() > 400 then
			dir = Vector(velocity.x, velocity.y, 0)
		else
			local toEnemy = enemy:WorldSpaceCenter() - self:WorldSpaceCenter()
			dir = Vector(toEnemy.x, toEnemy.y, 0)
		end
		moving = self:DoingMovement()

		local pos = self:GetPos()
		if pos:DistToSqr(self.SurfaceTraversal_LastGroundPos or pos) > (18 * 18) then
			self.SurfaceTraversal_LastGroundPos = pos
			self.SurfaceTraversal_LastGroundProgress = curTime
		end
		local enemyHeight = enemy:WorldSpaceCenter().z - self:WorldSpaceCenter().z
		verticalSign = enemyHeight < -90 && -1 or 1
		local stuck = moving && (curTime - (self.SurfaceTraversal_LastGroundProgress or curTime)) > 0.55
		local verticalTarget = math_abs(enemyHeight) > 90
		radialSearch = stuck or verticalTarget
		moving = moving or radialSearch
		if !moving then return false end

		if !dir or dir:LengthSqr() <= 0.001 then
			dir = Vector(self:GetForward().x, self:GetForward().y, 0)
		end
	end

	if !moving or !dir or dir:LengthSqr() <= 0.001 then return false end
	dir:Normalize()

	local edgeTr, edgeTravel = self:SurfaceTraversal_FindGroundEdgeWall(dir)
	if edgeTr then
		return self:SurfaceTraversal_Attach(edgeTr, edgeTravel)
	end

	local startPos = self:GetPos() + Vector(0, 0, math_min(self:OBBMaxs().z * 0.35, 24))
	local distance = self.SurfaceTraversal_AttachDistance or 48
	local traceFilter = IsValid(controller) && {self, controller} or self
	local tr = self:SurfaceTraversal_Trace(startPos, startPos + dir * distance, traceFilter)

	if !IsUsableSurface(self, tr) && radialSearch then
		local best
		for i = 0, 7 do
			local a = math.rad(i * 45)
			local probeDir = Vector(math.cos(a), math.sin(a), 0)
			local probe = self:SurfaceTraversal_Trace(startPos, startPos + probeDir * distance, self)
			if IsUsableSurface(self, probe) && SurfaceType(probe.HitNormal) != "floor" then
				if !best or probe.Fraction < best.Fraction then best = probe end
			end
		end
		if best then tr = best end
	end

	if !IsUsableSurface(self, tr) then return false end
	local normal = tr.HitNormal:GetNormalized()
	if SurfaceType(normal) == "floor" then return false end

	local intoSurface = -normal
	if intoSurface:Dot(dir) < 0.1 && !radialSearch then return false end
	local attachTravel = ProjectOnPlane(dir, normal)
	if attachTravel:LengthSqr() <= 0.01 or radialSearch then
		attachTravel = ProjectOnPlane(WORLD_UP * verticalSign, normal)
	end
	attachTravel = NormalizedOr(attachTravel, self:GetForward())

	return self:SurfaceTraversal_Attach(tr, attachTravel)
end

function ENT:SurfaceTraversal_Update(curTime)
	if !self.SurfaceTraversal_Enabled then return end
	if !self:SurfaceTraversal_CanUse() then
		if self.IsOnSurface then self:SurfaceTraversal_Detach(false, nil, true) end
		return
	end

	local controller = self.VJ_TheController
	if self.IsOnSurface then
		if IsValid(controller) && !cvController:GetBool() then
			self:SurfaceTraversal_Detach(false)
			return
		elseif !IsValid(controller) && !cvAI:GetBool() then
			self:SurfaceTraversal_Detach(false)
			return
		end
		self:SurfaceTraversal_UpdateAttached(curTime, controller)
	else
		self:SurfaceTraversal_RecordSafePosition()
		self:SurfaceTraversal_TryGroundAttach(curTime, controller)
	end
end
