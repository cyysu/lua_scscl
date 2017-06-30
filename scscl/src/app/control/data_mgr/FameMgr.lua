--[[
	*名气管理
	*对应江湖称号
	*称号对修炼的加成
	*称号对财富的加成
]]
local data_fame = require("app.data.data_fame")
local FameItem = require('app.modules.FameItem')
local FameMgr = class("FameMgr")

function FameMgr:ctor()
	self.m_dInitFame = 0
	self.m_dFameAdd = 1
	self.m_dCurrentFame = 0			--当前名气
	self.m_dCurLevel = 0

	self.m_dData = {}	--心法数据 

	self:_init()
end

function FameMgr:reSet()
	self.m_dInitFame = 0
	self.m_dFameAdd = 1
	self.m_dCurrentFame = 0
	self.m_dCurLevel = 0
end

function FameMgr:_init()
	for idx,data in pairs(data_fame) do
		local fameItem = FameItem.new(data)
		self.m_dData[fameItem:getId()] = fameItem
	end
end

function FameMgr:updateFame(dt)
	self.m_dCurrentFame = self.m_dCurrentFame + self.m_dFameAdd
	self:_checkFame()

	GlobalEvent:fireEvent(GlobalEventIds.kXLFame, {data = self.m_dCurrentFame})
end

--更改fameadd的值
function FameMgr:changeFameAdd(fame)
	self.m_dFameAdd = self.m_dFameAdd + fame
end

--称号等级上升
function FameMgr:_upfameLevel()
	self.m_dCurLevel = self.m_dCurLevel + 1
	self:changeFameAdd(self.m_dData[self.m_dCurLevel]:getMqAdd())
end

--检测当前称号
function FameMgr:_checkFame()
	local lv = self.m_dCurLevel
	for i = lv, #self.m_dData do
		local need = self.m_dData[i]:getNeeds()
		if self.m_dCurrentFame < need then
			if i > self.m_dCurLevel then
				self:_upfameLevel()
				local fameItem = self.m_dData[i]
				ww.printfd("current fame is ", fameItem:getZDName())
				GlobalEvent:fireEvent(GlobalEventIds.kXLTitle, {data = fameItem:getZDName()})
				
			end
			return 
		end
	end
end

return FameMgr