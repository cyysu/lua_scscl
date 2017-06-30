local XiulianLayer = class("XiulianLayer", xl.BaseLayer)

local kResourceRes = {
	layer_csb = xl.CSB_PATH .. "Xiulian.csb"
}

function XiulianLayer:ctor()
	XiulianLayer.super.ctor(self)

	self.m_uiRootNode = nil
	--nodeInfo
	self.m_uiTxtNickName = nil 			--呢称
	self.m_uiTxtState = nil 			--境界
	self.m_uiTxtTitle = nil 			--称号
	self.m_uiTxtUpNeedExp = nil 		--升级所需
	self.m_uiTxtSecondExp = nil 		--每秒增加
	self.m_uiTxtCurentExp = nil 		--当前修为
	--bodyInfo
	self.m_uiTxtBodyName = nil
	self.m_uiTxtBodyDes = nil
	self.m_uiTxtBodyUpNeed = nil
	--xinfa
	self.m_uiArrXfs = {}				--五个心法ui


	self:_subscribeEvents()
	self:_setupUi()
end

function XiulianLayer:onExit()
	XiulianData.super.ctor(self)
	self:_unsubscribeEvents()
end

function XiulianLayer:_subscribeEvents()
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLTotalExp, self, handler(self, self._fireUpdateXiulianText))
end

function XiulianLayer:_unsubscribeEvents()
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLTotalExp, self)
end

function XiulianLayer:_setupUi()
	self.m_uiRootNode = ww.loadCSB(kResourceRes.layer_csb, self)
	self.m_uiRootNode:move(display.cx, display.cy)

	local bg = self.m_uiRootNode:getChildByName("bg")
	bg:setVisible(false)

	self:_initInfoNode()
	self:_initBodyInfoNode()
	self:_initXinfaNode()

	local test1 = self.m_uiRootNode:getChildByName("test1")
	test1:addClickEventListener(function() 
		self:_studyOneXinfa()
		end)
end

function XiulianLayer:_initInfoNode()
	local nodeInfo = self.m_uiRootNode:getChildByName("node_info")

	self.m_uiTxtNickName 	= nodeInfo:getChildByName("txt_nickName")
	self.m_uiTxtState 		= nodeInfo:getChildByName("txt_state")
	self.m_uiTxtTitle 		= nodeInfo:getChildByName("txt_title")
	self.m_uiTxtUpNeedExp 	= nodeInfo:getChildByName("txt_upNeedExp")
	self.m_uiTxtCurentExp 	= nodeInfo:getChildByName("txt_curentExp")
	self.m_uiTxtSecondExp 	= nodeInfo:getChildByName("txt_secondExp")

	local btnXiulian = nodeInfo:getChildByName("btn_xiulian")
	btnXiulian:addClickEventListener(handler(self, self._buttonXiulianListener))
end

function XiulianLayer:_initBodyInfoNode()
	local bodyInfo = self.m_uiRootNode:getChildByName("node_body")

	self.m_uiTxtBodyName = bodyInfo:getChildByName("txt_bodyName")
	self.m_uiTxtBodyDes = bodyInfo:getChildByName("txt_bodyDes")
	self.m_uiTxtBodyUpNeed = bodyInfo:getChildByName("txt_bodyUpNeed")
	local curBody = XiulianDataMgr:getCurrentBodyData()
	self.m_uiTxtBodyName:setString(curBody:getName())
	self.m_uiTxtBodyDes:setString(curBody:getDescription())
	self.m_uiTxtBodyUpNeed:setString(curBody:getUpNeed())
end

function XiulianLayer:_initXinfaNode()
	local xinfaNode = self.m_uiRootNode:getChildByName("node_xinfa")
	
	for i = 1, 5 do
		local sp = xinfaNode:getChildByName(string.format("sp_xinfa%d", i))
		sp:setVisible(false)
		self.m_uiArrXfs[i] = sp
	end
end

--当前修为的设置
function XiulianLayer:_buttonXiulianListener(ref)
	XiulianDataMgr:updateOnceXiulianExp()
end

function XiulianLayer:_fireUpdateXiulianText(result)
	self.m_uiTxtCurentExp:setString("当前修为: " .. result.data)
end

--修习一种心法
function XiulianLayer:_studyOneXinfa()
	XiulianDataMgr:addXinfa(XiulianDataMgr:randXinfa())
	--还要添加到心法列表的界面变化
	self.m_uiArrXfs[XiulianDataMgr:getXinfaNum()]:setVisible(true)
end

return XiulianLayer