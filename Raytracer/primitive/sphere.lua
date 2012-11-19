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
  local _ROOT = (...):match('%w+%.')
  
  local sqrt = math.sqrt
  local Class = require (_ROOT ..'core.30log')
  local Vec3 = require (_ROOT .. 'core.vec3')
  local Material = require (_ROOT .. 'core.material')

  local Sphere = Class {}
  
  function Sphere:__init(center, radius, material)
    self.center = center or Vec3()
    self.radius = radius or 50
    self.material = material or Material()
    self.radiusSq = self.radius * self.radius
  end

  function Sphere:intersect(ray, t)
    local dist = self.center - ray.origin
    local b = ray.direction:dot(dist)
    local d = (b * b) - dist:dot(dist) + self.radiusSq
    if d < 0 then return false end
    d = sqrt(d)
    local t1 = b - d
    local t2 = b + d
    local hit, dst = false, t
    if t1 > 0.1 and t1 < t then
      dst = t1
      hit = true
    end
    if t2 > 0.1 and t2 < dst then
      dst = t2
      hit = true
    end
    return hit, dst
  end

  function Sphere:normalAt(point)
    return (point - self.center):normalize()
  end

  return Sphere
end
