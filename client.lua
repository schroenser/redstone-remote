local serverId = 1

local basalt = require("basalt")
local colorNames = {"white","orange","magenta","lightBlue","yellow","lime","pink","gray","lightGray","cyan","purple","blue","brown","green","red","black"}
local labels = require("buttons")
local colorMap = {}

rednet.open("back")

for i, color in ipairs(colorNames) do
    colorMap[color] = false
    if labels[color] == nil then
        labels[color] = color
    end
end

local main = basalt.getMainFrame()
main:setSize(26, 20):setPosition(1, 1)

for i, color in ipairs(colorNames) do
    local btn = main:addButton()
        :setText(labels[color])
        :setPosition(8, i + 2)
        :setSize(10, 1)
        :setBackground(colorMap[color] and colors[color] or colors.gray)
        :onClick(function(self)
            colorMap[color] = not colorMap[color]
            rednet.send(serverId, {color=color, state=colorMap[color]})
            self:setBackground(colorMap[color] and colors[color] or colors.gray)
        end)
end

basalt.run()
