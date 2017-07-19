local BaseLayer = class("BaseLayer", cc.Layer)

function BaseLayer:ctor()
	ww.registerNodeEvent(self)
	ww.addNodeTouchListener(self, handler(self, self._touchEventListener))
end

function BaseLayer:_touchEventListener(touch, event)
	
end

function BaseLayer:onEnter()
	
end

function BaseLayer:onExit()
	
end


return BaseLayer