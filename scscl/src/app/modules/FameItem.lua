--data_skill
--@param[id]	
--@param[name]	
--@param[des]			技能描述
--@param[bZd]			是否正道修为
--@param[bXd]			是否邪道修为
--@param[xw_add]		对修为的增长(字符串格式","分隔具体数值不是比例)
local FameItem = class("FameItem")

function FameItem:ctor(data)
	self.m_dId = data.id
	self.m_dZdName = data.zd_name
	self.m_dXdName = data.xd_name
	self.m_dNeed = data.need
	self.m_dMqAdd = data.mq_add
	self.m_dDes = data.des
end

function FameItem:getId()
	return self.m_dId
end

function FameItem:getZDName()
	return self.m_dZdName
end

function FameItem:getXDName()
	return self.m_dXdName
end

function FameItem:getNeeds()
	return self.m_dNeed
end

function FameItem:getMqAdd()
	return self.m_dMqAdd
end

function FameItem:getDescription()
	return self.m_dDes
end

return FameItem