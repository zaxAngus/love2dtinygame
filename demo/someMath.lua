 -------------------------------------------
--某点到鼠标连线线段的角度
function MousePointRad(xx,yy)
	--摄像机内xx=xx-camera.x;yy=yy-camera.y
	local x=love.mouse.getX()-xx
    local y=yy-love.mouse.getY()
    local r=math.deg(math.atan(x/y))
    if x>0 and y>0 then
        r=r
    elseif y<0 then
        r=180+r
    elseif x<0 and y>0 then
        r=360+r
    end
    return r
end
 -------------------------------------------
--两点连线段的角度和距离
function PointPointRad(xx1,yy1,xx2,yy2)
	local x=xx2-xx1
	local y=yy1-yy2
	local r=math.deg(math.atan(x/y))
	if x>0 and y>0 then
        r=r
    elseif y<0 then
        r=180+r
    elseif x<0 and y>0 then
        r=360+r
    end
    local l=(x^2+y^2)^(1/2)
    return r,l
	-- body
end

 -------------------------------------------
 --克隆一个OBJECT
 function clone(object)  
 
    local lookup_table = {}

    local function _copy(object)

        if type(object) ~= "table" then

            return object

        elseif lookup_table[object] then

            return lookup_table[object]

        end

        local new_table = {}

        lookup_table[object] = new_table

        for key, value in pairs(object) do

            new_table[_copy(key)] = _copy(value)

            print(key,value)--这句添加print函数 演示输出复制的过程

        end

        return setmetatable(new_table, getmetatable(object))

    end

    return _copy(object)--返回clone出来的object表指针/地址
end 
  -------------------------------------------
  function updateVertex(obj)
    obj.vertex[1].x=obj.x+((-obj.shape.width/2)*math.cos(-math.rad(obj.rad))+(-obj.shape.height/2)*math.sin(-math.rad(obj.rad)))
    obj.vertex[1].y=obj.y+((obj.shape.width/2)*math.sin(-math.rad(obj.rad))+(-obj.shape.height/2)*math.cos(-math.rad(obj.rad)))
    obj.vertex[2].x=obj.x+((obj.shape.width/2)*math.cos(-math.rad(obj.rad))+(-obj.shape.height/2)*math.sin(-math.rad(obj.rad)))
    obj.vertex[2].y=obj.y+((-obj.shape.width/2)*math.sin(-math.rad(obj.rad))+(-obj.shape.height/2)*math.cos(-math.rad(obj.rad)))
    obj.vertex[3].x=obj.x+((-obj.shape.width/2)*math.cos(-math.rad(obj.rad))+(obj.shape.height/2)*math.sin(-math.rad(obj.rad)))
    obj.vertex[3].y=obj.y+((obj.shape.width/2)*math.sin(-math.rad(obj.rad))+(obj.shape.height/2)*math.cos(-math.rad(obj.rad)))
    obj.vertex[4].x=obj.x+((obj.shape.width/2)*math.cos(-math.rad(obj.rad))+(obj.shape.height/2)*math.sin(-math.rad(obj.rad)))
    obj.vertex[4].y=obj.y+((-obj.shape.width/2)*math.sin(-math.rad(obj.rad))+(obj.shape.height/2)*math.cos(-math.rad(obj.rad)))
  end

function serialize(obj)  
    local lua = ""  
    local t = type(obj)  
    if t == "number" then  
        lua = lua .. obj  
    elseif t == "boolean" then  
        lua = lua .. tostring(obj)  
    elseif t == "string" then  
        lua = lua .. string.format("%q", obj)  
    elseif t == "table" then  
        lua = lua .. "{\n"  
    for k, v in pairs(obj) do  
        lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"  
    end  
    local metatable = getmetatable(obj)  
        if metatable ~= nil and type(metatable.__index) == "table" then  
        for k, v in pairs(metatable.__index) do  
            lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"  
        end  
    end  
        lua = lua .. "}"  
    elseif t == "nil" then  
        return nil  
    else  
        error("can not serialize a " .. t .. " type.")  
    end  
    return lua  
end  
  
function unserialize(lua)  
    local t = type(lua)  
    if t == "nil" or lua == "" then  
        return nil  
    elseif t == "number" or t == "string" or t == "boolean" then  
        lua = tostring(lua)  
    else  
        error("can not unserialize a " .. t .. " type.")  
    end  
    lua = "return " .. lua  
    local func = loadstring(lua)  
    if func == nil then  
        return nil  
    end  
    return func()  
end  