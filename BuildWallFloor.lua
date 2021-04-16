os.loadAPI("apis/util.lua")

function buildWall(isLeftWall, height, width)
    -- TODO build a wall on the right
    local isOnBottomSide = true

    for curWidth = 1, width do
        -- do 1 strip of height
        for curHeight = 1, height do
            print("dig")
            util.digAndPlace(2, util.directions.forward)
            if isOnBottomSide then
                if curHeight < height then
                    util.move(1, util.directions.up)
                end
            elseif curHeight < height then
                util.move(1, util.directions.down)
            end
        end

        -- set current side to opposite side
        print("Flipping side")
        isOnBottomSide = not isOnBottomSide

         -- check if should move into next width row
        if curWidth < width then
            turtle.turnRight()
            util.move()
            turtle.turnLeft()
        end
    end

    -- return to starting position
    if not isOnBottomSide then
        util.move(height - 1, util.directions.down)
    end
    turtle.turnLeft()
    util.move(width - 1, util.directions.forward)
    turtle.turnRight()

end


function validateInputs(width, height)
    if  width < 1 or height < 1 then
        error("All dimensions should be larger than 0")
    end
end

print("Assume turtle is placed at bottom left facing / on top of the first block")

print("Enter width: ")
local width = tonumber(read())
print("Enter height: ")
local height = tonumber(read())

validateInputs(width, height)

util.topUpFuel(true)
print("Time to build")
buildWall(true, height, width)
util.printFuelLevel()
print("Complete")
