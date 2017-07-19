local TopCommonUi = import(".TopCommonUi")
local KnapSackNode = class("KnapSackNode", ww.BaseLayer)

local kCsbFile = "res/main_layer/csb/bag/KnapSackNode.csb"
local kCsbInfoFile = "res/main_layer/csb/bag/ProInfoNode.csb"
local kItemHeight = 168
local kItemWidth = 163
local kFabaoPath = "main_layer/fabao/"

function KnapSackNode:ctor()
	self.m_dTotalHeight = 0
	self.m_uiItems = {}
	self.m_dCurrentIdx = GameEnum.PropType.zawu
	self.m_dItemDisH = 10
	self.m_dItemDisW = 17
	--ui
	self.m_uiRootNode = nil
	self.m_uiScrollView = nil
	self.m_uiCboxs = {} 				--左边checkbox集合

	self:_setupUi()
end

function KnapSackNode:_setupUi()
	self.m_uiRootNode =  ww.loadCSB(kCsbFile, self)
	self.m_uiRootNode:move(display.cx, display.cy)

	local function return_listener()
		self:setVisible(false)
	end
	TopCommonUi.new(return_listener):addTo(self)
	:move(display.cx, display.top)

	self.m_uiScrollView = self.m_uiRootNode:getChildByName("img_scroll"):getChildByName("scrollview")
	self.m_dScrollHeight = ww.H(self.m_uiScrollView)

	for i = 1, 4 do
		self.m_uiCboxs[i] = self.m_uiRootNode:getChildByName("frame_2"):getChildByName("cbox_" .. i)
		self.m_uiCboxs[i]:addEventListener(handler(self, self._checkboxGameNumsEvent))
		self.m_uiCboxs[i]:setTag(i)
	end

end

function KnapSackNode:_checkboxGameNumsEvent(ref, eventType)
	local tag = ref:getTag()
	if self.m_dCurrentIdx ~= tag then
		self.m_dCurrentIdx = tag
		self:_switchPropTypeItems()
	end
    for i,checkbox in pairs(self.m_uiCboxs) do
        checkbox:setSelected(tag == i)
    end
end

--初始化背包
function KnapSackNode:initKnapSack()
	self:_switchPropTypeItems()
end

--创建一个都图标
function KnapSackNode:_createPropImage(prop)
	local item = cc.Node:create()
	item:addTo(self.m_uiScrollView)

	local bg = display.newSprite("#main_layer/Bag/frame_5.png")
	bg:addTo(item)

	local sp = cc.Sprite:create()
	sp:setName("prop_img")
	sp:setSpriteFrame(prop.image)
	sp:addTo(item)

	cc.Label:createWithTTF(prop.num, my_res.ttf, 24)
	:addTo(item)
	:setName("prop_num")
	:setTextColor(cc.c4b(255,255,255,255))
	:setAnchorPoint(cc.p(1,0.5))
	:enableOutline(cc.c4b(79,48,35,255), 1)
	:move(kItemWidth/2 - 26, -kItemHeight/2 + 36)

	ww.addNodeTouchListener(sp, function(touch, event) 
		if event.name == "began" then
			self:_showPropInfoNode(prop)
			return false
		end
		end)

	table.insert(self.m_uiItems, #self.m_uiItems + 1, item)
end

--刷新一个图标
function KnapSackNode:_reFreshPropImage(item, prop)
	item:getChildByName("prop_img"):setSpriteFrame(prop.image)
	item:setVisible(true)
end

--csb ProInfoNode
function KnapSackNode:_showPropInfoNode(prop)
	local node = self.m_uiRootNode:getChildByName("img_scroll")
	node:getChildByName("txt_name"):setString(prop.name)
	node:getChildByName("txt_num"):setString("数量: " .. prop.num)
	node:getChildByName("txt_addtion"):setString(prop.addition)
	node:getChildByName("txt_des"):setString(prop.des)
end

--切换一个栏目
function KnapSackNode:_switchPropTypeItems()
	local prop_data = XiulianMgr:getBagMgr():getPropsByType(self.m_dCurrentIdx)
	for idx,prop in pairs(prop_data) do
		if self.m_uiItems[idx] then
			self:_reFreshPropImage(self.m_uiItems[idx], prop)
		else
			self:_createPropImage(prop)
		end
	end

	for i = #prop_data + 1, #self.m_uiItems do
		self.m_uiItems[i]:setVisible(false)
	end
	self:_updateItemVecs()
end

function KnapSackNode:_updateItemVecs()
	--self.m_dScrollHeight  内胆的高度
	if self.m_dTotalHeight > self.m_dScrollHeight then
		self.m_uiScrollView:setInnerContainerSize(cc.size(ww.W(self.m_uiScrollView), self.m_dTotalHeight))
		self.m_dScrollHeight = self.m_dTotalHeight
		--self.m_uiScrollView:jumpToBottom()
	end
	
	local heights = 0
	local lineBx = 10
	local bLineWidth = lineBx
	local bLineHeight = self.m_dScrollHeight - kItemWidth / 2
	for idx,item in pairs(self.m_uiItems) do
		bLineWidth = bLineWidth + kItemWidth / 2
		item:move(bLineWidth, bLineHeight)
		--item刷新图标
		bLineWidth = bLineWidth + kItemWidth / 2 + self.m_dItemDisW 

		if idx % 5 == 0 then
			bLineHeight = bLineHeight - kItemHeight - self.m_dItemDisH
			bLineWidth = lineBx
		end
	end
end

return KnapSackNode