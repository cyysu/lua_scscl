local _scheduler = cc.Director:getInstance():getScheduler()
local CSchedule = class("CSchedule")

function CSchedule:ctor(delay, ttime, bOnce, bLoop, bTimeRevert)
	self._dSchedulerEntry = -1
	self.m_dDelayTime = delay or 0.0
	self.m_dTotalTime = ttime or 0
	self.m_dCurrentTime = 0
	self.m_bTimeRevert = bTimeRevert or false
	self.m_bOnce = bOnce or false
	self.m_bLoop = bLoop or false

	self.m_funcUpdateListener = nil
	self.m_funcEndListener = nil
end

function CSchedule:setScheduleListener(updateListener, endListener)
	self.m_funcUpdateListener = updateListener
	self.m_funcEndListener = endListener
end

function CSchedule:_retset()
	self.m_dCurrentTime = 0
	if self.m_bTimeRevert then
		self.m_dCurrentTime = self.m_dTotalTime
	end
end

function CSchedule:start()
	self:_retset()
	self:_beganSchedule()
end

function CSchedule:stop()
	--loop重复
	self:_endSchedule()
	--这里已经是停止了一次 即使是重复的
	if self.m_funcEndListener then
		self.m_funcEndListener()
	end

	if self.m_bLoop then
		self:start()
	end
end

function CSchedule:_beganSchedule()
	self._dSchedulerEntry = _scheduler:scheduleScriptFunc(handler(self, self._update), self.m_dDelayTime, false)
end

function CSchedule:_endSchedule()
	_scheduler:unscheduleScriptEntry(self._dSchedulerEntry)
end

function CSchedule:_update(dt)
	if self.m_funcUpdateListener then
		self.m_funcUpdateListener()
	end

	if self.m_dTotalTime > 0 then
		if self.m_bTimeRevert then
			--时间倒叙
			self.m_dCurrentTime = self.m_dCurrentTime - 1
			if self.m_dCurrentTime <= 0 then
				self:stop()
			end
		else
			self.m_dCurrentTime = self.m_dCurrentTime + 1
			if self.m_dCurrentTime >= self.m_dTotalTime then
				self:stop()
			end
		end
	end

	--如果是一次性once
	if self.m_bOnce then
		self:stop()
	end
end

function CSchedule:getCurrentTime()
	return self.m_dCurrentTime
end

return CSchedule