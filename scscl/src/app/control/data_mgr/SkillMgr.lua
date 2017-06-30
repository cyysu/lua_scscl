--[[
	*道法管理
]]
local data_skill = require("app.data.data_skill")
local SkillItem = require('app.modules.SkillItem')
local SkillMgr = class("SkillMgr")

function SkillMgr:ctor(data)
	self.m_dData = {}
	self.m_dMines = {}  --{level}

	self:_init()
end

function SkillMgr:_init()
	for idx,data in pairs(data_skill) do
		local skillItem = SkillItem.new(data)
		self.m_dMines[skillItem:getId()] = skillItem
	end
end

function SkillMgr:addSkill(skillId)
	self.m_dMineSkills[skillId] = 1
end

function SkillMgr:removeSkill(skillId)
	self.m_dMineSkills[skillId] = 0
end

--提升一个技能等级
function SkillMgr:upSkillLevel(skillId)
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

return SkillMgr