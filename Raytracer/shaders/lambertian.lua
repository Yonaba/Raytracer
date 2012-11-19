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

local function LambertShade(material, lightColor, lightRay, normal, coef, x, y)
  local lambert = lightRay.direction:dot(normal) * coef
  --local add =  lightColor * material.diffuse * lambert
  --[[
  if x == 95 and y  == 306 then 
    print('lightColor',lightColor)
    print('diffuse',material.diffuse)
    print('Add', add)
    print('Check',
      (add.r == lambert*lightColor.r*material.diffuse.r) and
      (add.g == lambert*lightColor.g*material.diffuse.g) and
      (add.b == lambert*lightColor.b*material.diffuse.b))   
    io.read()
  end
  --]]
  return lightColor * material.diffuse * lambert
end

return LambertShade