local button=require"user_interface.button"
local stateBar=require"user_interface.stateBar"

local _interface={}


--主菜单界面,界面表内索引为1
local mainmenu={}
function mainmenu:create(game)
    local newgame = function(x)
        x.owner:clear()
        x.owner.state=2
        x.owner:create_base()
    end
    local button_startgame=button.new(1,200,50,love.graphics.newImage("testbutton.bmp"),nil,newgame)
    local loadgame = function(x)
        x.user:load_data()
        x.owner:clear()
    end
    local button_loadgame=button.new(2,200,50,love.graphics.newImage("testbutton.bmp"),nil,loadgame)
    local quitgame =function(x)
        love.event.quit()
    end
    local button_quitgame=button.new(3,200,50,love.graphics.newImage("testbutton.bmp"),nil,quitgame)
    if win_w==1280 then
        button_startgame:activate(0,0,game)
        button_loadgame:activate(0,60,game)
        button_quitgame:activate(0,120,game)
    elseif win_w==1920 then
        button_startgame:activate(0,0,game)
        button_loadgame:activate(0,60,game)
        button_quitgame:activate(0,120,game)
    end
    game.background=love.graphics.newImage("menu_background.jpg")
end
table.insert(_interface,mainmenu)

--停泊基地界面，界面表内索引为2
local base={}
function base:create(game)
  local myships=function()
  end
  local button_myships=button.new(4,200,50,love.graphics.newImage("testbutton.bmp"),nil,myships)
  local weapons=function()
  end
  local button_weapons=button.new(5,200,50,love.graphics.newImage("testbutton.bmp"),nil,myships)
  local members=function()
  end
  local button_members=button.new(6,200,50,love.graphics.newImage("testbutton.bmp"),nil,myships)
  local fighters=function()
  end
  local button_fighters=button.new(7,200,50,love.graphics.newImage("testbutton.bmp"),nil,myships)
  local pilots=function()
  end
  local button_pilots=button.new(8,200,50,love.graphics.newImage("testbutton.bmp"),nil,myships)
  local jail=function()
  end 
  local button_jail=button.new(9,200,50,love.graphics.newImage("testbutton.bmp"),nil,myships)
  local back=function(x)
     x.owner.state=1
     x.owner:clear()
     x.owner:create_menu()
  end
  local button_back=button.new(10,200,50,love.graphics.newImage("testbutton.bmp"),nil,back)
  local takeoff=function(x)
     x.owner.state=3
     x.owner:clear()
     x.owner:create_world()
  end
  local button_takeoff=button.new(11,200,50,love.graphics.newImage("testbutton.bmp"),nil,takeoff)
    if win_w==1280 then
        button_takeoff:activate(100,100,game)
    elseif win_w==1920 then
        button_myships:activate(160,0,game)
        button_weapons:activate(400,0,game)
        button_members:activate(640,0,game)
        button_fighters:activate(880,0,game)
        button_pilots:activate(1120,0,game)
        button_jail:activate(1360,0,game)
        button_back:activate(1600,0,game)
        button_takeoff:activate(1720,1030,game)
    end
end
table.insert(_interface,base)

--出航界面，界面表内索引为3
local travel={}
function travel:create(game)
  local stateBar_hp=stateBar.new(1,nil,nil)
  stateBar_hp:activate(win_w-100,0,"hp",game)
end
table.insert(_interface,travel)


return _interface




