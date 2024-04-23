eventNewPlayer = function(name)

    tfm.exec.respawnPlayer(name)
    Data[name] = Data[name] or Player(name)

    ui.setMapName("<CE>#Micequest</CE>")
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end
