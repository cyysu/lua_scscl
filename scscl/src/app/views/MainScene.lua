require("app.ww.init")
require("app.control.XiulianMgr")

local KnapSackNode = import(".model_node.KnapSackNode")
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

local kPlistFiles = {
	"fabao/fabao",
}

function MainScene:onCreate()

	self.m_dTitle = ""			--称号

    self.m_uiRootNode = nil 		
    --user node
    self.m_uiTxtLvName = nil
    self.m_uiTxtExp = nil 		--修为
    self.m_uiLoadExp = nil 		--修为进度条
    self.m_uiTxtLife = nil 		--寿元
    self.m_uiLoadLife = nil 	--寿元进度条
    self.m_uiTxtGold = nil 		--财富
    self.m_uiTxtFame = nil 		--名气
    self.m_uiTxtTitle = nil 	--称号
    self.m_uiSpXfFrame = nil 	--心法外框
    self.m_uiSpXf = nil 		--心法图标

    --自定义节点
    self.m_cKnapNode = nil 		--背包

    
    self:_setupUi()
end

function MainScene:_setupUi()
	self.m_uiRootNode =  ww.loadCSB("res/MainScene.csb", self)

	--node_bottom_st
	local nodeBottomSt = self.m_uiRootNode:getChildByName("node_bottom_st")
	local bt_bag = nodeBottomSt:getChildByName("bt_bag")
	bt_bag:addClickEventListener(handler(self, self._buttonBagListener))
	local bt_record = nodeBottomSt:getChildByName("bt_record")
	bt_record:addClickEventListener(handler(self, self._buttonRecordListener))
	--node_bottom_option
	local nodeBottomOp = self.m_uiRootNode:getChildByName("node_bottom_option")
	local bt_randXb = nodeBottomOp:getChildByName("bt_randXb")
	bt_randXb:addClickEventListener(handler(self, self._buttonRandXunbaoListener))

	self:_initUserNodeUi()
end

function MainScene:_loadFiles()
	for _,file in pairs(kPlistFiles) do
		cc.SpriteFrameCache:getInstance():addSpriteFrames(file .. ".plist")
	end
end

function MainScene:_releaseiles()
	for _,file in pairs(kPlistFiles) do
		cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(file .. ".plist")
		cc.Director:getInstance():getTextureCache():removeTextureForKey(file .. ".png")
	end
end

function MainScene:_initUserNodeUi()
	local nodeInfo = self.m_uiRootNode:getChildByName("node_player")
	--修为
	self.m_uiLoadExp = nodeInfo:getChildByName("img_exp_load_bg"):getChildByName("load_exp")
	self.m_uiTxtExp = nodeInfo:getChildByName("img_exp_load_bg"):getChildByName("txt_load")
	self.m_uiTxtLvName = nodeInfo:getChildByName("txt_lv_name")
	--寿元
	self.m_uiLoadLife = nodeInfo:getChildByName("img_life_load_bg"):getChildByName("load_life")
	self.m_uiTxtLife = nodeInfo:getChildByName("img_life_load_bg"):getChildByName("txt_load")

	--财富
	self.m_uiTxtGold = nodeInfo:getChildByName("txt_gold")
	--名气
	self.m_uiTxtFame = nodeInfo:getChildByName("txt_fame")
	self.m_uiTxtTitle = nodeInfo:getChildByName("txt_title")
	--心法（只能修炼一种）
	self.m_uiSpXfFrame = nodeInfo:getChildByName("sp_xf_frame")
	self.m_uiSpXf = nodeInfo:getChildByName("sp_xf")

end

function MainScene:onEnter()
	self:_loadFiles()
	self:_subscribeEvents()
	XiulianMgr:ready()
    XiulianMgr:startXiulian()
end

function MainScene:onExit()
	self:_releaseiles()
	self:_unsubscribeEvents()
end

function MainScene:_buttonBagListener(ref)
	if not self.m_cKnapNode then
		self.m_cKnapNode = KnapSackNode.new():addTo(self)
		self.m_cKnapNode:initKnapSack()
	else
		self.m_cKnapNode:initKnapSack()
	end
	self.m_cKnapNode:setVisible(true)
end

function MainScene:_buttonRecordListener(ref)

end

--点击寻宝
function MainScene:_buttonRandXunbaoListener(ref)
	XiulianMgr:getBagMgr():randXinfa()
end

function MainScene:_subscribeEvents()
	GlobalEvent:subscribeEvent(GlobalEventIds.kShowToast, self, handler(self, self._fireNeedShowToast))
	GlobalEvent:subscribeEvent(GlobalEventIds.kUpdateExp, self, handler(self, self._fireUpdateExpListener))
	GlobalEvent:subscribeEvent(GlobalEventIds.kUpdateLife, self, handler(self, self._fireUpdateLifeListener))
	GlobalEvent:subscribeEvent(GlobalEventIds.kUpdateGold, self, handler(self, self._fireUpdateGoldListener))
	GlobalEvent:subscribeEvent(GlobalEventIds.kUpdateFame, self, handler(self, self._fireUpdateFameListener))
	GlobalEvent:subscribeEvent(GlobalEventIds.kUpdateXinfa, self, handler(self, self._fireUpdateXfListener))
end

function MainScene:_unsubscribeEvents()
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kShowToast, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kUpdateExp, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kUpdateLife, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kUpdateGold, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kUpdateFame, self)
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kUpdateXinfa, self)
end

function MainScene:_fireNeedShowToast(result)
	ww.showToast(self, result.msg, 2)
end

function MainScene:_fireUpdateExpListener(result)
	self.m_uiLoadExp:setPercent(result.cexp / result.cneed * 100)
	self.m_uiTxtExp:setString(string.format("%d/%d", result.cexp, result.cneed))
	self.m_uiTxtLvName:setString(result.cname)
end

function MainScene:_fireUpdateLifeListener(result)
	self.m_uiLoadLife:setPercent((result.ctlf - result.clf) / result.ctlf * 100)
	self.m_uiTxtLife:setString(string.format("%d/%d", result.clf, result.ctlf))
end

function MainScene:_fireUpdateGoldListener(result)
	local str = result.add > 0 and "+%d" or "%d"
	local fameStr = string.format("财富: %d(" .. str .. ")", result.gd, result.add)
	self.m_uiTxtGold:setString(fameStr)
end

function MainScene:_fireUpdateFameListener(result)
	local str = result.add > 0 and "+%d" or "%d"
	local fameStr = string.format("名气: %d(" .. str .. ")", result.fame, result.add)
	self.m_uiTxtFame:setString(fameStr)
	if self.m_dTitle ~= result.title then
		self.m_dTitle = result.title
		self.m_uiTxtTitle:setString(self.m_dTitle)
	end
end

function MainScene:_fireUpdateXfListener(result)
	local xf = result.xf
	self.m_uiSpXfFrame:setSpriteFrame(string.format("xf_icon/xinfa_lv_%d.png", xf.level))
	self.m_uiSpXf:setSpriteFrame(xf.image)
end

return MainScene
