local weapon=class(object)
function weapon:ctor()
    self.owner=nil
    self.undercontrol=false
    self.x=0
    self.y=0
    self.w=0
    self.h=0
    self.r=0
    self.cost=100
    self.fire_time=2
    self.reload_time=3
    
end