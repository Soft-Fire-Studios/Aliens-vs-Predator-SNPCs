if SERVER then return end

local cvYaw = GetConVar("m_yaw")
local cvPitch = GetConVar("m_pitch")
local rad = math.rad
local deg = math.deg
local asin = math.asin
local clamp = math.Clamp
local cos = math.cos
local sin = math.sin

local function ProjectOnPlane(vec, normal)
	return vec - normal * vec:Dot(normal)
end

local function NormalizeOr(vec, fallback)
	if vec:LengthSqr() <= 0.0001 then
		return fallback:GetNormalized()
	end
	return vec:GetNormalized()
end

local function RotateAroundAxis(vec, axis, degrees)
	axis = axis:GetNormalized()
	local a = rad(degrees)
	local c = cos(a)
	local s = sin(a)
	return vec * c + axis:Cross(vec) * s + axis * (axis:Dot(vec) * (1 - c))
end

local function GetControlledNPC(ply)
	if !IsValid(ply) or !ply.VJ_IsControllingNPC then return nil end
	local controlEnt = ply.VJ_TheControllerEntity
	if !IsValid(controlEnt) then return nil end
	if controlEnt.GetNPC then
		local npc = controlEnt:GetNPC()
		if IsValid(npc) then return npc end
	end
	return IsValid(controlEnt.VJCE_NPC) && controlEnt.VJCE_NPC or nil
end

local function ResetLookState(ply)
	if IsValid(ply) then
		ply.VJ_AVP_SurfaceLookState = nil
	end
end

hook.Add("InputMouseApply","VJ_AVP_SurfaceLocalMouse",function(cmd, mouseX, mouseY, viewAng)
	local ply = LocalPlayer()
	local npc = GetControlledNPC(ply)
	if !IsValid(npc) or !npc.VJ_AVP_Xenomorph or !npc:GetNW2Bool("VJ_AVP_SurfaceTraversal", false) then
		ResetLookState(ply)
		return
	end
	local surfaceUp = npc:GetUp()
	if surfaceUp:LengthSqr() <= 0.5 then
		ResetLookState(ply)
		return
	end
	surfaceUp:Normalize()
	local state = ply.VJ_AVP_SurfaceLookState
	if !state or state.NPC != npc then
		local aimForward = viewAng:Forward()
		local projected = ProjectOnPlane(aimForward, surfaceUp)
		local projectedLenSqr = projected:LengthSqr()
		local heading
		local localPitch
		if projectedLenSqr <= 0.02 then
			heading = ProjectOnPlane(npc:GetForward(), surfaceUp)
			heading = NormalizeOr(heading, npc:GetForward())
			localPitch = 0
		else
			heading = projected:GetNormalized()
			localPitch = -deg(asin(clamp(aimForward:GetNormalized():Dot(surfaceUp), -1, 1)))
			localPitch = clamp(localPitch, -85, 85)
		end
		state = {
			NPC = npc,
			Heading = heading,
			Pitch = localPitch,
			Up = surfaceUp,
		}
		ply.VJ_AVP_SurfaceLookState = state
	else
		if !state.Up or state.Up:Dot(surfaceUp) < 0.9995 then
			local transported = ProjectOnPlane(state.Heading, surfaceUp)
			if transported:LengthSqr() <= 0.001 then
				transported = ProjectOnPlane(npc:GetForward(), surfaceUp)
			end
			state.Heading = NormalizeOr(transported, npc:GetForward())
			state.Up = surfaceUp
		end
	end

	local yawDelta = -mouseX * (cvYaw && cvYaw:GetFloat() or 0.022)
	local pitchDelta = mouseY * (cvPitch && cvPitch:GetFloat() or 0.022)
	if yawDelta != 0 then
		state.Heading = RotateAroundAxis(state.Heading, surfaceUp, yawDelta)
		state.Heading = NormalizeOr(ProjectOnPlane(state.Heading, surfaceUp), npc:GetForward())
	end
	state.Pitch = clamp((state.Pitch or 0) + pitchDelta, -85, 85)
	local right = state.Heading:Cross(surfaceUp)
	right = NormalizeOr(right, npc:GetRight())
	local lookForward = RotateAroundAxis(state.Heading, right, -(state.Pitch or 0))
	lookForward:Normalize()
	local newAng = lookForward:Angle()
	cmd:SetViewAngles(newAng)
	return true
end)
