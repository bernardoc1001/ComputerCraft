os.loadAPI("apis/util.lua")

function buildWall(isLeftWall, height, width)
    local isOnBottomSide = true

    for curWidth = 1, width do
        -- do 1 strip of height
        for curHeight = 1, height do
            print("dig")
            util.digAndPlace(2, util.directions.forward)
            if curHeight < height then
                if isOnBottomSide then
                    util.move(1, util.directions.up)
                else
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

function buildFloor(isFloor, length, width)
    local isOnNearSide = true

    for curWidth = 1, width do
        -- do 1 strip of length
        for curLength = 1, length do
            print("dig")
            if isFloor then
                util.digAndPlace(2, util.directions.down)
            else
                util.digAndPlace(2, util.directions.up)
            end
            if curLength < length then
                util.move(1, util.directions.front) 
            end
        end

        -- set current side to opposite side
        print("Flipping side")
        isOnNearSide = not isOnNearSide

         -- check if should move into next width row
        if curWidth < width then
            if isOnNearSide then
                turtle.turnLeft()
                util.move()
                turtle.turnLeft()
            else
                turtle.turnRight()
                util.move()
                turtle.turnRight()
            end
            
        end
    end

    -- return to starting position
    if isOnNearSide then
        turtle.turnRight()
        util.move(width - 1, util.directions.front)
        turtle.turnRight()
    else
        turtle.turnLeft()
        util.move(width - 1, util.directions.front)
        turtle.turnLeft()
        util.move(length - 1, util.directions.front)
        util.turnAround()
        
    end
end

function validateBuildingType(buildingType)
    if not(buildingType == 'w' or buildingType == 'f') then
        error("Enter \"w\" or \"f\" for the building type")
    end
end

function validateDimensionsInputs(dimensionA, dimensionB)
    if  dimensionA < 1 or dimensionB < 1 then
        error("All dimensions should be larger than 0")
    end
end

function validateWallType(wallType)
    if not(wallType == 'l' or wallType == 'r') then
        error("Enter \"l\" or \"r\" for what side the wall is on")
    end
end

function validateFloorType(floorType)
    if not(floorType == 'g' or floorType == 'c') then
        error("Enter \"g\" or \"c\" for the floor type")
    end
end

function startBuildingPrint()
    util.topUpFuel(true)
    print("Time to build")
end

function endBuildingPrint()
    util.printFuelLevel()
    print("Complete")
end


-- Start of program execution
print("Assume turtle is placed at bottom corner facing or on top/below the first block")

print("Are you building a (w)all type or (f)loor type? (w/f)")
local buildingType = read()
validateBuildingType(buildingType)

if buildingType == 'w' then
    print("Is the wall on the (l)eft or (r)ight? (l/r)")
    local wallType = read()
    validateWallType(wallType)

    print("Enter width: ")
    local width = tonumber(read())
    print("Enter height: ")
    local height = tonumber(read())
    validateDimensionsInputs(width, height)

    startBuildingPrint()
    buildWall(wallType == "l", height, width)
    endBuildingPrint()
else
    print("Is the floor on the (g)round or (c)eiling? (g/c)")
    local floorType = read()
    validateFloorType(floorType)

    print("Enter length: ")
    local length = tonumber(read())
    print("Enter width: ")
    local width = tonumber(read())
    validateDimensionsInputs(length, width)

    startBuildingPrint()
    buildFloor(floorType == "g", length, width)
    endBuildingPrint()
end




