--[[
	*小记录弹跳提示界面 
	*最多显示三条
]]
local RecordListUi = import(".RecordListUi")
local MinRecordUi = class("MinRecordUi", cc.Node)

local kTTFNums = 3
local kTTFWidth = 350
local kTTFHeight = 150

function MinRecordUi:ctor()
	self.m_uiArrTTFs = {}
	self.m_uiArrLabels = {}

	self.m_dInitX = 0
	self.m_dInitY = 20

	self.m_cRecordListUi = nil
	self.m_dTotalHeight = 0

	self:_setupUi()
	GlobalEvent:subscribeEvent(GlobalEventIds.kRecordMgs, self, handler(self, self._fireUpdateRecord))

	self:setContentSize(cc.size(kTTFWidth-20, kTTFHeight))
	ww.addNodeTouchListener(self, handler(self, self._touchEventListener))
end

function MinRecordUi:destroy()
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kRecordMgs, self)

	self:hideRecordListUi()
end

function MinRecordUi:_touchEventListener(touch, event)
	if event.name == "began" then
		self:showRecordListUi()
	end
end

function MinRecordUi:_fireUpdateRecord(result)
	local data = result.data
	self:addMessage(data.msg)
end

function MinRecordUi:_setupUi()
	
end

function MinRecordUi:showRecordListUi()
	if not self.m_cRecordListUi then
		self.m_cRecordListUi = RecordListUi.new(handler(self, self.hideRecordListUi))
		self.m_cRecordListUi:addTo(self, 2)
	end
end

function MinRecordUi:hideRecordListUi()
	if self.m_cRecordListUi then
		self.m_cRecordListUi:destroy()
		self.m_cRecordListUi:removeFromParent()
		self.m_cRecordListUi = nil
	end
end

function MinRecordUi:addMessage(msg)
	self:_insertData(msg)
end

function MinRecordUi:_insertData(msg)
	--先各自加1
	local dieLb = nil   --该死掉的那个label
	for _,data in pairs(self.m_uiArrTTFs) do
		data.bChange = true
		data.cidx = data.cidx + 1
		if data.cidx > kTTFNums then
			data.cidx = 1
			dieLb = data
		end
		self.m_uiArrLabels[data.cidx] = data.lb
	end
	if dieLb then
		dieLb.lb:setString(msg)
		dieLb.cidx = 1
		dieLb.bChange = true
	else
		local lb = self:_createLabelTTF(msg)
		local data = {}
		data.lb = lb
		data.cidx = 1
		data.bActive = false
		data.bChange = true

		self.m_uiArrLabels[data.cidx] = lb

		table.insert(self.m_uiArrTTFs, #self.m_uiArrTTFs + 1, data)
	end
	

	self:_update()
end

function MinRecordUi:_createLabelTTF(msg)
	local lab = cc.Label:createWithTTF(msg or "", xl.jiantizi, 24, cc.size(kTTFWidth,0))
    lab:setAnchorPoint(cc.p(0, 0.5))    
    lab:setTextColor(not color and cc.c4b(255,255,255,255) or color)
    lab:addTo(self)
    return lab
end

--每次有变动都变化一次
function MinRecordUi:_update()
	for _,data in pairs(self.m_uiArrTTFs) do
		if data.bChange then
			--有变化
			self:_getTTFAction(data)
		end
	end
end

local pos1 = 0
function MinRecordUi:_getTTFAction(data)
	local lb = data.lb
	local cidx = data.cidx
	data.bChange = false

	if cidx == 1 then
		lb:setScale(1)
		local pos = cc.p(self.m_dInitX, self.m_dInitY + ww.H(lb) / 2)
		lb:move(0, 0)
		lb:setOpacity(0)
		local move = cc.MoveTo:create(0.3, pos)
		local spawn = cc.Spawn:create(cc.FadeIn:create(0.3), move)
		lb:runAction(spawn)
	elseif cidx == 2 then
		local pos = cc.p(self.m_dInitX, ww.H(lb) / 2 + ww.H(self.m_uiArrLabels[1]) + self.m_dInitY * 2)
		local move = cc.MoveTo:create(0.3, pos)
		local scale = cc.ScaleTo:create(0.3, 0.85)
		local fadeto = cc.FadeTo:create(0.3, 180)
		local spawn = cc.Spawn:create(move, scale, fadeto)
		lb:runAction(spawn)
	elseif cidx == 3 then
		local pos = cc.p(self.m_dInitX, 
			ww.H(lb) / 2 + ww.H(self.m_uiArrLabels[1]) + ww.H(self.m_uiArrLabels[2]) + self.m_dInitY * 3)
		local move = cc.MoveTo:create(0.3, pos)
		local scale = cc.ScaleTo:create(0.3, 0.75)
		local fadeto = cc.FadeTo:create(0.3, 120)
		local spawn = cc.Spawn:create(move, scale, fadeto)
		lb:runAction(spawn)
	end

end

return MinRecordUi