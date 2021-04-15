function hi()
    print("Hello World!")
end

directions = {
    up = "up",
    forward = "forward", 
    down = "down", 
    back="back"
}

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
    for i = 1, count, 1 do
        topUpFuel(false)
        if direction == directions.up then 
            turtle.up()
        elseif direction == directions.down then
            turtle.down()
        elseif direction == directions.back then
            turtle.back()
        else
            turtle.forward()
        end   
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

