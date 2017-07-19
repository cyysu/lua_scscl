--[[
	* create by ww 2017/07/16 0:32
	* 背包节点 包含所有获得的物品的管理
	* 道具池 包含{ 法宝 、 心法 、 道法 、 金钱 、 物品 }
]]

--道具的类型
-- GameEnum.PropType = {
-- 	error = 0,
-- 	zawu = 1, 			--用来卖钱的啊，
-- 	finxfa = 2, 		--心法
-- 	daofa = 3,			--道法
-- 	fabao = 4, 			--法宝
-- }
local data_xinfa = require("app.models.local_data.data_xinfa")
local BagMgr = class("BagMgr")

function BagMgr:ctor()
	math.randomseed(os.time())
	self.m_dProps = {} 		--道具管理

	--self:_testInsert()

	--根据心法等级存储心法
	self:_initXinfaData() 	
end

function BagMgr:_testInsert()
	self:addProp({type = 1, image = "fabao/fb (1).png", num = 1, des = "哈哈我是测试道具"})
	self:addProp({type = 1, image = "fabao/fb (1).png", num = 1, des = "哈哈我是测试道具"})
	self:addProp({type = 2, image = "fabao/fb (2).png", num = 2, des = "哈哈我是测试道具"})
	self:addProp({type = 2, image = "fabao/fb (2).png", num = 2, des = "哈哈我是测试道具"})
end

function BagMgr:addProp(data)
	if not self.m_dProps[data.type] then
		self.m_dProps[data.type] = {}
	end

	if not self:_checkProp(data) then
		data.num = 1
		table.insert(self.m_dProps[data.type], #self.m_dProps[data.type] + 1, data)
	end
end

--检测是否存在这个道具
function BagMgr:_checkProp(data)
	if not self.m_dProps[data.type] then return end
	for _,_prop in pairs(self.m_dProps[data.type]) do
		if _prop.id == data.id then
			_prop.num = _prop.num + 1
			return true
		end
	end
	return false
end 

function BagMgr:getProps()
	return self.m_dProps
end

function BagMgr:getPropsByType(type)
	return self.m_dProps[type] or {}
end

--随机所得一个道具
--1. 随机获得一种道具类型
--2. 随机获得类型对应的具体道具数据
--[[
	*心法控制 began
	*根据心法等级存储心法 self.m_dXinfas
	-- GameEnum.WordType = {
	-- 	xzj = 1,  		--修真界（凡界）
	-- 	xj = 2, 		--仙界
	-- 	sj = 3, 		--神界
	-- 	shj = 4			--圣界
	-- }
]]

function BagMgr:_initXinfaData()
	self.m_dXinfas = {}
	for _,data in pairs(data_xinfa) do
		local lv = data.level
		if not self.m_dXinfas[lv] then
			self.m_dXinfas[lv] = {}
		end
		table.insert(self.m_dXinfas[lv], data)
	end
end

--随机得到一本心法
function BagMgr:randXinfa()
	local cword = XiulianMgr:getCurrentWord()
	local bs = cword == GameEnum.WordType.xzj and GameEnum.XinfaLevel.tian or 0
	local randlv = math.random(1, bs)		--随机一个等级
	local xinfas = self.m_dXinfas[randlv]	--等级对应心法集
	local idx = math.random(1, #xinfas)		--随机一本心法

	--存储到背包中
	self:addProp(xinfas[idx])

	local tipStr = string.format("恭喜您获得%s心法<<" .. xinfas[idx].name .. ">>", xinfas[idx].addition)
	GlobalEvent:fireEvent(GlobalEventIds.kShowToast, {msg = tipStr})
	return xinfas[idx]
end

--[[
	*心法控制 end
]]

--随机得到一种道法
--随机得到一件法宝

return BagMgr