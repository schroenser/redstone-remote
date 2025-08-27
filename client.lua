local serverId = 0
local basalt = require("basalt")
local colors = {"white","orange","magenta","lightBlue","yellow","lime","pink","gray","lightGray","cyan","purple","blue","brown","green","red","black"}
local labels = require("buttons")
local colorMap = {}
for i, color in ipairs(colors) do
    colorMap[color] = false -- initial state: off
    if labels[color] == nil then
        labels[color] = color -- fallback to color name if missing
    end
end

local main = basalt.createFrame()
main:setSize(30, 18):setPosition(1, 1)

for i, color in ipairs(colors) do
    local btn = main:addButton()
        :setText(labels[color])
        :setPosition(2, i)
        :setSize(10, 1)
        :onClick(function()
            colorMap[color] = not colorMap[color]
            -- Send rednet message to server to toggle cable state
            rednet.send(serverId, {color=color, state=colorMap[color]})
            btn:setBackground(colorMap[color] and colors[color] or "gray")
        end)
end

basalt.autoUpdate()
