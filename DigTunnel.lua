os.loadAPI("apis/util.lua")

function digLengthByWidth(length, width)
    local isOnLeftSide = true

    for curLength = 1, length, 1 do
        -- do width
        if isOnLeftSide then
            turtle.turnRight()
            util.digMove(width - 1)
            turtle.turnLeft()
        else
            turtle.turnLeft()
            util.digMove(width - 1)
            turtle.turnRight()
        end
        -- set current side to opposite side
        isOnLeftSide = not isOnLeftSide

        -- check if should move into next width row
        if curLength < length then
            util.digMove(1)
        end
    end
    -- return to starting position
    if not isOnLeftSide then
        turtle.turnLeft()
        util.move(width - 1)
        turtle.turnRight()
    end
    util.turnAround()
    util.move(length - 1)
    util.turnAround()
end

function digLevelsToHeight(length, width, height)
    util.digMove()
    for curHeight = 1, height, 1 do
        digLengthByWidth(length, width)
        if curHeight < height then
            util.digMove(1, util.directions.up)
        end
    end
    util.move(height - 1, util.directions.down)
    util.move(1, util.directions.back)
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
print("I am a dwarf and I'm digging a hole")
digLevelsToHeight(length, width, height)
util.printFuelLevel()
print("Complete")


