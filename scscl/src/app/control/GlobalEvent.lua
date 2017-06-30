cc.exports.GlobalEventIds = {
	kXLTotalExp = "kXLTotalExp", 			--每次点击修炼所得的修为(显示在修炼主层)
	kXLFame = "kXLFame", 					--当前修为(显示在修炼主层)
	kXLTitle = "kXLTitle", 					--当前称号(显示在修炼主层)
	kXLGold = "kXLGold", 					--当前财富(显示在修炼主层)
	kXLLife = "kXLLife", 					--当前寿元(显示在修炼主层)
	kXLXwName = "kXLXwName", 				--当前境界名称(显示在修炼主层)
	kXLIsUpBody = "kXLIsUpBody", 			--是否可以提升身体等级(显示在修炼主层)
}

local GlobalEvent = class("GlobalEvent", require("app.modules.DataEventManager"))

function GlobalEvent:ctor()
	GlobalEvent.super.ctor(self)

end


cc.exports.GlobalEvent = GlobalEvent.new()