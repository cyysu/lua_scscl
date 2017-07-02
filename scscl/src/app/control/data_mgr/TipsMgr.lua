local data_tips = require("app.data.data_tips")
local TipsMgr = class("TipsMgr")

local kMinTipMaxTime = 10

function TipsMgr:ctor()
	self.m_dMinTips = {} 			--小提示列表

	self.m_dMinTimeBase = 0 		--小提示计时基数

	self:_init()
end

function TipsMgr:_init()
	for _,data in pairs(data_tips) do
		if data.min_tips then
			table.insert(self.m_dMinTips, data.min_tips)
		end
	end
end

function TipsMgr:updateTips(dt)
	self.m_dMinTimeBase = self.m_dMinTimeBase + 1
	if self.m_dMinTimeBase >= kMinTipMaxTime then
		self.m_dMinTimeBase = 0
		self:_randMinTip()
	end
end

function TipsMgr:_randMinTip()
	local idx = math.random(1, #self.m_dMinTips)
	GlobalEvent:fireEvent(GlobalEventIds.kMsMinTip, {data = self.m_dMinTips[idx]})
end

return TipsMgr