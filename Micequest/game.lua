do
   for _, s in next, {"AutoNewGame", "AutoShaman", "AfkDeath", "MortCommand", "PhysicalConsumables"} do
        tfm.exec["disable" .. s]()
   end
end

tfm.exec.newGame [[<C><P /><Z><S><S L="800" H="48" X="401" Y="376" T="0" P="0,0,0.3,0.2,0,0,0,0" /></S><D><DS Y="337" X="400" /></D><O /></Z></C>]]
ui.setMapName("<CE>#Micequest</CE>")

local Data = {}

local dataStruct = {

    health = 100,
    maxHealth = 100,

    isDead = false,

    backpack = {},
}

local function Player(name)

    local instance = dataStruct

    function instance:killPlayer()
        tfm.exec.killPlayer(name)
        self.isDead = true

        return self
    end

    function instance:setHealth(health)
        self.health = health <= self.maxHealth and health or self.maxHealth

        return self
    end

    function instance:addHealth(health)
        local sumHealth = self.health + health
        self.health = sumHealth <= self.maxHealth and sumHealth or self.maxHealth

        return self
    end

    function instance:subHealth(health)
        local subHealth = self.health - health
        self.health = subHealth > 0 and sumHealth or 0

        if self.health == 0 then
            self:killPlayer()
        end

        return self
    end


    return instance
end

eventNewPlayer = function(name)

    tfm.exec.respawnPlayer(name)
    Data[name] = Data[name] or Player(name)

    ui.setMapName("<CE>#Micequest</CE>")
end

for name in next, tfm.get.room.playerList do
    eventNewPlayer(name)
end

