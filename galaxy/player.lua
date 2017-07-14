
local exp_requirement_for_levelup={}
for i=1,100 do
   exp_requirement_for_levelup[i]=200*i
end

local player=class()
function player:ctor()
   self.class_name="player"
   self.name="angus"
   self.icon=nil
   self.money=2000
   self.level=1
   self.exp=0
   self.story=0 
   self.ship=_ship[1].new()
   self.itembox={[1]={},[2]={},[3]={}}
   
end

function player:change_name(name)--改变玩家姓名
   self.name=name
   return true
end

function player:get_item(item)--获得道具
    if item.class_name=="weapon" then
        assert(table.insert(self.weapon_box,item),"weapon_box insert failed")
        return true
    elseif item.class_name=="member" then
        assert(table.insert(self.member_box,item),"member_box insert failed")
        return true
    elseif item.class_name=="battleship" then
        assert(table.insert(self.member_box,item),"battleship_box insert failed")
        return true
    end
end

function player:use_item(item)--使用道具
    item.useon(self)
end

function player:get_exp(exp)--获得经验值
   self.exp=self.exp+exp
   if self.exp>=exp_requirement_for_levelup[self.level+1] then
      self.exp=self.exp-exp_requirement_for_levelup[self.level+1]
      self.level=self.level+1            
   end
   return true
end

function player:get_money(money)--获得金钱
    self.money=self.money+money
    return true
end

function player:save_data()--存档
end

function player:load_data()--读档
end
   
return player

