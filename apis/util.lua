function hi()
    print("Hello World!")
end

directions = {
    up = "up",
    forward = "forward", 
    down = "down", 
    back="back"
}

errMessages = {
    move = "Failed to move",
    noBlocks = "Out of blocks"
}

function throwErrorOnFailure(wasSuccessful, message, level)
    level = level or 2
    if not wasSuccessful then
        error(message, level)
    end
end

function printFuelLevel()
    print('Fuel Level: ', turtle.getFuelLevel())
end

function topUpFuel(debugMode)
    -- Assume fuel is always in slot 1
    if turtle.getFuelLevel() < 200 then
        turtle.select(1)
        turtle.refuel(1)
        if debugMode then
            print("Refuelling")
        end
    end
    if debugMode then
        printFuelLevel()
    end
end

function turnAround()
    turtle.turnRight()
    turtle.turnRight()
end

function move(count, direction)
    count = count or 1
    direction = direction or directions.forward

    local success = false

    for i = 1, count, 1 do
        topUpFuel(false)
        if direction == directions.up then 
            success = turtle.up()
        elseif direction == directions.down then
            success = turtle.down()
        elseif direction == directions.back then
            success = turtle.back()
        else
            success = turtle.forward()
        end
        throwErrorOnFailure(success, errMessages.move, 3)   
    end
end

function digClear()
    while turtle.detect() do
        turtle.dig()
        sleep(0.5)
    end
end

function digMove(count, direction)
    count = count or 1
    direction = direction or directions.forwards
    topUpFuel(false)
    for i = 1, count, 1 do

        if direction == directions.up then 
            turtle.digUp()
            move(1, directions.up)
        elseif direction == directions.down then
            turtle.digDown()
            move(1, directions.down)
        elseif direction == directions.back then
            turnAround()
            digMove(directions.forward)
            turnAround()
        else
            if turtle.detect then
                digClear()
            end
            move(1)
        end 

        
    end
end

function targetItemSearch(targetItemSlot)
    turtle.select(targetItemSlot)
    for i = 1, 16 do
        if i ~= targetItemSlot and turtle.compareTo(i) then
            return i
        end
    end
    return -1
end

function digAndPlace(targetItemSlot, direction)
    foundItemSlot = targetItemSearch(targetItemSlot)
    if foundItemSlot < 1 then
        throwErrorOnFailure(false, errMessages.noBlocks, 3)
    end
    turtle.select(foundItemSlot)
    if direction == directions.up then
        turtle.digUp()
        turtle.placeUp()
    elseif direction == directions.down then
        turtle.digDown()
        turtle.placeDown()
    else
        turtle.dig()
        turtle.place()
    end
    
end