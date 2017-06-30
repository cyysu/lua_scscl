local data_xinfa = require("app.data.data_xinfa")
local XinFaItem = require('app.modules.XinFaItem')

local XinfaMgr = class("XinfaMgr")

function XinfaMgr:ctor()
	self.m_dData = {}
	self.m_dMines = {}  --{level}

	self:_init()
end

function XinfaMgr:_init()
	for idx,data in pairs(data_xinfa) do
		local xinfaItem = XinFaItem.new(data)
		self.m_dData[xinfaItem:getId()] = xinfaItem
	end
end

--随机一本心法(排除同属性)
function XinfaMgr:randXinfa()
	local xfs = {}
	for _,item in pairs(self.m_dData) do
		local xfStyle = item:getStyle()
		local ret = true
		for style,v in pairs(self.m_dMines) do
			if style == xfStyle then
				break
			end
		end
		return item
	end
end

function XinfaMgr:addXinfa(xfItem)
	self.m_dMines[xfItem:getStyle()] = {level = 1, id = xfItem:getId()}
	XiulianDataMgr:updateAutoOnceAddExp(xfItem:getExpAddByLevel(1))
end

function XinfaMgr:removeXinfa(xfStyle)
	self.m_dMines[xfStyle] = nil
end

function XinfaMgr:upXinfaLevel(xfStyle)
	local xf = self.m_dMines[xfStyle]
	local xfItem = self.m_dData[xf.id]
	local level = xf.level + 1
	if level >= xfItem:getLevels() then
		ww.printfd("error: 该心法已经升到最高等级,不应该再升级 skill_id: ", skillId)
	else
		XiulianDataMgr:updateAutoOnceAddExp(xfitem:getExpAddByLevel(level))
		self.m_dMines[xfStyle] = xf
	end
end

function XinfaMgr:getXinfaNum()
	return #self.m_dMines
end

return XinfaMgr