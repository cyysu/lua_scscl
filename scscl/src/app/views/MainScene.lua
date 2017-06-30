require("app.utils.init")
require("app.data.init")
require("app.control.init")

require("app.views.const")

local XiulianLayer = import(".layer.XiulianLayer")

local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    
    self.m_uiRootNode =  ww.loadCSB("res/MainScene.csb", self)
    local btnXiulian = self.m_uiRootNode:getChildByName("btn_xiulian")
    btnXiulian:addClickEventListener(handler(self, self._buttonGotoXiulianListener))
end

function MainScene:_buttonGotoXiulianListener(ref)
	XiulianDataMgr:upBodyLevel()
	XiulianLayer.new():addTo(self)
end

return MainScene
