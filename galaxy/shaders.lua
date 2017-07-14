local _shader={color={}}
------------------------------------------------------------ 
local yellow=love.graphics.newShader([[
  vec4 effect(vec4 color,Image texture,vec2 texture_coords,vec2 screen_coords)
  {
     return vec4(1,1,0,1);
  }
]])
_shader.color.yellow=yellow
------------------------------------------------------------ 
local black=love.graphics.newShader([[
  vec4 effect(vec4 color,Image texture,vec2 texture_coords,vec2 screen_coords)
  {
    return vec4(0,0,0,1);
  }
]])
_shader.color.black=black
------------------------------------------------------------ 
------------------------------------------------------------ 
------------------------------------------------------------ 
------------------------------------------------------------ 
return _shader