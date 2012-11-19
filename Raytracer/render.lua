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
  
  local sqrt, huge = math.sqrt, math.huge
  local MAX_DEPTH = 10
  local Vec3 = require (_PATH .. 'core.vec3')
  local Color = require (_PATH .. 'core.color')
  local Ray = require (_PATH ..'core.ray')
  local LambertShade = require (_PATH .. 'shaders.lambertian')
  local PhongShade = require (_PATH .. 'shaders.phong')

  
  
  local function render(scene)
    for x = 1,scene.width do
      io.write(('Scanning... progress: %.2f %% (%d/%d)\r'):format(x*100/scene.width, x, scene.width))       
      for y = 1,scene.height do
      
        local reflectionCoef = 1
        local depth = 0
        local pixel = Color()
        local rayDirection = Vec3( x-scene.hw, scene.hh-y, scene.viewerDistance)        
        local ray = Ray(scene.refViewPoint, (rayDirection - scene.refViewPoint):normalize())
        
        while (reflectionCoef > 0 and depth < MAX_DEPTH) do
          local t = huge
          local currentObj
          
          for i = 1,#scene.objects do
            local obj = scene.objects[i]
            local intersection, dst = obj:intersect(ray,t)
            if intersection then
              currentObj = obj
              t = dst
            end
          end    
          if not currentObj then break end
         
          local hitPoint = ray:pointAt(t)   
          local normalAtHitPoint = currentObj:normalAt(hitPoint)

          for i = 1,#scene.lights do
            local light = scene.lights[i]
            local dist = light.origin - hitPoint
            if normalAtHitPoint:dot(dist) > 0 then
              local t = sqrt(dist:dot(dist))
              if t > 0 then
                local lightRay = Ray(hitPoint, dist*(1/t))                
                local inShadow = false              
                for i = 1,#scene.objects do
                  local obj = scene.objects[i]
                  local intersection,dst = obj:intersect(lightRay, t)
                  if intersection then
                    t = dst
                    inShadow = true
                    break
                  end             
                end
                
                if not inShadow then              
                  pixel = pixel + LambertShade(currentObj.material, light.color, lightRay, normalAtHitPoint, reflectionCoef)
                  pixel = pixel + PhongShade(currentObj.material, ray, light.color, lightRay, normalAtHitPoint, reflectionCoef)                  
                end
              end
            end
          end
          
         
         reflectionCoef = reflectionCoef * currentObj.material.reflection
         reflection = 2.0 * (ray.direction:dot(normalAtHitPoint))
         
         ray.origin = hitPoint
         ray.direction = ray.direction - normalAtHitPoint * reflection         
          
         depth = depth+1
        end
        
        scene.image:setPixel(x,y,pixel)    
      end
    end    
    return scene.image:get()    
  end

  return render
end  