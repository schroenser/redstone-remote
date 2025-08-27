
local modemSide = "right"
local bundledCableSide = "back"
local colors = {"white","orange","magenta","lightBlue","yellow","lime","pink","gray","lightGray","cyan","purple","blue","brown","green","red","black"}

rednet.open(modemSide)

print("Server started. Waiting for cable toggle commands...")
while true do
    local id, msg = rednet.receive()
    if type(msg) == "table" and msg.color and msg.state ~= nil then
        redstone.setBundledOutput(bundledCableSide, colors[msg.color], msg.state and 255 or 0)
        print("Toggled " .. msg.color .. " to " .. tostring(msg.state))
    end
end
