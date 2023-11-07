if CLIENT then
    function ENT:VM_Initialize(mdl,ply)
        local vm = self.VM
        if !IsValid(ply) then return end
        if IsValid(vm) then return end

        vm = ClientsideModel(mdl, RENDERGROUP_BOTH)
        local pos = ply:GetShootPos()
        local ang = ply:EyeAngles()
        vm:SetPos(pos)
        vm:SetAngles(ang)
        -- vm:SetNoDraw(true)
        -- vm:SetParent(self)
        vm.CurrentAnimTime = 0
        self.VM = vm
        return vm
    end
end

function ENT:VM_SetModel(mdl)
    local vm = self.VM
    if !IsValid(vm) then return end

    vm:SetModel(mdl)
end

function ENT:VM_GetModel(mdl)
    local vm = self.VM
    if !IsValid(vm) then return end

    return vm:GetModel()
end

function ENT:VM_PlayAnimation(anim,rate)
    local vm = self.VM
    if !IsValid(vm) then return end
    
    if isnumber(anim) then
        anim = vm:GetSequenceName(vm:SelectWeightedSequence(anim))
    end
	vm:ResetSequenceInfo()
    vm:ResetSequence(vm:LookupSequence(anim))
	vm:SetCycle(0)
    vm:SetPlaybackRate(rate)

    local dur = VJ.AnimDuration(vm,anim) or 0.25
    vm.CurrentAnimTime = CurTime() +dur
    return dur
end