local LifeMgr = class("LifeMgr")

function LifeMgr:ctor()
	self.m_dCurrentLife = 0  	--已经活了
	self.m_dSurLife = 0 		--剩余寿元
end

function LifeMgr:_init()

end

function LifeMgr:updateLife(dt)
	self:changeCurrentLife(1)
end

function LifeMgr:changeCurrentLife(life)
	self.m_dCurrentLife = self.m_dCurrentLife + life
	self:_fireXiulianLife()
end

function LifeMgr:changeSurLife(life)
	self.m_dSurLife = self.m_dSurLife + life
end

--反馈给界面
function LifeMgr:_fireXiulianLife()
	local lifeStr = string.format("%d/%d", self.m_dSurLife, self.m_dCurrentLife)
	GlobalEvent:fireEvent(GlobalEventIds.kXLLife, {data = lifeStr})
end

return LifeMgr