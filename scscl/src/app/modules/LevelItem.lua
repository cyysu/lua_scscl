local LevelItem = class("LevelItem")

function LevelItem:ctor(data)
	self.m_dLvelId = data.id or -1			
	self.m_dName = data.name or "error"
	self.m_dUpNeed = data.need or -1
end

function LevelItem:getLevelId()
	return self.m_dLvelId
end

function LevelItem:getName()
	return self.m_dName
end

function LevelItem:getUpNeed()
	return self.m_dUpNeed
end

return LevelItem