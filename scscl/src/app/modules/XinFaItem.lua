--data_xinfa
--@param[id]	
--@param[name]	
--@param[style]			属性，指金木水火土
--@param[des]			技能描述
--@param[bmul]			对修为的增长是否是倍数关系
--@param[xw_add]		对修为的增长(字符串格式","分隔具体数值不是比例)
--@param[xw_need]		升级所需
local XinFaItem = class("XinFaItem")

function XinFaItem:ctor(data)
	self.m_dId = data.id
	self.m_dName = data.name
	self.m_dStyle = data.style
	self.m_bMul = data.bmul
	self.m_dDes = data.des
	self.m_dExpAdds = string.split(data.xw_add, ",")
	self.m_dNeeds = string.split(data.wx_need, ",")
end

function XinFaItem:getId()
	return self.m_dId
end

function XinFaItem:getName()
	return self.m_dName
end

function XinFaItem:getStyle()
	return self.m_dStyle
end

function XinFaItem:isMul()
	return self.m_bMul == 1
end

function XinFaItem:getDescription()
	return self.m_dDes
end

function XinFaItem:getExpAdds()
	return self.m_dExpAdds
end

function XinFaItem:getLevels()
	return #self.m_dExpAdds
end

--根据等级获取当前对修为的附加
function XinFaItem:getExpAddByLevel(level)
	return tonumber(self.m_dExpAdds[level])
end

function XinFaItem:getNeeds()
	return self.m_dNeeds
end

--根据等级获取下一个等级升级所需
function XinFaItem:getNextLeveNeedByLevel(level)
	return tonumber(self.m_dNeeds[level])
end

return XinFaItem