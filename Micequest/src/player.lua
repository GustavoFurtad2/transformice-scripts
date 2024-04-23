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
