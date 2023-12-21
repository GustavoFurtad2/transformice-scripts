-- [[FRIDAY NIGHT FUNKIN]] 0.0.1 By Sklag#2552

local Players = {}

local GameState = 2

do local s = {"AutoNewGame","AutoShaman","AfkDeath"}
  for i = 1,#s do
     tfm.exec["disable"..s[i]]()
  end
end

tfm.exec.newGame[[<C><P Ca="" G="0,0" MEDATA=";0,1;;;-0;0:::1-"/><Z><S><S T="14" X="-179" Y="345" L="10" H="37" P="0,0,0.3,0.2,0,0,0,0"/><S T="14" X="-165" Y="322" L="37" H="10" P="0,0,0.3,0.2,0,0,0,0"/><S T="14" X="-146" Y="342" L="10" H="41" P="0,0,0.3,0.2,0,0,0,0"/><S T="14" X="-164" Y="359" L="34" H="10" P="0,0,0.3,0.2,0,0,0,0"/></S><D><DS X="-164" Y="346"/></D><O/><L/></Z></C>]]
ui.setMapName("Friday Night Funkin")

local Frame = {} Frame.__index = Frame function Frame:New()  return setmetatable({elements = {}}, self) end function Frame:NewElement(name, type)   if type == "text" then      self.elements[name] = {e_type = type, id = math.random(os.time()/4), text = "", x = 0, y = 0, w = 100, h = 100, c1 = 0xf, c2 = 0xf, type = 1, fix = false}         local element = self.elements[name]      function element:Text(text)          self.text = text or self.text          return self      end      function element:Pos(x, y)          self.x = x or self.x          self.y = y or self.y          return self      end      function element:Size(w, h)          self.w = w or self.w          self.h = h or self.h          return self      end      function element:fix(fixed)           self.fix = fixed or self.fix           return self      end      function element:Color(color)          self.c1 = color or self.c1          return self      end      function element:Color3(r, g, b)          self.c1 = bit32.bor(bit32.lshift(r, 16),  bit32.lshift(g, 8), b) or self.c1          return self	     end      function element:BorderColor(color)          self.c2 = color or self.c2          return self      end      function element:BorderColor3(r, g, b)          self.c2 = bit32.bor(bit32.lshift(r, 16),  bit32.lshift(g, 8), b) or self.c2          return self	     end      return element   elseif type == "image" then      self.elements[name] = {e_type = type, id, image = "149a49e4b38.jpg", type = ":0", x = 0, y = 0, w = 1, h = 1, rotation = 0, alpha = 1, anchorX = 0, anchorY = 0}         local element = self.elements[name]             function element:Image(image)          self.image = image or self.image          return self      end      function element:Type(type)          self.type = type          return self      end      function element:Pos(x, y)          self.x = x or self.x          self.y = y or self.y          return self      end      function element:Size(w, h)          self.w = w or self.w          self.h = h or self.h          return self      end      function element:Rotation(rotation)          self.rotation = rotation or self.rotation          return self      end      function element:Alpha(alpha)          self.alpha = alpha or self.alha          return self      end      function element:Anchor(x, y)          self.anchorX = x or self.anchorX          self.anchorY = y or self.anchorY      end   	 return element   end   return instance end function Frame:Update(visible, target)   for _, element in next, self.elements do      if element.e_type == "text" then         if visible == true then           ui.addTextArea(element.id, element.text, target, element.x, element.y, element.w, element.h, element.c1, element.c2, element.type, element.fix)          else           ui.removeTextArea(element.id, target)         end      elseif element.e_type == "image" then         if visible == true then           element.id = tfm.exec.addImage(element.image, element.type, element.x, element.y, target, element.w, element.h, element.rotation, element.alpha, element.anchorX, element.anchorY)         else           tfm.exec.removeImage(element.id)         end      end   end   return self end

local Places = {
  ["Plate"] = Frame:New()
}

Places["Plate"]:NewElement("bricks", "image"):Type("?0"):Image("18483a48b5d.png"):Pos(-250, -100):Size(0.5, 0.5)
Places["Plate"]:NewElement("curtain", "image"):Type("?1"):Image("18483a43add.png"):Pos(-200, -50):Size(0.4, 0.4)
Places["Plate"]:NewElement("floor", "image"):Type("?2"):Image("18483a4da4b.png"):Pos(-250, 300):Size(0.5, 0.5)
Places["Plate"]:NewElement("light1", "image"):Type("?3"):Image("18483a52b6a.png"):Pos(0, 0):Size(0.5, 0.5)
Places["Plate"]:NewElement("light2", "image"):Type("?3"):Image("18483a52b6a.png"):Pos(800, 0):Size(-0.5, 0.5)

local KEY_W, KEY_A, KEY_S, KEY_D, KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT = 87, 65, 83, 68, 38, 40, 37, 39

local timers = {}
local Images = {
 Arrows = "17eca2a6a03.png",
 Ready = "184839eaf3b.png",
 Set = "184839f013e.png",
 Go = "184839f4fc3.png",
}

local Dolater = function(time, execute)
   timers[#timers+1] = {
     time = os.time() + time,
     execute = execute
   }
end

local Arrows = {}
local Arrow = {}

local Signs = {
  Normal = {["left"] = "184513258cf.png", ["up"] = "184512d4074.png", ["down"] = "184512863dc.png", ["right"] = "18451306be1.png"}
}
Arrow.new = function(side, player, speed, holdType, holdSeconds)
    Arrows[#Arrows+1] = {side = side, speed = speed, holdType = holdType, holdSeconds, object, image}
    local x = 0

    if player == 2 then
      x = 405
    end

    if side == "left" then
       x = x + 45
    elseif side == "down" then
       x = x + 120
    elseif side == "up" then
       x = x + 200
    elseif side == "right" then
       x = x + 280
    end
    Arrows[#Arrows].object = tfm.exec.addShamanObject(45215, x, 400, false, 0, -speed)
    Arrows[#Arrows].image = tfm.exec.addImage(Signs.Normal[side], "=" .. Arrows[#Arrows].object, 0, 0, nil, 0.45, 0.45)
end

local Game = {}
Game.Player1, Game.Player2 = nil, nil

local Player1, Player2 = "Sklag#2552", "Devillorde#1090"
Game.Play = function()
   Scene = {
    tfm.exec.addImage(Images.Arrows, ":0", 40, 50, nil),
    tfm.exec.addImage(Images.Arrows, ":0", 450, 50, nil),
   }
   Places["Plate"]:Update(true, nil)
   
   Game.Player1 = Player1
   Game.Player2 = Player2
   
   Players[Player1]:play(1)
   Players[Player2]:play(2)

   Dolater(1000, function()
      local id = tfm.exec.addImage(Images.Ready, ":0", 225, 125, nil, 0.5, 0.5, 0, 1, 0, 0, true)
      Dolater(500, function()
           tfm.exec.removeImage(id, true)
           local id = tfm.exec.addImage(Images.Set, ":0", 225, 125, nil, 0.5, 0.5, 0, 1, 0, 0, true)
           Dolater(500, function()
                tfm.exec.removeImage(id, true)
                local id = tfm.exec.addImage(Images.Go, ":0", 200, 50, nil, 0.65, 0.65, 0, 1, 0, 0, true)
                Dolater(500, function()
                    tfm.exec.removeImage(id, true)
                end)
           end)
       end)
   end)
end

local Player = function(name)
     local instance = {isPlaying = false, number, name = name, character = "Boyfriend", score = 0}
     
     function instance:changeScore(amount)
         self.score = self.score + amount
     end

     function instance:reset()
        self.isPlaying, self.score = false, 0
        for k, KEY in next, {KEY_W, KEY_A, KEY_S, KEY_D, KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT} do
           tfm.exec.bindKeyboard(name, KEY, false, false)
        end

        return name
     end

     function instance:play(number)
        self.isPlaying, self.number = true, number
        for k, KEY in next, {KEY_W, KEY_A, KEY_S, KEY_D, KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT} do
           tfm.exec.bindKeyboard(name, KEY, true, true)
        end
     end

     function instance:keys(key)
        if GameState == 2 then
           if key == KEY_A or key == KEY_LEFT then
              Arrow.new("left", self.number, 15, false, 0)
           elseif key == KEY_S or key == KEY_DOWN then
				Arrow.new("down", self.number, 15, false, 0)
           elseif key == KEY_W or key == KEY_UP then
				Arrow.new("up", self.number, 15, false, 0)
           elseif key == KEY_D or key == KEY_RIGHT then
				Arrow.new("right", self.number, 15, false, 0)
           end
        end
     end

     return instance
end

eventKeyboard = function(name, key, down, x, y)
     Players[name]:keys(key)
end

eventNewPlayer = function(name)
     Players[name] = Players[name] or Player(name)
end

eventLoop = function()
   local list = {}
   for k, v in next, timers do
      if os.time() >= v.time then
        v.execute()
        list[#list+1] = k
      end
   end
   for k in next, list do
      table.remove(timers, k)
   end
end

for name in next, tfm.get.room.playerList do
   eventNewPlayer(name)
end

Game.Play()
