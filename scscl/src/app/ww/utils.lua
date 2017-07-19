-- 出牌效果
-- @param[formatScore]                  格式化长整形
-- @param[numberThousands]              无小数点 NumberThousands
-- @param[loadRootCSB]                  加载界面根节点，设置缩放达到适配
-- @param[loadCSB]                      加载csb资源
-- @param[loadTimeLine]                 加载 帧动画
-- @param[registerTouchEvent]           注册touch事件
-- @param[addNodeTouchListener]         注册touch事件

-- @param[loadRootCSB]                  扑克精灵
-- @param[loadRootCSB]                  扑克精灵
-- @param[loadRootCSB]                  扑克精灵
-- @param[loadRootCSB]                  扑克精灵
-- @param[loadRootCSB]                  扑克精灵
cc.exports.ww = {}

ww.SIZE = function (node)
    if not node then return nil end
    local size = node:getContentSize()
    if size.width == 0 and size.height == 0 then
        local w,h = node:getLayoutSize()
        return cc.size(w,h)
    else
        return size
    end
end

--获取坐标位置函数
ww.X = function (node) if not node then return nil end return node:getPositionX(); end
ww.Y = function (node) if not node then return nil end return node:getPositionY(); end
ww.W = function (node) if not node then return nil end  return ww.SIZE(node).width; end
ww.H = function (node) if not node then return nil end  return ww.SIZE(node).height; end

ww.DEBUG = true

ww.printfd = function (fmt, ...)
    if not ww.DEBUG then return end
    print(fmt, ...)
end

function ww.printf(fmt, ...)
    if not ww.DEBUG then return end
    print(string.format(tostring(fmt), ...))
end

--3,333,333,333
function ww.formatNumbers(number)
    if number < 999 then
        return number
    end
    local numStr = tostring(number)
    local len = string.len(numStr)
    local nums = math.floor(len / 3)
    local _str = ""
    for i = 1, nums + 1 do
        if i <= nums then
            _str =  ',' .. string.sub(numStr, i*3-2, i * 3) .. _str
        else
            _str = string.sub(numStr, (i - 1) * 3 + 1, len) .. _str
        end
    end
    return _str
end

--加载界面根节点，设置缩放达到适配
function ww.loadRootCSB( csbFile, parent )
    local rootlayer = ccui.Layout:create()
        :setContentSize(1334,750) --这个是资源设计尺寸
        :setScale(display.width / 1334);
    if nil ~= parent then
        parent:addChild(rootlayer);
    end

    local csbnode = cc.CSLoader:createNode(csbFile);
    rootlayer:addChild(csbnode);

    return rootlayer, csbnode;
end

--加载csb资源
function ww.loadCSB( csbFile, parent )
    local csbnode = cc.CSLoader:createNode(csbFile);
    if nil ~= parent then
        parent:addChild(csbnode);
    end
    return csbnode; 
end

--加载 帧动画
function ww.loadTimeLine( csbFile )
    return cc.CSLoader:createTimeline(csbFile);  
end

--注册node事件
function ww.registerNodeEvent( node )
    if nil == node then
        return
    end
    local function onNodeEvent( event )
        if event == "enter" and nil ~= node.onEnter then
            node:onEnter()
        elseif event == "enterTransitionFinish" 
            and nil ~= node.onEnterTransitionFinish then
            node:onEnterTransitionFinish()
        elseif event == "exitTransitionStart" 
            and nil ~= node.onExitTransitionStart then
            node:onExitTransitionStart()
        elseif event == "exit" and nil ~= node.onExit then
            node:onExit()
        elseif event == "cleanup" and nil ~= node.onCleanup then
            node:onCleanup()
        end
    end

    node:registerScriptHandler(onNodeEvent)
end

--注册touch事件
function ww.registerTouchEvent( node, bSwallow )
    if nil == node then
        return false
    end
    local function onNodeEvent( event )
        if event == "enter" and nil ~= node.onEnter then
            node:onEnter()
        elseif event == "enterTransitionFinish" then
            --注册触摸
            local function onTouchBegan( touch, event )
                if nil == node.onTouchBegan then
                    return false
                end
                return node:onTouchBegan(touch, event)
            end

            local function onTouchMoved(touch, event)
                if nil ~= node.onTouchMoved then
                    node:onTouchMoved(touch, event)
                end
            end

            local function onTouchEnded( touch, event )
                if nil ~= node.onTouchEnded then
                    node:onTouchEnded(touch, event)
                end       
            end

            local listener = cc.EventListenerTouchOneByOne:create()
            bSwallow = bSwallow or false
            listener:setSwallowTouches(bSwallow)
            node._listener = listener
            listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
            listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
            listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
            local eventDispatcher = node:getEventDispatcher()
            eventDispatcher:addEventListenerWithSceneGraphPriority(listener, node)

            if nil ~= node.onEnterTransitionFinish then
                node:onEnterTransitionFinish()
            end
        elseif event == "exitTransitionStart" 
            and nil ~= node.onExitTransitionStart then
            node:onExitTransitionStart()
        elseif event == "exit" and nil ~= node.onExit then  
            if nil ~= node._listener then
                local eventDispatcher = node:getEventDispatcher()
                eventDispatcher:removeEventListener(node._listener)
            end         

            if nil ~= node.onExit then
                node:onExit()
            end
        elseif event == "cleanup" and nil ~= node.onCleanup then
            node:onCleanup()
        end
    end
    node:registerScriptHandler(onNodeEvent)
    return true
end

function ww.addNodeTouchListener(node, callback)
    local size = node:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    local callback = callback or function() end
    local function commonListener(touch, event)
        local location = touch:getLocation()
        event.x = location.x
        event.y = location.y
        event.location = cc.p(event.x, event.y)
        callback(touch, event)
    end

    local function onTouchBegan(touch, event)
        event.node = event:getCurrentTarget()
        event.name = "began"
        local locationInNode = event.node:convertToNodeSpace(touch:getLocation())
        if cc.rectContainsPoint(rect, locationInNode) then
            commonListener(touch, event)
            return true
        end
        return false
    end

    local function onTouchMoved(touch, event)
        event.node = event:getCurrentTarget()
        event.name = "moved"
        commonListener(touch, event)
    end

    local function onTouchEnded(touch, event)
        event.node = event:getCurrentTarget()
        event.name = "ended"
        commonListener(touch, event)
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    --bSwallow = bSwallow or false
    listener:setSwallowTouches(true)
    node._listener = listener
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = node:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, node)
end