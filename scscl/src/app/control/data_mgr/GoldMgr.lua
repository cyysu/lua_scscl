local GoldMgr = class("GoldMgr")

function GoldMgr:ctor()
	self.m_dCurrentGold = 0
	self.m_dGoldAdd = 1
end

function GoldMgr:_init()

end

function GoldMgr:updateGold(dt)
	self.m_dCurrentGold = self.m_dCurrentGold + self.m_dGoldAdd
	GlobalEvent:fireEvent(GlobalEventIds.kXLGold, {data = self.m_dCurrentGold})
end

return GoldMgr