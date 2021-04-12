os.loadAPI("apis/util.lua")

function harvestRow(count)
    util.digMove(count)
    util.turnAround()
    util.digMove(count)
    util.turnAround()
end

function emptyHarvest()
    for i=2, 16, 1 do
        turtle.select(i)
        turtle.dropDown()
    end
end

while true do
    util.printFuelLevel()
    harvestRow(13)
    emptyHarvest()
    util.printFuelLevel()
    print("zzzz")
    sleep(420)
end