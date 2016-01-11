
--TreeSeed TRES, from SSCCSSCC's Random Tree.lua
r=0
local TRES = elements.allocate("SOLACE", "TRES")
elements.element(elements.SOLACE_PT_TRES, elements.element(elements.DEFAULT_PT_DUST))
elements.property(elements.SOLACE_PT_TRES, "Name", "TRES")
elements.property(elements.SOLACE_PT_TRES, "Description", "Seed to generate random tree after 2 seconds")
elements.property(elements.SOLACE_PT_TRES, "Colour", 0x00FF00)
elements.property(elements.SOLACE_PT_TRES, "MenuSection", elem.SC_SPECIAL)
elements.property(elements.SOLACE_PT_TRES, "Update", function (i,x,y,s,n)
	if tpt.get_property("tmp2", i) == 1 then
		if os.time() > tpt.get_property("tmp", i) + 2 then
			local k=math.random(40,55)
			local kk=math.random(40,55)
			local l=math.random(55,90)
			local ll=math.random(10,22)
			local lll=math.random(10,22)
			for o = 1 , l do
				local b=math.random(0,10)
				if b==1 then
					local r=r+1
					tpt.create(x+r,y-o, 'wood')
					x=x+1
				elseif b==2 then
					local r=r-1
					tpt.create(x+r,y-o, 'wood')
					x=x-1
				else
					tpt.create(x,y-o, 'wood')
				end
			 
				if o==39 then
					for i = 1 , 2 do
						tpt.create(x+i,y-39, 'plnt')
					end
					for i = 1 , 2 do
						tpt.create(x-i,y-39, 'plnt')
					end
				end
			 
				if o==40 then
					for i = 1 , 3 do
						tpt.create(x+i,y-40, 'plnt')
					end
					for i = 1 , 3 do
						tpt.create(x-i,y-40, 'plnt')
					end
				end
			 
				if o==k then
					yb=y
					for i = 1 , ll do
						local q=math.random(0,4)
						if q==1 then
							tpt.create(x+i,y-k-i, 'wood')
							y=y+1
						elseif b==2 then
							tpt.create(x+i,y-k-i, 'wood')
							y=y-1
						else
							tpt.create(x+i,y-k-i, 'wood')
						end
						tpt.create(x+i,y-k-i, 'vine')
					end
					y=yb
				end
			 
				if o==kk then
					yb=y
					for i = 1 , lll do
						local q=math.random(0,4)
						if q==1 then
							tpt.create(x-i,y-kk-i, 'wood')
							y=y+1
						elseif b==2 then
							tpt.create(x-i,y-kk-i, 'wood')
							y=y-1
						else
							tpt.create(x-i,y-kk-i, 'wood')
						end
						tpt.create(x-i,y-kk-i, 'vine')
					end
					y=yb
				end
			 
				if o==l-1 then
					tpt.create(x,y-l, 'vine')
				end
			end
			tpt.set_property("type","wood",i)
		end
	else
		tpt.set_property("tmp", os.time(), i)
		tpt.set_property("tmp2", 1, i)
	end
--tpt.set_property("type","wood","tres")
end)

--Random Bomb RBOM, from jacob1's Random Element.lua
local RBOM = elements.allocate("SOLACE", "RBOM")
elements.element(elements.SOLACE_PT_RBOM, elements.element(elements.DEFAULT_PT_DMND))
elements.property(elements.SOLACE_PT_RBOM, "Properties", TYPE_LIQUID)
elements.property(elements.SOLACE_PT_RBOM, "State", ST_LIQUID)
elements.property(elements.SOLACE_PT_RBOM, "Falldown", 2)
elements.property(elements.SOLACE_PT_RBOM, "Advection", 0.04)
elements.property(elements.SOLACE_PT_RBOM, "Loss", 1)
elements.property(elements.SOLACE_PT_RBOM, "Gravity", 0.04)
elements.property(elements.SOLACE_PT_RBOM, "AirLoss", 0.90)
elements.property(elements.SOLACE_PT_RBOM, "Weight", 3)
elements.property(elements.SOLACE_PT_RBOM, "Name", "RBOM")
elements.property(elements.SOLACE_PT_RBOM, "Description", "Liquid Random Bomb, turns into random element after 30 seconds")
elements.property(elements.SOLACE_PT_RBOM, "Color", 0xFFFE8915)
elements.property(elements.SOLACE_PT_RBOM, "MenuSection", elem.SC_SPECIAL)
elements.property(elements.SOLACE_PT_RBOM, "Update", function (i)
	if tpt.get_property("tmp2", i) == 1 then
		if os.time() > tpt.get_property("tmp", i) + 30 then
			tpt.set_property("tmp", 0, i)
			tpt.set_property("tmp2", 0, i)
			pcall(tpt.set_property, "type", math.random(1,255), i)
		end
	else
		tpt.set_property("tmp", os.time(), i)
		tpt.set_property("tmp2", 1, i)
	end
end)


--Type Timer TTIM, original element
timertype = "DMND"
local TTIM = elements.allocate("SOLACE", "TTIM")
elements.element(elements.SOLACE_PT_TTIM, elements.element(elements.DEFAULT_PT_DMND))
elements.property(elements.SOLACE_PT_TTIM, "Properties", TYPE_LIQUID)
elements.property(elements.SOLACE_PT_TTIM, "State", ST_LIQUID)
elements.property(elements.SOLACE_PT_TTIM, "Falldown", 2)
elements.property(elements.SOLACE_PT_TTIM, "Advection", 0.04)
elements.property(elements.SOLACE_PT_TTIM, "Loss", 1)
elements.property(elements.SOLACE_PT_TTIM, "Gravity", 0.04)
elements.property(elements.SOLACE_PT_TTIM, "AirLoss", 0.90)
elements.property(elements.SOLACE_PT_TTIM, "Weight", 3)
elements.property(elements.SOLACE_PT_TTIM, "Name", "TTIM")
elements.property(elements.SOLACE_PT_TTIM, "Description", "Type Timer liquid, changes to variable timertype or its ctype after 30 sec, use console 'timertype = 'DMND'")
elements.property(elements.SOLACE_PT_TTIM, "Color", 0x8F468F)
elements.property(elements.SOLACE_PT_TTIM, "MenuSection", elem.SC_SPECIAL)
elements.property(elements.SOLACE_PT_TTIM, "Update", function (i)
	if tpt.get_property("tmp2", i) == 1 then
		if os.time() > tpt.get_property("tmp", i) + 30 then
			tpt.set_property("tmp", 0, i)
			tpt.set_property("tmp2", 0, i)
			tpt.set_property("type", tpt.get_property("ctype",i), i)
		end
	else
		tpt.set_property("tmp", os.time(), i)
		tpt.set_property("tmp2", 1, i)
		tpt.set_property("ctype", timertype, i)
	end
end)


tpt.register_step(function ()
	if checkedtime == 1 then
		if socket.gettime() > settime + 0.1 then
			nr, ng, nb = math.random(50,255), math.random(50,255), math.random(50,255)
			checkedtime = 0
		end
	else
		settime = socket.gettime()
		checkedtime = 1
	end
end)



local TCOL = elements.allocate("SOLACE", "TCOL")
elements.element(elements.SOLACE_PT_TCOL, elements.element(elements.DEFAULT_PT_DMND))
--elements.property(elements.SOLACE_PT_TCOL, "Properties", TYPE_LIQUID)
--elements.property(elements.SOLACE_PT_TCOL, "State", ST_LIQUID)
--elements.property(elements.SOLACE_PT_TCOL, "Falldown", 2)
--elements.property(elements.SOLACE_PT_TCOL, "Advection", 0.04)
--elements.property(elements.SOLACE_PT_TCOL, "Loss", 1)
--elements.property(elements.SOLACE_PT_TCOL, "Gravity", 0.04)
--elements.property(elements.SOLACE_PT_TCOL, "AirLoss", 0.90)
--elements.property(elements.SOLACE_PT_TCOL, "Weight", 3)
elements.property(elements.SOLACE_PT_TCOL, "Name", "TCOL")
elements.property(elements.SOLACE_PT_TCOL, "Description", "Random color every tenth/second")
elements.property(elements.SOLACE_PT_TCOL, "Color", 0xFFFFFF)
elements.property(elements.SOLACE_PT_TCOL, "MenuSection", elem.SC_SPECIAL)
elements.property(elements.SOLACE_PT_TCOL, "Graphics", function (i, r, g, b)
	return 0, PMODE_FLAT, nr, ng, nb
end)