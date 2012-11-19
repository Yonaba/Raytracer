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
  local Class = require (_PATH ..'30log')
  
  local Color = Class {}
  
  function Color:__tostring()
    return ('[%s,%s,%s]'):format(self.r,self.g, self.b)
  end

  function Color:__init(r, g, b)
    self.r, self.g, self.b = r or 0, g or 0, b or 0
  end

  function Color.__add(a,b)
    return Color(min(a.r + b.r,1), min(a.g + b.g,1), min(a.b + b.b,1))
  end

  function Color.__sub(a,b)
    return Color(min(a.r - b.r,1), min(a.g - b.g,1), min(a.b - b.b,1))
  end

  function Color.__mul(v,f)
    if (type(f)=='number') then
      return Color(min(v.r * f,1), min(v.g * f,1), min(v.b * f,1))
    end
    return Color(min(v.r * f.r,1), min(v.g * f.g,1), min(v.b * f.b,1))
  end

  return Color
end  