cc.exports.GlobalEventIds = {
	kShowToast = "kShowToast", 		--显示一条提示
	kUpdateExp = "kUpdateExp", 		--修为
	kUpdateLife = "kUpdateLife",	--寿元
	kUpdateGold = "kUpdateGold", 	--财富
	kUpdateFame = "kUpdateFame", 	--名气
	kUpdateXinfa = "kUpdateXinfa", 	--心法
}

local GlobalEvent = class("GlobalEvent", ww.DataEventManager)

function GlobalEvent:ctor()
	GlobalEvent.super.ctor(self)

end


cc.exports.GlobalEvent = GlobalEvent.new()