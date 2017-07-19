--[[
	*create by ww 2017/7/15 17:48

	*exp 修为
]]
import(".game_enum")
local LevelMgr = import(".mgr_.LevelMgr")
local FrameMgr = import(".mgr_.FrameMgr")
local BagMgr = import(".mgr_.BagMgr")

local kXiulianTime = 0.02

local Xiulian = class("Xiulian")

function Xiulian:ctor()
	self.m_dCurrentWord = GameEnum.WordType.xzj 	--修真界
	self.m_dXiulianType = GameEnum.XiulianType.cm 	--普通修真

	self.m_dLife = 1 			--当前寿元
	self.m_dTotalLife = 1000 	--总寿元

	self.m_dGold = 0 			--财富
	self.m_dGoldAdd = 1 		--财富增长值

	self.m_dXinfa = nil 		--修炼的心法(只能修炼一种心法)

	self.m_cLevelMgr = LevelMgr.new()
	self.m_cFrameMgr = FrameMgr.new()
	self.m_cBagMgr = BagMgr.new()

	self.m_cSecondSchedule = ww.CSchedule.new(1)
	self.m_cSecondSchedule:setScheduleListener(handler(self, self._secondScheduleUpdate))

	self.m_cXiulianSchedule = ww.CSchedule.new(kXiulianTime)
	self.m_cXiulianSchedule:setScheduleListener(handler(self, self._xlScheduleUpdate))
end

--赠送过一本心法<<修炼入门总纲>>
function Xiulian:ready()
	self:changeXinfa({
		id = 0, 
		xltype = 1,
		level = 1, 
		image = "xf_icon/xf_0.png",
		name = "修炼入门总纲", 
		des = "修真界入门级心法,想要飞升就想办法去冒险寻找机缘吧"
	})
end

--开始修炼
function Xiulian:startXiulian()
	self.m_cSecondSchedule:start()
	self.m_cXiulianSchedule:start()
end

--每秒进行
function Xiulian:_secondScheduleUpdate(dt)
	self.m_cFrameMgr:update(dt)
	self:changeLife(1)
	self:changeGold(self.m_dGoldAdd)
end


function Xiulian:_xlScheduleUpdate(dt)
	self.m_cLevelMgr:update(dt)
end

--[[
	*心法 began
]]

function Xiulian:changeXinfa(xf)
	self.m_dXinfa = xf
	self.m_dXiulianType = xf.xltype
	self.m_cLevelMgr:changeExpAdd(GameEnum.XinfaAdds[xf.level])
	if xf.xltype == GameEnum.XiulianType.jd then
		--金丹修炼
	else

	end
	GlobalEvent:fireEvent(GlobalEventIds.kUpdateXinfa, {xf = xf})
end

--[[
	*心法 end
]]

--[[
	寿元 began
]]

function Xiulian:changeLife(lf)
	self.m_dLife = self.m_dLife + lf
	GlobalEvent:fireEvent(GlobalEventIds.kUpdateLife, {clf = self.m_dLife, ctlf = self.m_dTotalLife})
end

function Xiulian:changeTotalLifeValue(lf)
	self.m_dTotalLife = self.m_dTotalLife + lf
end

--[[
	寿元 end
]]

--[[
	财富 began
]]

function Xiulian:changeGold(gd)
	self.m_dGold = self.m_dGold + gd
	GlobalEvent:fireEvent(GlobalEventIds.kUpdateGold, {gd = self.m_dGold, add = self.m_dGoldAdd})
end

function Xiulian:changeGoldAdd(gd)
	self.m_dGoldAdd = self.m_dGoldAdd + gd
end

--[[
	财富 end
]]

--[[
	名气 began
]]

--更新名气

--[[
	名气 end
]]

function Xiulian:getCurrentWord()
	return self.m_dCurrentWord
end

function Xiulian:getXiulianType()
	return self.m_dXiulianType
end

function Xiulian:getFrameMgr()
	return self.m_cFrameMgr
end

function Xiulian:getBagMgr()
	return self.m_cBagMgr
end

cc.exports.XiulianMgr = Xiulian.new()