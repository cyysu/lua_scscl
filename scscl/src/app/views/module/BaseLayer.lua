local BaseLayer = class("BaseLayer", cc.Layer)

function BaseLayer:ctor()

	ww.addNodeTouchListener(self, handler(self, self._touchEventListener))
end

function BaseLayer:_touchEventListener(touch, event)
	
end


return BaseLayer