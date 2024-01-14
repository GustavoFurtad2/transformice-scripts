do
  local settings = {"AutoNewGame", "AutoShaman", "AfkDeath", "MortCommand", "PhysicalConsumables"}
  for _, i in next, settings do
     tfm.exec["disable" .. i]()
  end
end

tfm.exec.newGame[[<C><P G="0,0" MEDATA=";0,1;;;-0;0:::1-"/><Z><S/><D><DS X="390" Y="200"/></D><O/><L/></Z></C>]]
ui.setMapName("#Micequest")

local Datas, Timers = {}, {}

local RES = {
    Icons = {
      Health = {
        ["0"   ] = "18cbc58c299.png",
        ["0.25"] = "18cbc5910bb.png",
        ["0.50"] = "18cbc595ed5.png",
        ["0.75"] = "18cbc59acff.png",
        ["1"   ] = "18cbc59fb0d.png",
      },
    },
    SPRITES = {
      MICE = {
        ["DOWN1" ] = "17eed490d4e.png",
        ["DOWN2" ] = "17eed49a8d4.png",
        ["RIGHT1"] = "17eed4e062c.png",
        ["RIGHT2"] = "17eed4fda33.png",
        ["UP1"   ] = "17eed52eb45.png",
        ["UP2"   ] = "17eed538559.png",
      },
      MAP = {
        ["1"] = "17b9e02a563.png",
      }
    },
}

local KEY_W, KEY_A, KEY_S, KEY_D = 87, 65, 83, 68

local Dolater = function(time, execute)
    Timers[#Timers+1] = {time = os.time() + time, execute = execute}
end


local tile = {
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
}

local WIDTH = 35
local HEIGHT = 35

local Data = function(name)
    local instance = {
        side = "DOWN",
        isDead = false,
        frame,
        canWalk = true,
        lastMove = 0,
        lastKey,
        holdingInput = false,
        sizeX = 2,
        sizeY = 2,
        x = 400,
        y = 200,
    }

    function instance:setSprite(frame, w, h, side)
        if self.frame ~= nil then
            tfm.exec.removeImage(self.frame)
        end
        self.frame = tfm.exec.addImage(RES.SPRITES.MICE[frame], "%" .. name, w > 0 and -15 or 15, -50, nil, w, h)
        self.side = side
        self.sizeX = w
        self.sizeY = h
    end

    function instance:keys(key, down)
        self.holdingInput = down
        if os.time() >= self.lastMove then
           self.canWalk = true
        end
        if self.canWalk == true then
            if key == KEY_W then
                self.lastKey = key
                self:setSprite("UP2", 2, 2, "UP")
                self.canWalk = false
                self.lastMove = os.time() + 500
                tfm.exec.movePlayer(name, 0, 0, false, 0, -20, false)
                Dolater(500, function()
                    self:setSprite("UP1", 2, 2, "UP")
                    tfm.exec.movePlayer(name, 0, 0, false, 0, 0, false)  
                end)
            elseif key == KEY_A then
                self.lastKey = key
                self:setSprite("RIGHT2", -2, 2, "RIGHT")
                self.canWalk = false
                self.lastMove = os.time() + 500
                tfm.exec.movePlayer(name, 0, 0, false, -20, 0, false)
                Dolater(500, function()
                    self:setSprite("RIGHT1", -2, 2, "RIGHT")
                    tfm.exec.movePlayer(name, 0, 0, false, 0, 0, false)  
                end)
            elseif key == KEY_S then
                self.lastKey = key
                self:setSprite("DOWN2", 2, 2, "DOWN")
                self.canWalk = false
                self.lastMove = os.time() + 500
                tfm.exec.movePlayer(name, 0, 0, false, 0, 20, false)
                Dolater(500, function()
                    self:setSprite("DOWN1", 2, 2, "DOWN")
                    tfm.exec.movePlayer(name, 0, 0, false, 0, 0, false)  
                end)
            elseif key == KEY_D then
                self.lastKey = key
                self:setSprite("RIGHT2", 2, 2, "RIGHT")
                self.canWalk = false
                self.lastMove = os.time() + 500
                tfm.exec.movePlayer(name, 0, 0, false, 20, 0, false)
                Dolater(500, function()
                    self:setSprite("RIGHT1", 2, 2, "RIGHT")
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

eventKeyboard = function(name, key, down)
    if Datas[name].isDead == false then
        Datas[name]:keys(key, down)
    end
    eventLoop()
end

eventNewPlayer = function(name)
    tfm.exec.respawnPlayer(name)

    Datas[name] = Datas[name] or Data(name)
    tfm.exec.freezePlayer(name, true, false)

    for _, v in next, {KEY_W, KEY_A, KEY_S, KEY_D} do
        tfm.exec.bindKeyboard(name, v, true, true)
        tfm.exec.bindKeyboard(name, v, false, true)
    end
    Datas[name]:setSprite("DOWN1", 2, 2, "DOWN")
end

eventLoop = function()
    local remove = {}
    for k, v in next, Timers do
       if os.time() >= v.time then
         remove[#remove+1] = k
         v.execute()
       end
    end
    for k, v in next, remove do
       table.remove(Timers, v)
    end

    for k, v in next, Datas do
       if v:get("holdingInput") == true then
          v:keys(v:get("lastKey"), true)
       else
          v:setSprite(v:get("side") .. "1", v:get("sizeX"), v:get("sizeY"), v:get("side"))
       end
    end
end

eventPlayerDied = function(name)
    tfm.exec.respawnPlayer(name)
    Datas[name]:setSprite("DOWN1", 2, 2, "DOWN")
    tfm.exec.freezePlayer(name, true, false)
end

for _, v in next, tfm.get.room.playerList do
    eventNewPlayer(v.playerName)
end


