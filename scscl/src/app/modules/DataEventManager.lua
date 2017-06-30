local DataEventManager = class("DataEventManager")

function DataEventManager:ctor()
    --{event_id = {subscriber1, subscriber2, ...}}
    self.m_event_subscribers = {}
end

function DataEventManager:subscribeEvent(event_id, subscriber_key, listener)
    local event_subscribers = self.m_event_subscribers[event_id]
    if not event_subscribers then
        event_subscribers = {[subscriber_key] = listener}
        self.m_event_subscribers[event_id] = event_subscribers
    else
        assert(event_subscribers[subscriber_key] == nil, tostring(subscriber_key))
        event_subscribers[subscriber_key] = listener
    end
end

function DataEventManager:unsubscribeEvent(event_id, subscriber_key)
    local event_subscribers = self.m_event_subscribers[event_id]
    if event_subscribers then
        event_subscribers[subscriber_key] = nil
    end
end

function DataEventManager:removeSubscribersByName(subscriber_key)
    for event_id, subscribers in pairs(self.m_event_subscribers) do
        subscribers[subscriber_key] = nil
    end
end

function DataEventManager:removeSubscriberById(event_id)
    self.m_event_subscribers[event_id] = nil
end

function DataEventManager:removeAllSubscriber()
    self.m_event_subscribers = {}
end

function DataEventManager:fireEvent(event_id, data)
    local event_subscribers = self.m_event_subscribers[event_id]
    if event_subscribers then
        -- For avoid problems when su/unsubscribeEvent en handlers
        -- You can not let users to make sure call it in handlers
        --local copiedEvents = UtileFuns.copyTable(event_subscribers)
        for key, fun in pairs(event_subscribers) do
            fun(data)
        end
    end
end


return DataEventManager
