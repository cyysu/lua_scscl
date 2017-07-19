local DaoFaListUi = class("DaoFaListUi", xl.BaseLayer)

local kResourceRes = {
	csb = "res/csb/DaoFaListUi.csb",
	dfItemCsb = "res/csb/DaoFaItem.csb",
}

local kItemHeight = 110

function DaoFaListUi:ctor()
	DaoFaListUi.super.ctor(self)

	self.m_uiRootNode = nil
	self.m_uiScrollView = nil
	self.m_dScrollHeight = 0
	self.m_dTotalHeight = 0
	self.m_dItemDis = 15
	self.m_uiArrItems = {}

	self:_setupUi()
end

function DaoFaListUi:_setupUi()
	self.m_uiRootNode = ww.loadCSB(kResourceRes.csb, self)
	self.m_uiRootNode:move(20, display.cy)

	self.m_uiScrollView = self.m_uiRootNode:getChildByName("scroll_daofa")
	self.m_dScrollHeight = ww.H(self.m_uiScrollView)

	self:_createScrollItem()
	self:_createScrollItem()
	self:_createScrollItem()
	self:_createScrollItem()
	self:_createScrollItem()
	self:_createScrollItem()
end

function DaoFaListUi:_createScrollItem()
	local item = ww.loadCSB(kResourceRes.dfItemCsb, self.m_uiScrollView)
	table.insert(self.m_uiArrItems, #self.m_uiArrItems + 1, item)
	self.m_dTotalHeight = self.m_dTotalHeight + kItemHeight + self.m_dItemDis
	self:_updateItemVecs()
end

function DaoFaListUi:_updateItemVecs()
	--self.m_dScrollHeight  内胆的高度
	if self.m_dTotalHeight > self.m_dScrollHeight then
		self.m_uiScrollView:setInnerContainerSize(cc.size(ww.W(self.m_uiScrollView), self.m_dTotalHeight))
		self.m_dScrollHeight = self.m_dTotalHeight
		self.m_uiScrollView:jumpToBottom()
	end
	
	local heights = 0
	for _,item in pairs(self.m_uiArrItems) do
		heights = heights + kItemHeight / 2
		item:move(0, self.m_dScrollHeight - heights)
		heights = heights + kItemHeight / 2 + self.m_dItemDis
	end
end

return DaoFaListUi