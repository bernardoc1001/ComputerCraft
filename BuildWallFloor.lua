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
                if curHeight < height then -- todo move check up a level
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
            if isLeftWall then
                turtle.turnRight()
                util.move()
                turtle.turnLeft()
            else
                turtle.turnLeft()
                util.move()
                turtle.turnRight()
            end
            
        end
    end

    -- return to starting position
    if not isOnBottomSide then
        util.move(height - 1, util.directions.down)
    end
    if isLeftWall then
        turtle.turnLeft()
        util.move(width - 1, util.directions.forward)
        turtle.turnRight()
    else
        turtle.turnRight()
        util.move(width - 1, util.directions.forward)
        turtle.turnLeft()
    end

end


function validateInputs(leftWall, width, height)
    if  width < 1 or height < 1 then
        error("All dimensions should be larger than 0")
    end

    if not(leftWall == 'y' or leftWall == 'n') then
        error("Enter \"y\" or \"n\" for what side the wall is on")
    end
end

print("Assume turtle is placed at bottom left/right,  facing / on top of the first block")

print("Is the wall on the left? (y/n)")
local leftWall = read()

print("Enter width: ")
local width = tonumber(read())
print("Enter height: ")
local height = tonumber(read())

validateInputs(leftWall, width, height)

util.topUpFuel(true)
print("Time to build")
buildWall(leftWall == "y", height, width)
util.printFuelLevel()
print("Complete")
