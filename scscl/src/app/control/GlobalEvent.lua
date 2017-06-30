cc.exports.GlobalEventIds = {
	kXLTotalExp = "kXLTotalExp", 			--每次点击修炼所得的修为(值是总修为)
}

local GlobalEvent = class("GlobalEvent", require("app.modules.DataEventManager"))

function GlobalEvent:ctor()
	GlobalEvent.super.ctor(self)

end


cc.exports.GlobalEvent = GlobalEvent.new()