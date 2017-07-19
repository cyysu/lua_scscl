local level_data = require("app.models.local_data.data_level")
local LevelMgr = class("LevelMgr")

function LevelMgr:ctor()
	self.m_dLevel = 1
	self.m_dName = ""	--当前等级对应的境界名称
	self.m_dNeed = 0 	--当前等级升级需要的经验

	self.m_dCurrentExp = 0
	self.m_dExpAdd = 1
end

function LevelMgr:update(dt)
	self.m_dCurrentExp = self.m_dCurrentExp + self.m_dExpAdd
	self:_updateLevel()

	local subNeed = level_data[self.m_dLevel-1] and level_data[self.m_dLevel-1].need or 0
	local data = {
		cexp = self.m_dCurrentExp,
		cneed = self.m_dNeed,
		cname = self.m_dName
	}
	GlobalEvent:fireEvent(GlobalEventIds.kUpdateExp, data)
end

function LevelMgr:_updateLevel()
	local xltype = XiulianMgr:getXiulianType()
	local data = level_data[self.m_dLevel]
	self.m_dName = xltype == GameEnum.XiulianType.cm and data.cm_name  or data.jd_name

	if self.m_dCurrentExp > data.need then
		self.m_dLevel = self.m_dLevel + 1
		local data = level_data[self.m_dLevel]

		self.m_dExpAdd = self.m_dExpAdd + data.xw_add
		self.m_dName = xltype == GameEnum.XiulianType.cm and data.cm_name  or data.jd_name
		self.m_dNeed = data.need

		XiulianMgr:getFrameMgr():changeMqAdd(data.mq_add)
		XiulianMgr:changeTotalLifeValue(data.lf_add)
	end
end

function LevelMgr:changeExpAdd(exp)
	self.m_dExpAdd = self.m_dExpAdd + exp
end

function LevelMgr:getNeed()
	return self.m_dNeed
end

return LevelMgr