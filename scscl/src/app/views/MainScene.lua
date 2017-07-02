require("app.utils.init")
require("app.control.init")

require("app.views.const")

local DaoFaListUi = require("app.views.nodes.DaoFaListUi")

local XiulianLayer = import(".layer.XiulianLayer")

local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    
    self.m_uiRootNode =  ww.loadCSB("res/MainScene.csb", self)
    local btnXiulian = self.m_uiRootNode:getChildByName("btn_xiulian")
    btnXiulian:addClickEventListener(handler(self, self._buttonGotoXiulianListener))

    --DaoFaListUi.new():addTo(self)
end

function MainScene:onEnter()
	self:_subscribeEvents()
end

function MainScene:onExit()
	self:_unsubscribeEvents()
end

function MainScene:_subscribeEvents()
	GlobalEvent:subscribeEvent(GlobalEventIds.kMsMinTip, self, handler(self, self._fireUpdateMinTip))
	-- GlobalEvent:subscribeEvent(GlobalEventIds.kXLFame, self, handler(self, self._fireUpdateFameText))
	-- GlobalEvent:subscribeEvent(GlobalEventIds.kXLTitle, self, handler(self, self._fireUpdateTitle))
	-- GlobalEvent:subscribeEvent(GlobalEventIds.kXLGold, self, handler(self, self._fireUpdateGoldText))
	-- GlobalEvent:subscribeEvent(GlobalEventIds.kXLLife, self, handler(self, self._fireUpdatekLifeText))
	-- GlobalEvent:subscribeEvent(GlobalEventIds.kXLXwName, self, handler(self, self._fireUpdatekXwNameText))
	-- --监听是否可以升级体质
	-- GlobalEvent:subscribeEvent(GlobalEventIds.kXLIsUpBody, self, handler(self, self._fireUpBodyLevel))
end

function MainScene:_unsubscribeEvents()
	GlobalEvent:unsubscribeEvent(GlobalEventIds.kMsMinTip, self)
	-- GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLFame, self)
	-- GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLTitle, self)
	-- GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLGold, self)
	-- GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLLife, self)
	-- GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLXwName, self)
	-- GlobalEvent:unsubscribeEvent(GlobalEventIds.kXLIsUpBody, self)
end

local iddd = 0
function MainScene:_buttonGotoXiulianListener(ref)
	XiulianLayer.new():addTo(self)
end

function MainScene:_fireUpdateMinTip(result)
	xl.showToast(self, "小提示: " .. result.data, 2, cc.c3b(255, 255, 255))
end

return MainScene
