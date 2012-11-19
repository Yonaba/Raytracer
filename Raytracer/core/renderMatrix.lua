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
  
  local min = math.min
  local assert = assert
  
  local Class = require (_PATH .. '30log')
  local Color = require (_PATH .. 'color')

  local function Matrix2d(width, height)
    local m = {}
    for y = 1, height do m[y] = {}
      for x = 1, width do m[y][x] = 0 end
    end
    return m
  end
    
  local Matrix = Class {}

  function Matrix:__init(width, height, opacity)
    self.width = width
    self.height = height
    self.opacity = opacity or 255
    self._map = Matrix2d(self.width, self.height)
  end

  function Matrix:getPixel(x,y)
    return self._map[y] and self._map[y][x]
  end

  function Matrix:setPixel(x,y,color)
    assert(self._map[y] and self[y][x], 'Out of range!')
    self._map[y][x] = Color(x,y,color.r*255, color.g*255, color.b*255,self.opacity)
  end

  function Matrix:get()
    return self._map
  end  

  return Matrix
end  
