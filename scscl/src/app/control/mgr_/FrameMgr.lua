local data_fame = require("app.models.local_data.data_fame")
local FrameMgr = class("FrameMgr")

function FrameMgr:ctor()
	self.m_dLevel = 1 				--称号等级
	self.m_dName = "初入江湖"
	self.m_dCurrentFame = 0 		--当前名气
	self.m_dMqAdd = 0
	self.m_dNeed = 0
end

function FrameMgr:update(dt)
	self.m_dCurrentFame = self.m_dCurrentFame + self.m_dMqAdd
	self:_updateLevel()

	GlobalEvent:fireEvent(GlobalEventIds.kUpdateFame, {
		fame = self.m_dCurrentFame, 
		add = self.m_dMqAdd,
		title = self.m_dName
	})
end

function FrameMgr:_updateLevel()
	local data = data_fame[self.m_dLevel]
	if self.m_dCurrentFame > data.need then
		self.m_dLevel = self.m_dLevel + 1
		local data = data_fame[self.m_dLevel]

		self.m_dMqAdd = self.m_dMqAdd + data.mq_add
		self.m_dName = data.zd_name
		self.m_dNeed = data.need

		--XiulianMgr:changeTotalLifeValue(data.lf_add)
	end
end

--更新名气增长值
function FrameMgr:changeMqAdd(mq)
	self.m_dMqAdd = self.m_dMqAdd + mq
end

return FrameMgr