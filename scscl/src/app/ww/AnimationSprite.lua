local AnimationSprite = class("AnimationSprite", function() return display.newSprite() end)

function AnimationSprite:ctor(key, frames)
	self:init(key, frames)
end

function AnimationSprite:init(key, frames)
	self:stopAllActions()
	self.m_key = key
	self.m_frames = frames
	self:setSpriteFrame(key .. "1.png")

	local aFrames = display.newFrames(key.."%d.png", 1, frames)
    self.m_frames_animate = display.newAnimation(aFrames, speed or  1/ 24)
end

function AnimationSprite:playOnece(is_remove, listener)
	self:playAnimationOnce(self.m_frames_animate, is_remove, listener or function() end)
end

function AnimationSprite:playForever()
	self:playAnimationForever(self.m_frames_animate)
end

function AnimationSprite:addSpriteTouchListener(listener)
	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, listener)
end

-- function AnimationSprite:addFramesPath(dir, key)
-- 	self.m_key = key
-- 	display.addSpriteFrames(dir..self.m_key..".plist", dir..self.m_key..".png")
-- end

return AnimationSprite