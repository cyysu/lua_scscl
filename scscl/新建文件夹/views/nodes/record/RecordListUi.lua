local RecordListUi = class("RecordListUi", cc.Node)

local kResourceRes = {
	csb = "res/csb/RecordListUi.csb",	
}

local kTTFWidth = 350

function RecordListUi:ctor(closeListener)
	self.m_dCloseListener = closeListener
	self.m_uiRootNode = nil
	self.m_uiScrollView = nil

	self.m_dItemDis = 10
	self.m_dTotalHeight = 0
	self.m_dScrollHeight = 0
	self.m_uiItems = {}

	self:_setupUi()

	GlobalEvent:subscribeEvent(GlobalEventIds.kRecordMgs, self, handler(self, self._fireUpdateRecord))
end

function RecordListUi:destroy()
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kRecordMgs, self)
end

function RecordListUi:_setupUi()
	self.m_uiRootNode = ww.loadCSB(kResourceRes.csb, self)
	self.m_uiScrollView = self.m_uiRootNode:getChildByName("scroll_record")
	self.m_dScrollHeight = ww.H(self.m_uiScrollView)

	local btnClose = self.m_uiRootNode:getChildByName("btn_close")
	local function close()
		self:destroy()
		self:removeFromParent()
	end
	local closeListener = self.m_dCloseListener and self.m_dCloseListener or close
	btnClose:addClickEventListener(closeListener)

	local records = XiulianDataMgr:getRecordMgr():getRecords()
	for _,data in pairs(records) do
		self:_createLabelTTF(data.msg, data.color)
	end
	self:_updateItemVecs()
end

function RecordListUi:_fireUpdateRecord(result)
	local data = result.data
	self:_createLabelTTF(data.msg, data.color)
	self:_updateItemVecs()
end

function RecordListUi:_createLabelTTF(msg, color)
	local lab = cc.Label:createWithTTF(msg or "", xl.jiantizi, 24, cc.size(kTTFWidth,0))
    lab:setAnchorPoint(cc.p(0, 0.5))    
    lab:setTextColor(not color and cc.c4b(255,255,255,255) or color)
    self.m_uiScrollView:addChild(lab)
    table.insert(self.m_uiItems, #self.m_uiItems + 1, lab)

    self.m_dTotalHeight = self.m_dTotalHeight + ww.H(lab) + self.m_dItemDis
end

function RecordListUi:_updateItemVecs()
	--self.m_dScrollHeight  内胆的高度
	if self.m_dTotalHeight > self.m_dScrollHeight then
		self.m_uiScrollView:setInnerContainerSize(cc.size(ww.W(self.m_uiScrollView), self.m_dTotalHeight))
		self.m_dScrollHeight = self.m_dTotalHeight
		self.m_uiScrollView:jumpToBottom()
	end
	
	local heights = 0
	for _,item in pairs(self.m_uiItems) do
		heights = heights + ww.H(item) / 2
		item:move(0, self.m_dScrollHeight - heights)
		heights = heights + ww.H(item) / 2 + self.m_dItemDis
	end
end

return RecordListUi