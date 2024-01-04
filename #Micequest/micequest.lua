do local s = {"AutoNewGame", "AutoShaman", "AfkDeath"}
	 for _, v in next, s do
     tfm.exec["disable" .. v]()
	 end
end

tfm.exec.newGame[[<C><P MEDATA=";;;;-0;0:::1-"/><Z><S/><D/><O/><L/></Z></C>]]
ui.setMapName("#Micequest")

local Data = {}

local RES = {
 Icons = {
   Health = {
     ["0"   ] = "18cbc58c299.png",
     ["0.25"] = "18cbc5910bb.png",
     ["0.50" ] = "18cbc595ed5.png",
     ["0.75"] = "18cbc59acff.png",
     ["1"   ] = "18cbc59fb0d.png",
   },
 },
}

local RemoveImageList = function(src)
     for k, v in next, src do
        tfm.exec.removeImage(v)
     end
end

math.integer = function(n)
	  return n == math.floor(n)
end

local Player = function(name)
		local instance = {
			level = 1, life = 0, lastLife = 0, maxLife = 10, exp = 0, maxExp = 90, health = {},
            isDead = false
      }

      function instance:addExp(exp)

			 local sum = self.exp + exp
			 if sum >= self.maxExp then
              self.level = self.level + math.floor(sum / self.maxExp)
              self.exp = exp % self.maxExp
			 else
              self.exp = sum
          end
      end

      function instance:addHealth(health)
         if self.life < 10 then
            self.lastLife = self.life
            self.life = self.life + health
         end
         if self.life > 10 then
            self.life = 10
         end
      end

	    function instance:takeDamage(dmg)
		    
         self.life = self.life - dmg
         if self.life <= 0 then        
	           self.isDead = true
         end
      end

      function instance:updateHealth()
		   if self.life ~= self.lastLife then
	            if self.health[1] then
 	               RemoveImageList(self.health)
	 	        end

		        self.health = {}
       	    for i = 1, math.floor(self.life) do
           	    self.health[i] = tfm.exec.addImage(RES.Icons.Health["1"], ":0", (i-1) * 25, 30, name)
		        end
        
      	    if math.integer(self.life) == false then
           		  if RES.Icons.Health["0."..tostring(self.life):sub(3,3).."0"] then
             		 	self.health[#self.health+1] = tfm.exec.addImage(RES.Icons.Health["0."..tostring(self.life):sub(3,3) .. "0"], ":0", (#self.health) * 25, 30, name)
             		  elseif RES.Icons.Health["0."..tostring(self.life):sub(3,3).."5"] then
              	    self.health[#self.health+1] = tfm.exec.addImage(RES.Icons.Health["0."..tostring(self.life):sub(3,3) .. "5"], ":0", (#self.health) * 25, 30, name)
		              end
             end
         		for i = math.floor(self.life), 8 do
          	   self.health[i] = tfm.exec.addImage(RES.Icons.Health["0"], ":0", (i+1) * 25, 30, name)
         		end
         end
      end
      return instance
end

eventNewPlayer = function (name)
	  Data[name] = Data[name] or Player(name)
     Data[name]:addExp(190)
   Data[name]:updateHealth()
end

for name in next, tfm.get.room.playerList do
	  eventNewPlayer(name)
end

eventLoop = function()
 for k, v in next, Data do
    v:addHealth(0.25)
    v:updateHealth()
 end
end
