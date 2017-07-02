local MinRecordUi = require("app.views.nodes.record.MinRecordUi")

local XiulianLayer = class("XiulianLayer", xl.BaseLayer)

local kUiCommonPath = "res/ui/common/"
local kResourceRes = {
	layer_csb = xl.CSB_PATH .. "Xiulian.csb",
	btn_bsqy = {normal = kUiCommonPath .. "click.png"},
	btn_xlqk = {normal = kUiCommonPath .. "click.png"},
	btn_xxdf = {normal = kUiCommonPath .. "click.png"},
	btn_xunbao = {normal = kUiCommonPath .. "click.png"},
	btn_jianbao = {normal = kUiCommonPath .. "click.png"},
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
	self.m_dArrXfsPos = {} 				--存储初始位置

	--button
	self.m_uiBtnBody = nil 				--身体
	self.m_uiBtnBaiShi = nil 			--拜师求艺
	self.m_uiBtnXxqk = nil 				--袖里乾坤
	self.m_uiBtnXxdf = nil 				--学习道法
	self.m_uiBtnXunBao = nil 			--寻宝
	self.m_uiBtnJianBao = nil 			--鉴宝 

	--data

	self.m_cMinRecordUi = nil

	self:_subscribeEvents()
	self:_setupUi()
	--；来到修炼界面 就开始修炼
	XiulianDataMgr:start()
	self:_loadResource()
end

function XiulianLayer:onEnter()
	XiulianLayer.super.onEnter(self)
	self:_loadResource()
end

function XiulianLayer:onExit()
	self:_unsubscribeEvents()
	self:hideMinRecordUi()
	self:_unloadResource()

	XiulianData.super.onExit(self)
end

function XiulianLayer:_subscribeEvents()
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLTotalExp, self, handler(self, self._fireUpdateXiulianText))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLFame, self, handler(self, self._fireUpdateFameText))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLTitle, self, handler(self, self._fireUpdateTitle))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLGold, self, handler(self, self._fireUpdateGoldText))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLLife, self, handler(self, self._fireUpdatekLifeText))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLXwName, self, handler(self, self._fireUpdatekXwNameText))
	--监听是否可以升级体质
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLIsUpBody, self, handler(self, self._fireIsUpBodyLevel))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLUpBody, self, handler(self, self._fireUpBodyLevel))
	GlobalEvent:subscribeEvent(GlobalEventIds.kXLXinfa, self, handler(self, self._fireXinfaResult))
end

function XiulianLayer:_unsubscribeEvents()
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLTotalExp, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLFame, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLTitle, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLGold, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLLife, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLXwName, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLIsUpBody, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLUpBody, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLXinfa, self)
end

function XiulianLayer:_loadResource()
	for _,file in pairs(xl.XlPlists) do
		xl.cache:addSpriteFrames(file.plist, file.png)
	end
end

function XiulianLayer:_unloadResource()
	for _,file in pairs(xl.XlPlists) do
		xl.cache:removeSpriteFramesFromFile(file.plist)
	end
end

function XiulianLayer:_setupUi()
	self.m_uiRootNode = ww.loadCSB(kResourceRes.layer_csb, self)
	self.m_uiRootNode:move(display.cx, display.cy)

	local bg = self.m_uiRootNode:getChildByName("bg")
	--bg:setVisible(false)

	self:_initInfoNode()
	self:_initXinfaNode()
	self:_initButtons()

	local test1 = self.m_uiRootNode:getChildByName("test1")
	test1:addClickEventListener(function() 
		XiulianDataMgr:addXinfa()
		end)

	self:showMinRecordUi()
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
	for i = 1, 5 do
		local sp = self.m_uiRootNode:getChildByName(string.format("sp_xinfa%d", i))
		sp:setTag(i)
		sp:setVisible(false)
		--sp:setTouchEnabled(false)
		ww.addNodeTouchListener(sp, handler(self, self._xinfaTouchEventListener))
		self.m_uiArrXfs[i] = sp
		self.m_dArrXfsPos[i] = cc.p(ww.X(sp), ww.Y(sp))
	end
end

function XiulianLayer:_initButtons()
	self.m_uiBtnBody = self.m_uiRootNode:getChildByName("btn_body")
	self.m_uiBtnBody:setEnabled(false)
	self.m_uiBtnBaiShi = xl.SkillButton.new(kResourceRes.btn_bsqy, 12, handler(self, self._buttonBaishiListener)) --self.m_uiRootNode:getChildByName("btn_baishi")
	self.m_uiBtnXunBao = xl.SkillButton.new(kResourceRes.btn_xunbao, 2, handler(self, self._buttonXunbaoListener))--self.m_uiRootNode:getChildByName("btn_xunbao")
	self.m_uiBtnXxqk = xl.SkillButton.new(kResourceRes.btn_xlqk, 2, handler(self, self._buttonXxqkListener))--self.m_uiRootNode:getChildByName("btn_xxqk")		--袖里乾坤（背包）
	self.m_uiBtnXxdf = xl.SkillButton.new(kResourceRes.btn_xxdf, 2, handler(self, self._buttonXxdfListener))--self.m_uiRootNode:getChildByName("btn_xxdf") 	--随机修习道法(技能)
	self.m_uiBtnJianBao = xl.SkillButton.new(kResourceRes.btn_jianbao, 2, handler(self, self._buttonJianbaoListener))--self.m_uiRootNode:getChildByName("btn_jianbao")

	self.m_uiBtnBody:addClickEventListener(handler(self, self._buttonBodyClickListener))

	self.m_uiBtnBaiShi:addTo(self):move(100, 100)
	self.m_uiBtnXunBao:addTo(self):move(200, 100)
	self.m_uiBtnXxqk:addTo(self):move(300, 100)
	self.m_uiBtnXxdf:addTo(self):move(display.width - 100, display.cy)
	self.m_uiBtnJianBao:addTo(self):move(400, 100)
	--self.m_uiBtnBaiShi:addClickEventListener(handler(self, self._buttonBaishiListener))
	--self.m_uiBtnXunBao:addClickEventListener(handler(self, self._buttonXunbaoListener))
	--self.m_uiBtnXxqk:addClickEventListener(handler(self, self._buttonXxqkListener))
	--self.m_uiBtnXxdf:addClickEventListener(handler(self, self._buttonXxdfListener))
	--self.m_uiBtnJianBao:addClickEventListener(handler(self, self._buttonJianbaoListener))
end

function XiulianLayer:showMinRecordUi()
	if not self.m_cMinRecordUi then
		self.m_cMinRecordUi = MinRecordUi.new()
		self.m_cMinRecordUi:addTo(self)
		self.m_cMinRecordUi:move(30, 120)
	end
end

function XiulianLayer:hideMinRecordUi()
	if self.m_cMinRecordUi then
		self.m_cMinRecordUi:destroy()
		self.m_cMinRecordUi:removeFromParent()
		self.m_cMinRecordUi = nil
	end
end

--点击升级体质设置
function XiulianLayer:changeBodyCanUpLevel(ret)
	self.m_uiBtnBody:setEnabled(true)
	--self.m_uiBtnBody:getChildByName("sp_isUp"):setVisible(true)
	local sp = xl.AnimationSprite.new(xl.XlPlists.a.key, xl.XlPlists.a.frames)
	sp:move(ww.W(self.m_uiBtnBody) / 2, ww.H(self.m_uiBtnBody) / 2)
	sp:playForever()
	sp:addTo(self.m_uiBtnBody)
	sp:setName("action")
end

--取消升级体质设置
function XiulianLayer:changeCancleBodyUpLevel(ret)
	self.m_uiBtnBody:setEnabled(false)
	--self.m_uiBtnBody:getChildByName("sp_isUp"):setVisible(false)
	self.m_uiBtnBody:getChildByName("action"):removeFromParent()
end

local kBeganPos = nil
local kIsMove = false
function XiulianLayer:_xinfaTouchEventListener(touch, event)
	if not event.node:isVisible() then return end
	local tag = event.node:getTag()
	ww.printfd("event.name ..", event.name, tag, event.x, event.y)
	if event.name == "began" then
		kBeganPos = event.location
	elseif event.name == "moved" then
		if cc.pGetDistance(kBeganPos, event.location) > 70 then
			kIsMove = true
			event.node:move(cc.p(event.x - display.cx, event.y - display.cy))
		end
	elseif event.name == "ended" then
		if kIsMove then
			--删除心法
			XiulianDataMgr:getXinfaMgr():removeXinfa(tag)
		else
			event.node:move(self.m_dArrXfsPos[tag])
			--升级心法
			print("----提升心法等级----")
		end
		kIsMove = false
	end
end
--[[
	*按钮事件 began
]]

--当前修为的设置
function XiulianLayer:_buttonXiulianListener(ref)
	XiulianDataMgr:updateOnceXiulianExp()
end

function XiulianLayer:_buttonBodyClickListener(ref)
	XiulianDataMgr:upBodyLevel()
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
	*按钮事件 end
]]

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

function XiulianLayer:_fireIsUpBodyLevel(result)
	local ret = result.data
	if ret then
		self:changeBodyCanUpLevel()
	else
		--取消体质升级提示
		self:changeCancleBodyUpLevel()
	end
end

--升级体质变化
function XiulianLayer:_fireUpBodyLevel(result)
	self.m_uiBtnBody:setTitleText(result.data)
end

--修习一种心法
function XiulianLayer:_fireXinfaResult(result)
	local xfStyle = result.data
	local add = result.add
	local remove = result.remove
	if add then
		self.m_uiArrXfs[xfStyle]:move(self.m_dArrXfsPos[xfStyle])
		self.m_uiArrXfs[xfStyle]:setVisible(true)
	elseif remove then
		self.m_uiArrXfs[xfStyle]:setVisible(false)
	end
end

--[[
	*动态变更 end
]]


return XiulianLayer