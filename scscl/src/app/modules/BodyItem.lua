--data_body
--@param[level]	
--@param[des]	
--@param[addl]			对每次修炼修为的附加
--@param[up_need]		升到下一级所需
--@param[title]			体质名称
local BodyItem = class("BodyItem")

function BodyItem:ctor(data)
	self.m_dLevel = data.level or -1
	self.m_dDes = data.des or "error"
	self.m_dAddl = data.addl or 0
	self.m_dUpNeed = data.up_need or 0
	self.m_dName = data.title or ""
end

function BodyItem:getLevel()
	return self.m_dLevel
end

function BodyItem:getDescription()
	return self.m_dDes
end

function BodyItem:getAdditonalExp()
	return self.m_dAddl
end

function BodyItem:getUpNeed()
	return self.m_dUpNeed
end

function BodyItem:getName()
	return self.m_dName
end

return BodyItem