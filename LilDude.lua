local DUDE = elements.allocate("SOLACE", "DUDE")
elements.element(elements.SOLACE_PT_DUDE, elements.element(elements.DEFAULT_PT_DMND))
elements.property(elements.SOLACE_PT_DUDE, "Name", "DUDE")
elements.property(elements.SOLACE_PT_DUDE, "Description", "Control a little dude with arrow keys, break blocks with numpad 0")
elements.property(elements.SOLACE_PT_DUDE, "Colour", 0xE892DF)
elements.property(elements.SOLACE_PT_DUDE, "MenuSection", elem.SC_SPECIAL)

local nup = false
local ndown = false
local nright = false
local nleft = false
local active = true
local mining = false
local turbo = false
local count = 0
local antigravity = false

local cn, cnw, cne, cs, csw, cse, ce, cw = false, false, false, false, false, false, false, false -- hitler's phone number
local function dctrl(key,dkey,_,event)
	if dkey == 273 and event == 1 then
		nup = true
		ndown = false
		nright = false
		nleft = false
		cn, cnw, cne, cs, csw, cse, ce, cw = false, false, false, false, false, false, false, false
		active = true
	end
	if dkey == 274 and event == 1 then
		nup = false
		ndown = true
		nright = false
		nleft = false
		cn, cnw, cne, cs, csw, cse, ce, cw = false, false, false, false, false, false, false, false
		active = true
	end
	if dkey == 276 and event == 1 then
		nup = false
		ndown = false
		nright = true
		nleft = false
		cn, cnw, cne, cs, csw, cse, ce, cw = false, false, false, false, false, false, false, false
		active = true
	end
	if dkey == 275 and event == 1 then
		nup = false
		ndown = false
		nright = false
		nleft = true
		cn, cnw, cne, cs, csw, cse, ce, cw = false, false, false, false, false, false, false, false
		active = true
	end
	if dkey == 256 and event == 1 then
		mining = not mining
		if mining then
			tpt.log("Mining mode active")
		elseif not mining then
			tpt.log("Mining mode inactive")
		end
	end
	if dkey == 266 and event == 1 then
		turbo = not turbo
		if turbo then
			tpt.log("Turbo mode active (There should only be one DUDE on screen)")
		elseif not turbo then
			tpt.log("Turbo mode inactive")
		end
	end
	if dkey == 270 and event == 1 then
		antigravity = not antigravity
		if antigravity then
			tpt.log("Antigravity active")
		elseif not gravity then
			tpt.log("Antigravity inactive")
		end
	end
	
	if dkey == 263 then cnw, cn, cne, csw, cs, cse, ce, cw, active, nup, ndown, nleft, nright = true , false, false, false, false, false, false, false, true, false, false, false, false end
	if dkey == 264 then cnw, cn, cne, csw, cs, cse, ce, cw, active, nup, ndown, nleft, nright = false, true , false, false, false, false, false, false, true, false, false, false, false end
	if dkey == 265 then cnw, cn, cne, csw, cs, cse, ce, cw, active, nup, ndown, nleft, nright = false, false, true , false, false, false, false, false, true, false, false, false, false end
	
	if dkey == 257 then cnw, cn, cne, csw, cs, cse, ce, cw, active, nup, ndown, nleft, nright = false, false, false, true , false, false, false, false, true, false, false, false, false end
	if dkey == 258 then cnw, cn, cne, csw, cs, cse, ce, cw, active, nup, ndown, nleft, nright = false, false, false, false, true , false, false, false, true, false, false, false, false end
	if dkey == 259 then cnw, cn, cne, csw, cs, cse, ce, cw, active, nup, ndown, nleft, nright = false, false, false, false, false, true , false, false, true, false, false, false, false end
	
	if dkey == 260 then cnw, cn, cne, csw, cs, cse, ce, cw, active, nup, ndown, nleft, nright = false, false, false, false, false, false, false, true , true, false, false, false, false end
	if dkey == 262 then cnw, cn, cne, csw, cs, cse, ce, cw, active, nup, ndown, nleft, nright = false, false, false, false, false, false, true , false, true, false, false, false, false end
	if event == 2 and turbo then
		active = false
	end
end

dudetype = "DMND"
local function dudectrl(i,x,y,s,n)
	count = count + 1
	if count > 1 then
		tpt.set_property("type", 0, i)
		return
	end
	if tpt.get_property("ctype",i)==elements.DEFAULT_PT_NONE then
		tpt.set_property("ctype",dudetype,i)
	end
	if tpt.get_property("tmp2",i)==0 then
		if active then
			if nup then
				if mining then
					tpt.set_property("type", 0, x, y-1)
				end
				if tpt.get_property("type", x, y-2) + tpt.get_property("type", x, y-1) == 0 then
					tpt.set_property('y',y-2,i)
				end
				--tpt.create(x,y-1,tpt.get_property("ctype", i))
			end
			if ndown then
				if mining then
					tpt.set_property("type", 0, x, y+1)
				end
				if tpt.get_property("type", x, y+1) == 0 then
					tpt.set_property('y',y+1,i)
				end
				--tpt.create(x,y+1,tpt.get_property("ctype", i))
			end
			if nright then
				if mining then
					tpt.set_property("type", 0, x-1, y)
				end
				if tpt.get_property("type", x-1, y) == 0 then
					tpt.set_property('x',x-1,i)
				elseif tpt.get_property("type",x-1,y-1) == 0 then
					tpt.set_property('x',x-1,i)
					tpt.set_property('y',y-1,i)
				end
				--tpt.create(x-1,y,tpt.get_property("ctype", i))
			end
			if nleft then
				if mining then
					tpt.set_property("type", 0, x+1, y)
				end
				if tpt.get_property("type", x+1, y) == 0 then
					tpt.set_property('x',x+1,i)
				elseif tpt.get_property("type", x+1, y-1) == 0 then
					tpt.set_property('x',x+1,i)
					tpt.set_property('y',y-1,i)
				end
				--tpt.create(x+1,y,tpt.get_property("ctype", i))
			end
			if cnw then tpt.create(x-1, y-1, tpt.get_property("ctype", i)) end
			if cn  then tpt.create(x  , y-1, tpt.get_property("ctype", i)) end
			if cne then tpt.create(x+1, y-1, tpt.get_property("ctype", i)) end
			if ce  then tpt.create(x+1, y  , tpt.get_property("ctype", i)) end
			if cw  then tpt.create(x-1, y  , tpt.get_property("ctype", i)) end
			if csw then tpt.create(x-1, y+1, tpt.get_property("ctype", i)) end
			if cs  then tpt.create(x  , y+1, tpt.get_property("ctype", i)) end
			if cse then tpt.create(x+1, y+1, tpt.get_property("ctype", i)) end
			if not turbo then
				active = false
			end
		end
		if tpt.get_property("type", x, y+1) == 0 and not antigravity then
			tpt.set_property('y',y+1,i)
		end
	end
end

tpt.element_func(dudectrl,elements.SOLACE_PT_DUDE)
tpt.register_keypress(dctrl)
tpt.register_step(function ()
	count = 0
end)