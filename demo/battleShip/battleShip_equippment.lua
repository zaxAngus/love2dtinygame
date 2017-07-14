
--武器装备和卸除
function battleShip:equipWeapon(weapon,slot)
	    local wea=clone(weapon)
	    wea.x=self.weapon[slot].x
	    wea.y=self.weapon[slot].y
		self.weapon[slot]=wea
		return true

end
function battleShip:unequipWeapon(pos)
end

---------------------
--战机装备和卸除
function battleShip:equipFighter(fig,slot)
	fig.x=self.x
	fig.y=self.y
	self.fighter[slot]=fig
end

function battleShip:unequipPla(pos)

end

