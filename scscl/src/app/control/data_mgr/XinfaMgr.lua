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
function XinfaMgr:_randXinfa()
	-- for _,item in pairs(self.m_dData) do
	-- 	local xfStyle = item:getStyle()
	-- 	local ret = true
	-- 	for style,v in pairs(self.m_dMines) do
	-- 		if style == xfStyle then
	-- 			ret = false
	-- 		end
	-- 	end
	-- 	if ret then
	-- 		return item
	-- 	end
	-- end
	local idx = math.random(1, #self.m_dData)
	local xfItem = self.m_dData[idx]
	for style,v in pairs(self.m_dMines) do
		if style == xfItem:getStyle() then
			return false
		end
	end
	return xfItem
end

function XinfaMgr:addXinfa(xfItem)
	local xfItem = self:_randXinfa()
	dump(xfItem)
	if xfItem then
		self.m_dMines[xfItem:getStyle()] = {level = 1, id = xfItem:getId()}
		--学习的心法对修炼的加成
		XiulianDataMgr:updateAutoOnceAddExp(xfItem:getExpAddByLevel(1))
		--添加一条记录
		XiulianDataMgr:getRecordMgr():addMessage("您修习了心法: " .. xfItem:getName())
		--通知界面学习了一种心法
		GlobalEvent:fireEvent(GlobalEventIds.kXLXinfa, {data = xfItem:getStyle(), add = true})
	else
		--学习到了同属性心法
		XiulianDataMgr:getRecordMgr():addMessage("您不能修习同属性的心法!")
	end
end

function XinfaMgr:removeXinfa(xfStyle)
	local xfItem = self.m_dData[self.m_dMines[xfStyle].id]
	if xfItem then
		--添加一条记录
		XiulianDataMgr:getRecordMgr():addMessage("您废弃了心法: " .. xfItem:getName())
	end
	self.m_dMines[xfStyle] = nil
	GlobalEvent:fireEvent(GlobalEventIds.kXLXinfa, {data = xfItem:getStyle(), remove = true})
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

--金木水火土 5种（1，2，3，4，5）
function XinfaMgr:getMineXinfaByIdx(idx)
	return self.m_dMines[idx]
end

function XinfaMgr:getXinfaNum()
	return #self.m_dMines
end

return XinfaMgr