SUCCESS = "SUCCESS"
FAILED = "FAILED"
READY = "READY"
RUNNING = "RUNNING"
-----------------------------------------------------------------------
BTTree={root,owner}
function BTTree:setOwner(owner)
    self.owner = owner
    if self.root and self.root.setOwner and type(self.root.setOwner) then
        self.root:setOwner(owner)
    end
end
function BTTree:GetOwner()
    return self.owner
end
function BTTree:update()
    self.root:visit()
    self.root:step()
end
function BTTree:reset()
    self.root:reset()
end
-----------------------------------------------------------------------
BTNode={
        status=FAILED,
        children={},
        childrenID=1,
        owner=0
        }
function BTNode:new(t)
	t=t or {}
	setmetatable(t,self)
	self.__index=self
	return t
end
function BTNode:setOwner(owner)
	self.owner = owner
	if self.children then
        for k,v in pairs(self.children) do
            if self.children[k] then
                self.children[k]:setOwner(owner)
            end
        end
    end
end

function BTNode:visit()--子节点个性化
	self.status = FAILED
end

function BTNode:step()
    if self.status ~= RUNNING then
        self:reset()
    elseif self.children then
        for k, v in ipairs(self.children) do
            v:step()
        end
    end
end
function BTNode:reset()
    if self.status ~= READY then
        self.status = READY
        if self.children then
            for idx, child in ipairs(self.children) do
                child:reset()
            end
        end
    end
end

function BTNode:addChild(node)
	node.owner=self.owner
	table.insert(self.children,node)
	--先插入的节点在左侧
end


-----------------------------------------------------------------------
BTNode_sequence=BTNode:new()
BTNode_sequence.name="sequence"
BTNode_sequence.children={[1]=nil,[2]=nil}
function BTNode_sequence:visit( ... )
	if self.status ~= RUNNING then
        self.childrenID = 1
    end
	while self.childrenID<=#self.children do
		local value=self.children[self.childrenID]
		value:visit()
		if value.status==FAILED or value.status==RUNNING then
			self.status=value.status
		    return
		end
		self.childrenID=self.childrenID+1
	end
	self.status=SUCCESS
end

function BTNode_sequence:reset()
    if self.status ~= READY then
        self.status = READY
        if self.children then
            for idx, child in ipairs(self.children) do
                child:reset()
            end
        end
    end
    self.childrenID = 1
end

-----------------------------------------------------------------------
BTNode_selector=BTNode:new()
function BTNode_selector:visit( )
	while self.childrenID<=#self.children do
		local value=self.children[self.childrenID]
		value:visit()
		if value.status==SUCCESS or value.status==RUNNING then
			self.status=value.status
		    return
		end
		self.childrenID=self.childrenID+1
	end
	self.childrenID=1
	self.status=FAILED
end
-----------------------------------------------------------------------
BTNode_parallel=BTNode:new()
function BTNode_parallel:visit( ... )

	self.childrenID=1
	self.status=FAILED
end
-----------------------------------------------------------------------
BTNode_condition=BTNode:new()
BTNode_condition.name="conditionNode"
function BTNode_condition:visit()--交给具体状态节点个性化
	if self.func(self.owner) then
		self.status=SUCCESS
	else
		self.status=FAILED
	end
end

BTNode_condition_enemyDetect=BTNode_condition:new()
BTNode_condition_enemyDetect.func=function (obj)
	local x=battleFiled.enemyShip[1].x
	local y=battleFiled.enemyShip[1].y
	local r,l=PointPointRad(obj.x,obj.y,x,y)
	if l>obj.detectRange then
		return true--检测范围内没敌人
	else 
		return false--检测范围内有敌人
	end
    end

-----------------------------------------------------------------------
BTNode_action=BTNode:new()
BTNode_action.name="actionNode"
function BTNode_action:visit()--交给具体动作节点个性化
	self.status=FAILED
end
-------------------------------------------------
--具体的动作节点
BTNode_action_move=BTNode_action:new()
function BTNode_action_move:visit()
	self.owner:move()
	self.state=SUCCESS
end
BTNode_action_turnR=BTNode_action:new()
BTNode_action_turnL=BTNode_action:new()
BTNode_action_driftR=BTNode_action:new()
BTNode_action_driftL=BTNode_action:new()
BTNode_action_weaTurnR=BTNode_action:new()
BTNode_action_weaTurnL=BTNode_action:new()
BTNode_action_weaFire=BTNode_action:new()
-----------------------------------------------------------------------




