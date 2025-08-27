local serverId = 1

local basalt = require("basalt")
local colorNames = {"white","orange","magenta","lightBlue","yellow","lime","pink","gray","lightGray","cyan","purple","blue","brown","green","red","black"}
local labels = require("buttons")
local colorMap = {}

rednet.open("back")

for i, color in ipairs(colorNames) do
    colorMap[color] = false
end

local main = basalt.getMainFrame()
main:setSize(26, 20):setPosition(1, 1)

local btnRow = 1
for _, color in ipairs(colorNames) do
    if labels[color] ~= nil then
        local btn = main:addButton()
            :setText(labels[color])
            :setPosition(8, btnRow + 2)
            :setSize(10, 1)
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
