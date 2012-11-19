--[[
Copyright (c) 2012 Roland Yonaba

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]

if (...) then 
  local _PATH = (...):gsub('[^%.]+$','')  
  local Class = require (_PATH .. 'core.30log')
  local Vec3 = require (_PATH .. 'core.vec3')
  local Matrix = require (_PATH .. 'core.renderMatrix')
  local Scene = Class {}
  
  
  function Scene:__init(width, height, refViewPoint, viewerDistance, imageData)
    self.width = width or 500
    self.height = height or 500
    self.hw, self.hh = self.width/2, self.height/2
    self.refViewPoint = refViewPoint or Vec3(0,0,500)
    self.viewerDistance = viewerDistance or 100  
    self.image = imageData or Matrix(self.width, self.height)    
    self.objects = {}
    self.lights = {}
  end

  function Scene:addObject(obj)
    self.objects[#self.objects+1] = obj
  end  

  function Scene:addLight(light)
    self.lights[#self.lights+1] = light
  end

  function Scene:setRefViewPoint(rvp)
    self.refViewPoint = rvp
  end

  function Scene:setViewerDistance(d)
    self.viewerDistance = d
  end

  function Scene:getRefViewPoint()
    return self.refViewPoint
  end

  function Scene:getViewerDistance()
    return self.viewerDistance
  end    

  return Scene
end