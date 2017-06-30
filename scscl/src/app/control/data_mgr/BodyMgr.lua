local BodyMgr = class("BodyMgr")

function BodyMgr:ctor()

	self:_init()
end

function BodyMgr:_init()

end

--提升身体等级(暂时只能提升每次修炼的基数)
function XiulianData:upBodyLevel()
	self.m_dBodyLevel = self.m_dBodyLevel + 1
	self.m_cLevelMgr:updateOnceAddExp(self.m_dBodyData[self.m_dBodyLevel]:getAdditonalExp())
end

--检测是否可以升级体质
function XiulianData:checkUpBoyLevel()
	local nextNeed = self.m_dBodyData[self.m_dBodyLevel + 1]
	if self.m_cLevelMgr:getCurrentExp() >= nextNeed then
		--可以升级身体
		GlobalEvent:fireEvent(GlobalEventIds.kXLIsUpBody, {data = true})
	else
		GlobalEvent:fireEvent(GlobalEventIds.kXLIsUpBody, {data = false})
	end
end

return BodyMgr