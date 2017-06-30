--data_level
--@param[id]	
--@param[name]	
--@param[des]			境界描述
--@param[xw_add]		单个整数
--@param[mq_add]		单个整数
local LevelItem = class("LevelItem")

function LevelItem:ctor(data)
	self.m_dId = data.id or -1			
	self.m_dName = data.name or "error"
	self.m_dNeed = data.need or -1
	self.m_dXwAdd = data.xw_add
	self.m_dMqAdd = data.mq_add
end

function LevelItem:getId()
	return self.m_dId
end

function LevelItem:getName()
	return self.m_dName
end

function LevelItem:getNeeds()
	return self.m_dNeed
end

function LevelItem:getMqAdd()
	return self.m_dMqAdd
end

function LevelItem:getXwAdd()
	return self.m_dXwAdd
end

return LevelItem