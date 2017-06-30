--[[
	*境界管理
	*修为的管理
]]
local data_level = require("app.data.data_level")
local LevelItem = require('app.modules.LevelItem')

local LevelMgr = class("LevelMgr")

function LevelMgr:ctor()
	self.m_dData = {}

	self.m_dCurLevel = 0 			--当前境界等级
	self.m_dLevelTitle = "" 		--当前境界名称

	self.m_dCurrentExp = 0 			--当前修为(境界总量)
	self.m_dOnceAddExp = 1 			--每次修炼增加修为(手动修炼)
	self.m_dAutoOnceAddExp = 0		--每秒修炼增加修为(自动修炼)
	self.m_dCurTotalExp = 0 		--目前等级修为总量(所有修为包括隐形的)

	self:_init()
end

function LevelMgr:_init()
	for idx,data in pairs(data_level) do
		local levelItem = LevelItem.new(data)
		self.m_dData[levelItem:getId()] = levelItem
	end
end

function LevelMgr:updateXiulian(dt)
	if self.m_dAutoOnceAddExp > 0 then
		self:updateAutoOnceXiulianExp()
	end
	self:_checkFame()
end

function LevelMgr:_updateXwLevel()
	self.m_dCurLevel = self.m_dCurLevel + 1
	--提升自动修炼每次的基数
	self:updateAutoOnceAddExp(self.m_dData[self.m_dCurLevel]:getXwAdd())
	--提升名气获得的基数
	XiulianDataMgr:changeFameAdd(self.m_dData[self.m_dCurLevel]:getMqAdd())
end

--检测当前称号
function LevelMgr:_checkFame()
	local lv = self.m_dCurLevel
	local nums = table.nums(self.m_dData)-1
	for i = lv, nums do
		local function checkLevel(level)
			if level > self.m_dCurLevel then
				self:_updateXwLevel()
				local levelItem = self.m_dData[level]
				ww.printfd("current nickname is ", levelItem:getName())
				GlobalEvent:fireEvent(GlobalEventIds.kXLXwName, {data = levelItem:getName()})
			end
		end
		local need = self.m_dData[i]:getNeeds()
		if self.m_dCurrentExp < need then
			checkLevel(i-1)
			return
		else
			if i == nums and i > self.m_dCurLevel then
				checkLevel(i)
				return
			end
		end
		
	end
end

--手动修炼一次
function LevelMgr:updateOnceXiulianExp()
	self.m_dCurrentExp = self.m_dCurrentExp + self.m_dOnceAddExp
	GlobalEvent:fireEvent(GlobalEventIds.kXLTotalExp, {data = self.m_dCurrentExp})
end

--自动修炼一次
function LevelMgr:updateAutoOnceXiulianExp()
	self.m_dCurrentExp = self.m_dCurrentExp + self.m_dAutoOnceAddExp
	GlobalEvent:fireEvent(GlobalEventIds.kXLTotalExp, {data = self.m_dCurrentExp})
end

--更新每次手动修炼的值
function LevelMgr:updateOnceAddExp(exp)
	self.m_dOnceAddExp = self.m_dOnceAddExp + exp
end

--更新每秒自动修炼的值
function LevelMgr:updateAutoOnceAddExp(exp)
	self.m_dAutoOnceAddExp = self.m_dAutoOnceAddExp + exp
end

--get / set
function LevelMgr:getCurrentExp()
	return self.m_dCurrentExp
end

return LevelMgr