local data_body = require("app.data.data_body")


local BodyItem = require('app.modules.BodyItem')
local LevelItem = require('app.modules.LevelItem')



local SkillMgr = import(".data_mgr.SkillMgr")
local XinfaMgr = import(".data_mgr.XinfaMgr")
local LevelMgr = import(".data_mgr.LevelMgr")

local FameMgr = import(".data_mgr.FameMgr")
local GoldMgr = import(".data_mgr.GoldMgr")
local LifeMgr = import(".data_mgr.LifeMgr")

local XiulianData = class("XiulianData")

function XiulianData:ctor()
	--技能管理
	self.m_cSkillMgr = SkillMgr.new()
	--身体等级管理
	self.m_dBodyData = {}
	self.m_dBodyLevel = 0			--身体等级
	--境界管理
	self.m_cLevelMgr = LevelMgr.new()
	--心法管理
	self.m_cXinfaMgr = XinfaMgr.new()
	--名气管理
	self.m_cFameMgr = FameMgr.new()
	--财富管理
	self.m_cGoldMgr = GoldMgr.new()
	--寿元管理
	self.m_cLifeMgr = LifeMgr.new()

	self.m_cSchedule = ww.CSchedule.new(1, 0) 		--1s的schedule
	self.m_cSchedule:setScheduleListener(handler(self, self._updateListener))

	self.m_cExpSchedule = ww.CSchedule.new(0.01, 0)  --加分schedule
	self.m_cExpSchedule:setScheduleListener(handler(self, self._updateExpListener))

	self:_load()
end

function XiulianData:start()
	self.m_cSchedule:start()
	self.m_cExpSchedule:start()
end

function XiulianData:stop()
	self.m_cSchedule:stop()
	self.m_cExpSchedule:stop()
end

function XiulianData:_load()
	self:_loadBodyData()
end

function XiulianData:_loadBodyData()
	for idx,data in pairs(data_body) do
		self.m_dBodyData[data.level] = BodyItem.new(data)
	end
end


function XiulianData:_updateListener(dt)
	self.m_cFameMgr:updateFame(dt)
	self.m_cGoldMgr:updateGold(dt)
	self.m_cLifeMgr:updateLife(dt)
end

function XiulianData:_updateExpListener(dt)
	self.m_cLevelMgr:updateXiulian(dt)
end
--[[
	*名气管理 began
]]

function XiulianData:changeFameAdd(fame)
	self.m_cFameMgr:changeFameAdd(fame)
end

--[[
	*名气管理 end 
]]

--[[
	*境界等级管理 began
	*同属性只能修习一本 
]]

--手动修炼一次
function XiulianData:updateOnceXiulianExp()
	self.m_cLevelMgr:updateOnceXiulianExp()
end

--自动修炼一次
function XiulianData:updateAutoOnceXiulianExp()
	self.m_cLevelMgr:updateAutoOnceXiulianExp()
end

function XiulianData:updateAutoOnceAddExp(exp)
	self.m_cLevelMgr:updateAutoOnceAddExp(exp)
end

--[[
	*境界等级管理 began
	*同属性只能修习一本 
]]

--提升身体等级(暂时只能提升每次修炼的基数)
function XiulianData:upBodyLevel()
	self.m_dBodyLevel = self.m_dBodyLevel + 1
	self.m_cLevelMgr:updateOnceAddExp(self.m_dBodyData[self.m_dBodyLevel]:getAdditonalExp())
end

--检测是否可以升级体质
function XiulianData:checkUpBoyLevel()
	local nextNeed = self.m_dBodyData[self.m_dBodyLevel + 1]
	if self.m_cLevelMgr:getCurrentExp() >= nextNeed then
		--可以升级身体
		GlobalEvent:fireEvent(GlobalEventIds.kXLIsUpBody, {data = true})
	else
		GlobalEvent:fireEvent(GlobalEventIds.kXLIsUpBody, {data = false})
	end
end

--[[
	*心法等级管理 began
	*同属性只能修习一本 
]]

function XiulianData:addXinfa(xfItem)
	self.m_cXinfaMgr:addXinfa(xfItem)
end

function XiulianData:removeXinfa(xfStyle)
	self.m_cXinfaMgr:removeXinfa(xfStyle)
end

function XiulianData:randXinfa()
	return self.m_cXinfaMgr:randXinfa()
end

--获取已经学习的心法数量
function XiulianData:getXinfaNum()
	return self.m_cXinfaMgr:getXinfaNum()
end

function XiulianData:upXinfaLevel(xfStyle)
	self.m_cXinfaMgr:upXinfaLevel(xfStyle)
end

--[[
	*心法等级管理 end
]]

--get / set
--获取当前身体等级的数据
function XiulianData:getCurrentBodyData()
	return self.m_dBodyData[self.m_dBodyLevel]
end

function XiulianData:getXinfaMgr()
	return self.m_cXinfaMgr
end

cc.exports.XiulianDataMgr = XiulianData.new()