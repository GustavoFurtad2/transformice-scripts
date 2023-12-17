local Frame = {}
Frame.__index = Frame

function Frame:New()
   return setmetatable({elements = {}}, self)
end

function Frame:NewElement(name, type)
   if type == "text" then
      self.elements[name] = {e_type = type, id = math.random(os.time()/4, os.time()/2), text = "", x = 0, y = 0, w = 100, h = 100, c1 = 0xf, c2 = 0xf, type = 1, fix = false}
   
      local element = self.elements[name]

      function element:Text(text)
          self.text = text or self.text
          return self
      end

      function element:Pos(x, y)
          self.x = x or self.x
          self.y = y or self.y
          return self
      end

      function element:Size(w, h)
          self.w = w or self.w
          self.h = h or self.h
          return self
      end

      function element:fix(fixed)
           self.fix = fixed or self.fix
           return self
      end


      function element:Color(color)
          self.c1 = color or self.c1
          return self
      end

      function element:Color3(r, g, b)
          self.c1 = bit32.bor(bit32.lshift(r, 16),  bit32.lshift(g, 8), b) or self.c1
          return self
	     end

      function element:BorderColor(color)
          self.c2 = color or self.c2
          return self
      end

      function element:BorderColor3(r, g, b)
           self.c2 = bit32.bor(bit32.lshift(r, 16),  bit32.lshift(g, 8), b) or self.c2
           return self
	    end
      return element
   elseif type == "image" then
      self.elements[name] = {e_type = type, id, image = "149a49e4b38.jpg", type = ":0", x = 0, y = 0, w = 1, h = 1, rotation = 0, alpha = 1, anchorX = 0, anchorY = 0}
   
      local element = self.elements[name]
       
      function element:Image(image)
          self.image = image or self.image
          return self
      end

      function element:Type(type)
          self.type = type
          return self
      end

      function element:Pos(x, y)
          self.x = x or self.x
          self.y = y or self.y
          return self
      end

      function element:Size(w, h)
          self.w = w or self.w
          self.h = h or self.h
          return self
      end

      function element:Rotation(rotation)
          self.rotation = rotation or self.rotation
          return self
      end

      function element:Alpha(alpha)
          self.alpha = alpha or self.alha
          return self
      end

      function element:Anchor(x, y)
          self.anchorX = x or self.anchorX
          self.anchorY = y or self.anchorY
      end
   	 return element
   end
   return instance
end

function Frame:Update(visible, target)
   for _, element in next, self.elements do
      if element.e_type == "text" then
         if visible == true then
           ui.addTextArea(element.id, element.text, target, element.x, element.y, element.w, element.h, element.c1, element.c2, element.type, element.fix) 
         else
           ui.removeTextArea(element.id, target)
         end
      elseif element.e_type == "image" then
         if visible == true then
           element.id = tfm.exec.addImage(element.image, element.type, element.x, element.y, target, element.w, element.h, element.rotation, element.alpha, element.anchorX, element.anchorY)
         else
           tfm.exec.removeImage(element.id)
         end
      end
   end
   return self
end
