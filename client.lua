local serverId = ...
if serverId == nil then
    print("Usage: startup <serverId>")
    return
end

local colors = _G.colors
local basalt = require("basalt")
local colorNames = {"white","orange","magenta","lightBlue","yellow","lime","pink","gray","lightGray","cyan","purple","blue","brown","green","red","black"}
local labels = require("buttons")
local colorMap = {}
local longestLabelLength = 0

rednet.open("back")

for _, color in ipairs(colorNames) do
    colorMap[color] = false
    if labels[color] ~= nil and #labels[color] > longestLabelLength then
        longestLabelLength = #labels[color]
    end
end

local buttonWidth = longestLabelLength + 2

local main = basalt.getMainFrame()
main:setSize(26, 20):setPosition(1, 1)
local buttonX = math.floor((main:getWidth() - buttonWidth) / 2) + 1

local btnRow = 1
for _, color in ipairs(colorNames) do
    if labels[color] ~= nil then
        local btn = main:addButton()
            :setText(labels[color])
            :setPosition(buttonX, btnRow + 2)
            :setSize(buttonWidth, 1)
            :setBackground(colorMap[color] and colors[color] or colors.gray)
            :onClick(function(self)
                colorMap[color] = not colorMap[color]
                rednet.send(serverId, {color=color, state=colorMap[color]})
                self:setBackground(colorMap[color] and colors[color] or colors.gray)
            end)
        btnRow = btnRow + 1
    end
end

basalt.run()
