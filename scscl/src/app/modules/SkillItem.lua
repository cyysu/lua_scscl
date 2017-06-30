--data_skill
--@param[id]	
--@param[name]	
--@param[des]			技能描述
--@param[bZd]			是否正道修为
--@param[bXd]			是否邪道修为
--@param[xw_add]		对修为的增长(字符串格式","分隔具体数值不是比例)

local SkillItem = class("SkillItem")

function SkillItem:ctor(data)
	self.m_dSkillId = data.id or -1
	self.m_dName = data.name or "error"
	self.m_dDes = data.des or -1
	self.m_bZd = data.bZd or false
	self.m_bXd = data.bXd or false
	self.m_arrZdExpAdds = string.split(data.xw_add, ",")
end

function SkillItem:getId()
	return self.m_dSkillId
end

function SkillItem:getName()
	return self.m_dName
end

function SkillItem:getDescription()
	return self.m_dDes
end

function SkillItem:isZD()
	return self.m_bZd
end

function SkillItem:isXD()
	return self.m_bXd
end

function SkillItem:getExpAddArray()
	return self.m_arrZdExpAdds
end

return SkillItem