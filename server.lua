local modemSide = "top"
local bundledCableSide = "bottom"

rednet.open(modemSide)

print("Server started. Waiting for cable toggle commands...")
while true do
    local id, msg = rednet.receive()
    if type(msg) == "table" and msg.color and msg.state ~= nil then
        local currentMask = redstone.getBundledOutput(bundledCableSide)
        local colorValue = colors[msg.color]
        local newMask
        if msg.state then
            newMask = colors.combine(currentMask, colorValue)
        else
            newMask = colors.subtract(currentMask, colorValue)
        end
        redstone.setBundledOutput(bundledCableSide, newMask)
        print("Toggled " .. msg.color .. " to " .. tostring(msg.state))
    end
end
