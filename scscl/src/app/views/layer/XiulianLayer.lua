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
	self.m_uiTxtFame = nil 				--名气
	self.m_uiTxtGold = nil 				--财富
	self.m_uiTxtCurentExp = nil 		--当前修为
	self.m_uiTxtLife = nil 				--寿元
	--xinfa
	self.m_uiArrXfs = {}				--五个心法ui


	--data
	self.m_bUpBody = false 				--是否正在提示可升级体质

	self:_subscribeEvents()
	self:_setupUi()
	--；来到修炼界面 就开始修炼
	XiulianDataMgr:start()
end

function XiulianLayer:onEnter()
	XiulianLayer.super.onEnter(self)
end

function XiulianLayer:onExit()
	XiulianData.super.onExit(self)

	self:_unsubscribeEvents()
end

function XiulianLayer:_subscribeEvents()
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLTotalExp, self, handler(self, self._fireUpdateXiulianText))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLFame, self, handler(self, self._fireUpdateFameText))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLTitle, self, handler(self, self._fireUpdateTitle))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLGold, self, handler(self, self._fireUpdateGoldText))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLLife, self, handler(self, self._fireUpdatekLifeText))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLXwName, self, handler(self, self._fireUpdatekXwNameText))
	--监听是否可以升级体质
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLIsUpBody, self, handler(self, self._fireUpBodyLevel))
end

function XiulianLayer:_unsubscribeEvents()
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLTotalExp, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLFame, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLTitle, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLGold, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLLife, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLXwName, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLIsUpBody, self)
end

function XiulianLayer:_setupUi()
	self.m_uiRootNode = ww.loadCSB(kResourceRes.layer_csb, self)
	self.m_uiRootNode:move(display.cx, display.cy)

	local bg = self.m_uiRootNode:getChildByName("bg")
	bg:setVisible(false)

	self:_initInfoNode()
	self:_initXinfaNode()
	self:_initButtons()

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
	self.m_uiTxtFame		= nodeInfo:getChildByName("txt_fame")
	self.m_uiTxtCurentExp 	= nodeInfo:getChildByName("txt_curentExp")
	self.m_uiTxtGold 		= nodeInfo:getChildByName("txt_gold")
	self.m_uiTxtLife 	 	= nodeInfo:getChildByName("txt_life")

	local btnXiulian = nodeInfo:getChildByName("btn_xiulian")
	btnXiulian:addClickEventListener(handler(self, self._buttonXiulianListener))
end

function XiulianLayer:_initXinfaNode()
	local xinfaNode = self.m_uiRootNode:getChildByName("node_xinfa")
	
	for i = 1, 5 do
		local sp = xinfaNode:getChildByName(string.format("sp_xinfa%d", i))
		sp:setVisible(false)
		self.m_uiArrXfs[i] = sp
	end
end

function XiulianLayer:_initButtons()
	self.m_uiBtnBaiShi = self.m_uiRootNode:getChildByName("btn_baishi")
	self.m_uiBtnXunBao = self.m_uiRootNode:getChildByName("btn_xunbao")
	self.m_uiBtnXxqk = self.m_uiRootNode:getChildByName("btn_xxqk")		--袖里乾坤（背包）
	self.m_uiBtnXxdf = self.m_uiRootNode:getChildByName("btn_xxdf") 	--随机修习道法(技能)
	self.m_uiBtnJianBao = self.m_uiRootNode:getChildByName("btn_jianbao")

	self.m_uiBtnBaiShi:addClickEventListener(handler(self, self._buttonBaishiListener))
	self.m_uiBtnXunBao:addClickEventListener(handler(self, self._buttonXunbaoListener))
	self.m_uiBtnXxqk:addClickEventListener(handler(self, self._buttonXxqkListener))
	self.m_uiBtnXxdf:addClickEventListener(handler(self, self._buttonXxdfListener))
	self.m_uiBtnJianBao:addClickEventListener(handler(self, self._buttonJianbaoListener))
end

--当前修为的设置
function XiulianLayer:_buttonXiulianListener(ref)
	XiulianDataMgr:updateOnceXiulianExp()
end

--拜师
function XiulianLayer:_buttonBaishiListener(ref)
	
end

--寻宝
function XiulianLayer:_buttonXunbaoListener(ref)
	
end

--袖里乾坤
function XiulianLayer:_buttonXxqkListener(ref)
	
end

--随机修习道法
function XiulianLayer:_buttonXxdfListener(ref)
	
end

--鉴宝
function XiulianLayer:_buttonJianbaoListener(ref)
	
end

--[[
	*动态变更 began
]]
--实时更新当前修为
function XiulianLayer:_fireUpdateXiulianText(result)
	if self.m_uiTxtCurentExp then
		self.m_uiTxtCurentExp:setString("当前修为: " .. result.data)
	end
end

--实时更新名气值
function XiulianLayer:_fireUpdateFameText(result)
	if self.m_uiTxtFame then
		self.m_uiTxtFame:setString("名气: " .. math.floor(result.data))
	end
end

--实时更新称号
function XiulianLayer:_fireUpdateTitle(result)
	if self.m_uiTxtTitle then
		self.m_uiTxtTitle:setString(result.data)
	end
end

function XiulianLayer:_fireUpdateGoldText(result)
	if self.m_uiTxtGold then
		self.m_uiTxtGold:setString("财富: " .. result.data)
	end
end

function XiulianLayer:_fireUpdatekLifeText(result)
	if self.m_uiTxtLife then
		self.m_uiTxtLife:setString("寿元: " .. result.data)
	end
end

--境界名称
function XiulianLayer:_fireUpdatekXwNameText(result)
	if self.m_uiTxtState then
		self.m_uiTxtState:setString("境界: " .. result.data)
	end
end

function XiulianLayer:_fireUpBodyLevel(result)
	local ret = result.data
	if ret then
		if not self.m_bUpBody then
			self.m_bUpBody = true

		end
	else
		--取消体质升级提示
		if self.m_bUpBody then
			self.m_bUpBody = false
			
		end
	end
end

--[[
	*动态变更 end
]]

--修习一种心法
function XiulianLayer:_studyOneXinfa()
	XiulianDataMgr:addXinfa(XiulianDataMgr:randXinfa())
	--还要添加到心法列表的界面变化
	self.m_uiArrXfs[XiulianDataMgr:getXinfaNum()]:setVisible(true)
end

return XiulianLayer