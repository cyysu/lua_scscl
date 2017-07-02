local data_body = require("app.data.data_body")
local BodyItem = require('app.modules.BodyItem')
local BodyMgr = class("BodyMgr")

function BodyMgr:ctor()
	self.m_dDatas = {}
	self.m_dBodyLevel = 0
	self.m_bTip = false 		--已经有正在提升的升级

	self:_init()
end

function BodyMgr:_init()
	for idx, data in pairs(data_body) do
		self.m_dDatas[data.level] = BodyItem.new(data)
	end
end

function BodyMgr:updateBody(dt)
	self:_checkUpBoyLevel()
end

--提升身体等级(暂时只能提升每次修炼的基数)
function BodyMgr:upBodyLevel()
	self.m_dBodyLevel = self.m_dBodyLevel + 1
	local bodyItem = self.m_dDatas[self.m_dBodyLevel]
	--升级体质需要扣除的修为
	XiulianDataMgr:getLevelMgr():updateCurrentExp(-bodyItem:getUpNeed())
	--体质提升对修为的增长基数
	XiulianDataMgr:getLevelMgr():updateOnceAddExp(bodyItem:getAdditonalExp())
	--更新体质升级后的名称界面变化
	GlobalEvent:fireEvent(GlobalEventIds.kXLUpBody, {data = bodyItem:getName()})
	--增加体质升级的record记录
	XiulianDataMgr:getRecordMgr():addMessage("您的体质提升到了 " .. bodyItem:getName())
end

--检测是否可以升级体质
function BodyMgr:_checkUpBoyLevel()
	local nextNeed = self.m_dDatas[self.m_dBodyLevel + 1]:getUpNeed()
	local nextLevel = self.m_dBodyLevel + 1
	if XiulianDataMgr:getLevelMgr():getCurrentExp() >= nextNeed then
		if not self.m_bTip then
			self.m_bTip = true
			--提示界面可以升级体质
			GlobalEvent:fireEvent(GlobalEventIds.kXLIsUpBody, {data = true})
			--增加record记录 提示可以升级体质
			XiulianDataMgr:getRecordMgr():addMessage("您现在可以继续提升体质了")
		end
	else
		if self.m_bTip then
			self.m_bTip = false
			GlobalEvent:fireEvent(GlobalEventIds.kXLIsUpBody, {data = false})
		end
	end
end

return BodyMgr