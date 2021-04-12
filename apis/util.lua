function hi()
    print("Hello World!")
end

function printFuelLevel()
    print('Fuel Level: ', turtle.getFuelLevel())
end

function topUpFuel(debugMode)
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

function move(count)
    count = count or 1
    for i = 1, count, 1 do
        topUpFuel(false)
        turtle.forward()
    end
end

function moveUp(count)
    count = count or 1
    for i = 1, count, 1 do
        topUpFuel(false)
        turtle.up()
    end
end

function moveDown(count)
    count = count or 1
    for i = 1, count, 1 do
        topUpFuel(false)
        turtle.down()
    end
end

function digMove(count)
    count = count or 1
    topUpFuel(false)
    for i = 1, count, 1 do
        turtle.dig()
        move(1)
    end
end



function digMoveUp(count)
    count = count or 1
    topUpFuel(false)
    for i = 1, count, 1 do
        turtle.digUp()
        moveUp(1)
    end
end