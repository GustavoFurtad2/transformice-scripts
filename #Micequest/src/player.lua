local Data = function(name)
    local instance = {
        side = "DOWN",
        isDead = false,
        frame,
        canWalk = true,
        lastMove = 0,
        lastKey,
        holdingInput = false,
        x = 400,
        y = 200,
    }

    function instance:setSprite(frame, w, h, side)
        if self.frame ~= nil then
            tfm.exec.removeImage(self.frame)
        end
        self.frame = tfm.exec.addImage(RES.SPRITES.MICE[frame], "%" .. name, w > 0 and -15 or 15, -50, nil, w, h)
        self.side = side
    end

    function instance:keys(key, down)
        self.holdingInput = down
        if os.time() >= self.lastMove then
           self.canWalk = true
        end
        if self.canWalk == true then
            if key == KEY_W then
                self.lastKey = key
                self:setSprite("UP", 2, 2, "UP")
                self.canWalk = false
                self.lastMove = os.time() + 500
                tfm.exec.movePlayer(name, 0, 0, false, 0, -25, false)
                Dolater(500, function()
                    tfm.exec.movePlayer(name, 0, 0, false, 0, 0, false)  
                end)
            elseif key == KEY_A then
                self.lastKey = key
                self:setSprite("RIGHT", -2, 2, "LEFT")
                self.canWalk = false
                self.lastMove = os.time() + 500
                tfm.exec.movePlayer(name, 0, 0, false, -25, 0, false)
                Dolater(500, function()
                    tfm.exec.movePlayer(name, 0, 0, false, 0, 0, false)  
                end)
            elseif key == KEY_S then
                self.lastKey = key
                self:setSprite("DOWN", 2, 2, "DOWN")
                self.canWalk = false
                self.lastMove = os.time() + 500
                tfm.exec.movePlayer(name, 0, 0, false, 0, 25, false)
                Dolater(500, function()
                    tfm.exec.movePlayer(name, 0, 0, false, 0, 0, false)  
                end)
            elseif key == KEY_D then
                self.lastKey = key
                self:setSprite("RIGHT", 2, 2, "RIGHT")
                self.canWalk = false
                self.lastMove = os.time() + 500
                tfm.exec.movePlayer(name, 0, 0, false, 25, 0, false)
                Dolater(500, function()
                    tfm.exec.movePlayer(name, 0, 0, false, 0, 0, false)  
                end)
            end
        end
    end

    function instance:get(info)
        return self[info]
    end
    return instance
end
