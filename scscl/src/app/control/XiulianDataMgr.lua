local data_body = require("app.data.data_body")
local data_skill = require("app.data.data_skill")
local data_xinfa = require("app.data.data_xinfa")
local BodyItem = require('app.modules.BodyItem')
local LevelItem = require('app.modules.LevelItem')
local SkillItem = require('app.modules.SkillItem')
local XinFaItem = require('app.modules.XinFaItem')
local XiulianData = class("XiulianData")

function XiulianData:ctor()
	--技能管理
	self.m_dSkillData = {}
	self.m_dMineSkills = {}  --{level}
	--身体等级管理
	self.m_dBodyData = {}
	self.m_dBodyLevel = 0			--身体等级
	--境界管理
	self.m_dLevelData = {}
	--心法管理
	self.m_dXinfaData = {}
	self.m_dMineXinfas = {}

	self.m_dLevelId = 0 			--当前等级
	self.m_dLevelTitle = "" 		--当前境界名称
	self.m_dTitle = ""				--称号
	self.m_dCurrentExp = 0 			--当前修为(境界总量)
	

	self.m_dOnceAddExp = 1 			--每次修炼增加修为(手动修炼)
	self.m_dAutoOnceAddExp = 0		--每秒修炼增加修为
	self.m_dCurTotalExp = 0 		--目前等级修为总量

	self.m_cSchedule = ww.CSchedule.new(0.1, 0)
	self.m_cSchedule:setScheduleListener(handler(self, self._updateListener))
	self.m_cSchedule:start()

	self:_load()
end

function XiulianData:_load()
	self:_loadBodyData()
	self:_loadLevelData()
	self:_loadSkillData()
	self:_loadXinfaData()
end

function XiulianData:_loadBodyData()
	for idx,data in pairs(data_body) do
		self.m_dBodyData[data.level] = BodyItem.new(data)
	end
end

function XiulianData:_loadLevelData()

end

function XiulianData:_loadXinfaData()
	for idx,data in pairs(data_xinfa) do
		local xinfaItem = XinFaItem.new(data)
		self.m_dXinfaData[xinfaItem:getId()] = xinfaItem
	end
end

function XiulianData:_loadSkillData()
	for idx,data in pairs(data_skill) do
		local skillItem = SkillItem.new(data)
		self.m_dSkillData[skillItem:getId()] = skillItem
	end
end

function XiulianData:_updateListener(dt)
	if self.m_dAutoOnceAddExp > 0 then
		self:_updateAutoOnceXiulianExp()
	end
end

--手动修炼一次
function XiulianData:updateOnceXiulianExp()
	self.m_dCurTotalExp = self.m_dCurTotalExp + self.m_dOnceAddExp
	GlobalEvent:fireEvent(GlobalEventIds.kXLTotalExp, {data = self.m_dCurTotalExp})
end

--自动修炼一次
function XiulianData:_updateAutoOnceXiulianExp()
	self.m_dCurTotalExp = self.m_dCurTotalExp + math.floor(self.m_dAutoOnceAddExp / 10)
	GlobalEvent:fireEvent(GlobalEventIds.kXLTotalExp, {data = self.m_dCurTotalExp})
end

--提升身体等级
function XiulianData:upBodyLevel()
	self.m_dBodyLevel = self.m_dBodyLevel + 1
	self:updateOnceAddExp(self.m_dBodyData[self.m_dBodyLevel]:getAdditonalExp())
end

--更新每次手动修炼的值
function XiulianData:updateOnceAddExp(exp)
	self.m_dOnceAddExp = self.m_dOnceAddExp + exp
end

--更新每秒自动修炼的值
function XiulianData:updateAutoOnceAddExp(exp)
	self.m_dAutoOnceAddExp = self.m_dAutoOnceAddExp + exp
end

--[[
	*心法等级管理 began
	*同属性只能修习一本 
]]
--随机一本心法(排除同属性)
function XiulianData:randXinfa()
	local xfs = {}
	for _,item in pairs(self.m_dXinfaData) do
		local xfStyle = item:getStyle()
		local ret = true
		for style,v in pairs(self.m_dMineSkills) do
			if style == xfStyle then
				break
			end
		end
		return item
	end
end

function XiulianData:addXinfa(xfItem)
	self.m_dMineXinfas[xfItem:getStyle()] = {level = 1, id = xfItem:getId()}
	self:updateAutoOnceAddExp(xfItem:getExpAddByLevel(1))
end

function XiulianData:removeXinfa(xfStyle)
	self.m_dMineXinfas[xfStyle] = nil
end

function XiulianData:upXinfaLevel(xfStyle)
	local xf = self.m_dMineXinfas[xfStyle]
	local xfItem = self.m_dXinfaData[xf.id]
	local level = xf.level + 1
	if level >= xfItem:getLevels() then
		ww.printfd("error: 该心法已经升到最高等级,不应该再升级 skill_id: ", skillId)
	else
		self:updateAutoOnceAddExp(xfitem:getExpAddByLevel(level))
		self.m_dMineXinfas[xfStyle] = xf
	end
end

function XiulianData:getXinfaNum()
	return #self.m_dMineXinfas
end

--[[
	*心法等级管理 end
]]

--[[
	*技能等级管理 began
]]

function XiulianData:addSkill(skillId)
	self.m_dMineSkills[skillId] = 1
end

function XiulianData:removeSkill(skillId)
	self.m_dMineSkills[skillId] = 0
end

--提升一个技能等级
function XiulianData:upSkillLevel(skillId)
	local skillItem = self.m_dSkillData[skillId]
	local levelNum = #skillItem:getExpAddArray()
	local curLevel = self.m_dMineSkills[skillId] + 1
	if self.m_dMineSkills[skillId] >= levelNum then
		ww.printfd("该技能已经升到最高等级 skill_id: ", skillId)
		--需要通知界面更新 ???
	else
		self.m_dMineSkills[skillId] = curLevel
	end 
	self:updateAutoOnceAddExp(tonumber(skillItem:getExpAddArray()[curLevel]))
end

--[[
	*技能等级管理 end
]]

--get / set
--获取当前身体等级的数据
function XiulianData:getCurrentBodyData()
	return self.m_dBodyData[self.m_dBodyLevel]
end

cc.exports.XiulianDataMgr = XiulianData.new()