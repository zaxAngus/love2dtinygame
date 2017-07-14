member={class="member"}
function member:new(name,job,skill1,skill2,skill3)
	local newMember={name=n,
	                 skill={[1]=skill1,[2]=skill2,[3]=skill3}
	                 type=job,
	                 img={[1]=nil,[2]=nil}}
	setmetatable(newMember,self)
	self.__index=self
	return newMember
end

skill={}
function skill:new(n,cd,func)
	local newSkill={name=n,
	                CD=cd,CDcount=0,
                    effect=func}
    setmetatable(newSkill,self)
    self.__index=self
    return newSkill
end

