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
  
  local sqrt = math.sqrt
  local type = type
  
  local Class = require (_PATH .. '30log')

  local Vec3 = Class {}

  function Vec3:__init(x, y, z)
    self.x, self.y, self.z = x or 0, y or 0, z or 0
  end
    
  function Vec3:__tostring()
    return ('Vec3: x: %.3f y:%.3f z: %.3f')
            :format(self.x, self.y, self.z)
  end

  function Vec3:length()
    return sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
  end

  function Vec3:normalize()
    local length = 1/sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
    self.x, self.y, self.z = self.x * length, self.y * length, self.z * length
    return self
  end

  function Vec3.__add(a,b)
    return Vec3(a.x + b.x, a.y + b.y, a.z + b.z)
  end

  function Vec3.__sub(a,b)
    return Vec3(a.x - b.x, a.y - b.y, a.z - b.z)
  end

  function Vec3.__mul(v,f)
    if (type(f)=='number') then
      return Vec3(v.x * f, v.y * f, v.z * f)
    end
    return Vec3(v.x * f.x + v.y * f.y + v.z * f.z)
  end

  function Vec3.dot(u , v)
    return (u.x * v.x + u.y * v.y + u.z * v.z)
  end

  return Vec3
end  