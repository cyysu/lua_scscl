local RecordMgr = class("RecordMgr")

function RecordMgr:ctor()
	self.m_dRecords = {}

	self:_init()
end

function RecordMgr:_init()

end

function RecordMgr:addMessage(msg, color)
	local data = {color = color, msg = msg}
	table.insert(self.m_dRecords, #self.m_dRecords + 1, data)
	GlobalEvent:fireEvent(GlobalEventIds.kRecordMgs, {data = data})
end

function RecordMgr:getRecords()
	return self.m_dRecords
end

return RecordMgr