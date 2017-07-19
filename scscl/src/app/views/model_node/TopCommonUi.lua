local TopCommonUi = class("TopCommonUi", cc.Node)

function TopCommonUi:ctor(return_listener)
	self.m_dReturnListener = return_listener

	self:_setupUi()
end

function TopCommonUi:_setupUi()
	self.m_uiRootNode =  ww.loadCSB("res/main_layer/csb/TopCommon.csb", self)

	self.m_uiBtnReturn = self.m_uiRootNode:getChildByName("bt_return")
	self.m_uiBtnReturn:addClickEventListener(handler(self, self._buttonReturnListener))

	self.m_uiSpFlag = self.m_uiRootNode:getChildByName("sp_title")
end

function TopCommonUi:_buttonReturnListener(ref)
	if self.m_dReturnListener then
		self.m_dReturnListener()
	end
end

return TopCommonUi