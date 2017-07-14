timeLine={}
function timeLine:new()
	newTimeline={running=false,time=0}
	setmetatable(newTimeline,self)
	self.__index=self
	return newTimeline 
end

function timeLine:start()
	self.running=true
end

function timeLine:stop()
	self.running=false
end

function timeLine:update(dt)
	if self.running then
	    self.time=self.time+dt-- body
	end
	return self.running
end

function timeLine:getTime()
	return self.time
end

