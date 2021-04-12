os.loadAPI("apis/util.lua")

function digLengthByWidth(length, width)
    util.digMove(length - 1)
    util.turnAround()

    for curLength = 1, length, 1 do
        -- do width
        turtle.turnLeft()
        util.digMove(width - 1)

        -- return to start of width
        util.turnAround()
        util.move(width -1)
        turtle.turnLeft()
        if curLength < length then
            util.move()
        end
    end
    util.turnAround()
end

function digLevelsToHeight(length, width, height)
    util.digMove()
    for curHeight = 1, height, 1 do
        digLengthByWidth(length, width)
        if curHeight < height then
            util.digMoveUp()
        end
    end
    util.moveDown(height - 1)
end

function validateInputs(length, width, height)
    if length < 1 or width < 1 or height < 1 then
        error("All dimensions should be larger than 0")
    end
end

print("Assume turtle is placed at bottom left facing the first block")
print("Enter Length: ")
local length = tonumber(read())
print("Enter width: ")
local width = tonumber(read())
print("Enter height: ")
local height = tonumber(read())

validateInputs(length, width, height)

util.topUpFuel(true)
digLevelsToHeight(length, width, height)
printFuelLevel()
print("Complete")


