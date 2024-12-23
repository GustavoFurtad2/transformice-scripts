local Player = {}
Player.__index = Player

function Player:new(name)

    local player = setmetatable(
        {

            name = name,

            index = 0,

            health = 100,
            maxHealth = 100,

            speed = 5,

            isDead = false,
            isPlaying = false,

            currentHotbar = 1,

            hotbar = {},
            backpack = {items.sword, items.excalibur},
        },
    Player)

    player.hotbar[1] = player.backpack[1]
    player.hotbar[2] = player.backpack[2]

    if currentGameState == gameStates.lobby then

        tfm.exec.respawnPlayer(name)
        showPlayerList(name)
    end

    tfm.exec.bindKeyboard(name, string.byte("1"), true, true)
    tfm.exec.bindKeyboard(name, string.byte("2"), true, true)

    for i, skill in next, player.hotbar[1].skills do

        ui.addTextArea(14 + i, string.format("<A:ACTIVE>[</A:ACTIVE>%s<A:ACTIVE>]</A:ACTIVE> <p align='right'>%s</p>", skill.key, skill.name), name, 690, 350 + (i - 1) * -40, 105, 25, nil, 0xf, 0.5, true)
        tfm.exec.bindKeyboard(name, string.byte(skill.key), true, true)

        skill.players[name] = {timer = 0}
    end

    return player
end

function Player:killPlayer()

    tfm.exec.killPlayer(name)
    self.isDead = true
end

function Player:setHealth(health)

    self.health = math.min(health, self.maxHealth)
end

function Player:addHealth(health)

    self.health = math.min(self.health + health, self.maxHealth)
end

function Player:subHealth(health)

    self.health = self.health - health

    if self.health <= 0 then
        self:killPlayer()
    end
end

function Player:setLangPath()

    self.langPath = texts[tfm.get.room.community] or texts.en
end

function Player:showHotbar()

    ui.addTextArea(11, "<A:ACTIVE>1</A:ACTIVE>\n" .. self.hotbar[1].name, self.name, 10, 345, 50, 50, nil, 0xf, 0.5, true)
        
    if self.hotbar[2] then
        ui.addTextArea(12, "2\n" .. self.hotbar[2].name, self.name, 75, 345, 50, 50, nil, 0xf, 0.5, true)
    end
        
    if self.hotbar[3] then
        ui.addTextArea(13, "3\n" .. self.hotbar[3].name, self.name, 140, 345, 50, 50, nil, 0xf, 0.5, true)
    end

    ui.addTextArea(20, string.format("<a href='event:help'>%s</a>", self.langPath.help), name, 760, 120, 35, 20, nil, 0xf, 0.5, true)
end

function Player:updateHotbar(hotbarNumber)

    ui.updateTextArea(10 + self.currentHotbar, self.currentHotbar .. "\n" .. self.hotbar[self.currentHotbar].name, self.name)
    ui.updateTextArea(10 + hotbarNumber, "<A:ACTIVE>" .. hotbarNumber .. "</A:ACTIVE>\n" .. self.hotbar[hotbarNumber].name, self.name)

    for i, skill in next, self.hotbar[self.currentHotbar].skills do

        ui.removeTextArea(14 + i, self.name)
        tfm.exec.bindKeyboard(self.name, string.byte(skill.key), false, true)
    end

    for i, skill in next, self.hotbar[hotbarNumber].skills do

        ui.addTextArea(14 + i, string.format("<A:ACTIVE>[</A:ACTIVE>%s<A:ACTIVE>]</A:ACTIVE> <p align='right'>%s</p>", skill.key, skill.name), self.name, 690, 350 + (i - 1) * -40, 105, 25, nil, 0xf, 0.5, true)
        tfm.exec.bindKeyboard(self.name, string.byte(skill.key), true, true)
    end

    self.currentHotbar = hotbarNumber
end

function Player:useSkill()

    local currentTime = os.time()
    
    for i, skill in next, self.hotbar[self.currentHotbar].skills do

        if string.byte(skill.key) == key then

            if currentTime >= skill.players[self.name].timer then

                local playerNearby = checkPlayerNearby(skill.range, self.name)

                if playerNearby then
                    
                    skill.use(self.name, playerNearby)
                    skill.players[self.name].timer = currentTime + skill.cooldownTime * 1000
                end
                
                break
            end
        end
    end
end

function Player:keyboard(key, down, x, y)

    if key == string.byte("1") then
        
        if self.currentHotbar ~= "1" then

            self:updateHotbar(1)
        end

    elseif key == string.byte("2") then

        if self.currentHotbar ~= "2" then

            self:updateHotbar(2)
        end

    elseif key == string.byte("3") then

        if self.currentHotbar ~= "3" then

            self:updateHotbar(3)
        end
    
    else

        if currentGameState == gameStates.dungeon then

            self.useSkill()
        end

    end
end