function EFFECT:Init( data )
	self.Position = data:GetStart()
	self.WeaponEnt = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.StartPos = self:GetTracerShootPos(self.Position,self.WeaponEnt,self.Attachment)
	self.EndPos = data:GetOrigin()
	util.ParticleTracerEx("vj_avp_tracer",self.StartPos,self.EndPos,1,0,-1)
end

function EFFECT:Render()
	return false
end