

	for i=1,2 do
		local dot={x1,x2,x3,x4}
		local max=-1
	    local min=1000
		local k1=(vertex[i].y-vertex[i+i].y)/(vertex[i]-vertex[i+i].x)
		local k2=-1/k1
		local b1=vertex[i].y-k1*vertex[i].x
		for j=5,8 do
			local b2=vertex[j].y-k2*vertex[j].x
			dot[j1]=(b2-b1)/(k1-k2)
			if dot[j1]>max then
			   max=dot[j1]
		    end
		    if dot[j1]<min then
			   min=dot[j1]
		    end
		    j1=j1+1
		end
		if min>vertex[i].x and min>vertex[i+i].x then
		   return false
		elseif	max<vertex[i].x and max<vertex[i+i].x then
		   return false
		end
    end
    return true