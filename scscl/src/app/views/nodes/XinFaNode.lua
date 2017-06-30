--查看心法的详细信息
local XinFaNode = class("XinFaNode", cc.Node)

local kResourceRes = {
	layer_csb = xl.CSB_PATH .. "XinFa.csb"
}

function XinFaNode:ctor()

	self:_setupUi()
end

function XinFaNode:_setupUi()

end

return XinFaNode