--[[
	* 64 * 64
	技能按钮
]]
local kStencil = "res/ui/common/stencil.png"

local SkillButton = class("SkillButton", cc.Node)

function SkillButton:ctor(images, delay, listener)
	self:onNodeEvent("exit", handler(self, self.destroy))
	self.m_dNormal = images.normal
	self.m_dDelay = delay
	self.m_funcClickListener = listener
	
	self.m_uiButtons = nil
	self.m_cProgressTimer = nil
	self.m_uiStencil = nil

	self.m_cSchedule = ww.CSchedule.new(1, self.m_dDelay, nil, nil, true)
	self.m_cSchedule:setScheduleListener(handler(self, self._updateListener))

	self:_setupUi()
end

function SkillButton:destroy()
	self.m_cSchedule:stop()
end

function SkillButton:_updateListener(dt)
	if self.m_uiTTF then
		self.m_uiTTF:setString(self.m_cSchedule:getCurrentTime()-1)
	end
end

function SkillButton:changeDelayTime(delay)
	self.m_dDelay = delay
end

function SkillButton:changeClickListener(listener)
	self.m_funcClickListener = listener
end

function SkillButton:_setupUi()
	self.m_uiButtons = ccui.Button:create(self.m_dNormal)
	self.m_uiButtons:addTo(self)
	self.m_uiButtons:addClickEventListener(handler(self, self._skillClickCallback))

	self.m_uiTTF = cc.Label:createWithTTF("", xl.jiantizi, 24)
	self.m_uiTTF:addTo(self, 10)

	self.m_uiStencil = cc.Sprite:create(kStencil)
	self.m_uiStencil:addTo(self)
	self.m_uiStencil:setVisible(false)

	--添加旋转进度条精灵
	local sp = cc.Sprite:create(self.m_dNormal)
	self.m_cProgressTimer = cc.ProgressTimer:create(sp)
	self.m_cProgressTimer:addTo(self, 1)
	self.m_cProgressTimer:setVisible(false)
end

--技能点击回调
function SkillButton:_skillClickCallback(ref)
	self.m_uiButtons:setEnabled(false)
	self.m_uiStencil:setVisible(true)
	self.m_cSchedule:start()
	self.m_uiTTF:setVisible(true)
	self.m_uiTTF:setString(self.m_dDelay)
	self:_actionProgreeTo()
	if self.m_funcClickListener then
		self.m_funcClickListener()
	end
end

--冷却完回调
function SkillButton:_skillCollOverCallback(ref)
	self.m_uiStencil:setVisible(false)
	self.m_cProgressTimer:setVisible(false)
	self.m_uiButtons:setEnabled(true)
	self.m_cSchedule:stop()
	self.m_cSchedule:stop()
	self.m_uiTTF:setVisible(false)
end

function SkillButton:_actionProgreeTo()
	self.m_cProgressTimer:setPercentage(0)
	self.m_cProgressTimer:setVisible(true)
	self.m_cProgressTimer:setType(0)
	local progress = cc.ProgressTo:create(self.m_dDelay + 1, 100)
	local callback = cc.CallFunc:create(handler(self, self._skillCollOverCallback))
	self.m_cProgressTimer:runAction(transition.sequence({progress, callback}))
end

return SkillButton