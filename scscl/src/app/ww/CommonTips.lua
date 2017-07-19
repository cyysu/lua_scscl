function ww.showToast(context, message,delaytime,color)
    if (context == nil) or  (message == nil) or (delaytime<1) then
        return
    end

    local msgtype = type(message)
    if msgtype == "userdata" or msgtype == "table" then
        return
    end

    if message == "" then
        return
    end
    local lab = nil
    
    local bg = ccui.ImageView:create("frame_1.png")
    bg:setOpacity(0)
   	bg:move(display.cx, 150)
    bg:addTo(context)
    bg:setName("toast_bg")
    bg:setScale9Enabled(true)
    bg:runAction(cc.Sequence:create(cc.FadeTo:create(0.5,255), 
        cc.DelayTime:create(delaytime or 1), 
        cc.Spawn:create(cc.FadeTo:create(0.5,0),cc.CallFunc:create(function()
            lab:runAction(cc.FadeTo:create(0.5,0))
            end)), 
        cc.RemoveSelf:create(true)))

    lab = cc.Label:createWithTTF(message, "res/msyh.ttf", 24, cc.size(930,0))
    lab:setName("toast_lab")
        
    lab:setTextColor(not color and cc.c4b(255,255,255,255) or color)
    lab:addTo(bg)

    if nil ~= lab and nil ~= bg then
        lab:setString(message)
        lab:setTextColor(not color and cc.c4b(255,255,255,255) or color)
        local labSize = lab:getContentSize()        

        if labSize.height < 30 then
            lab:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
            bg:setContentSize(display.width, 64)
        else
            lab:setHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
            bg:setContentSize(cc.size(appdf.WIDTH, 64 + labSize.height))        
        end
        lab:move(display.width * 0.5, bg:getContentSize().height * 0.5)
    end
end