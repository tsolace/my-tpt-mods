--Solace's favorite elements from many different scripts and creators


--[[FeynmanLogoMaker's Lua Elements Pack, NPLM]]--
local NPLM = elements.allocate("FEYNMAN", "NPLM")
elements.element(elements.FEYNMAN_PT_NPLM, elements.element(elements.DEFAULT_PT_BCOL))
elements.property(elements.FEYNMAN_PT_NPLM, "Name", "NPLM")
elements.property(elements.FEYNMAN_PT_NPLM, "Description", "Napalm, very slow-burning powder")
elements.property(elements.FEYNMAN_PT_NPLM, "Colour", 0x850000)
elements.property(elements.FEYNMAN_PT_NPLM, "MenuSection", elem.SC_EXPLOSIVE)
elements.property(elements.FEYNMAN_PT_NPLM, "Gravity", .5)
elements.property(elements.FEYNMAN_PT_NPLM, "Flammable", 0)
elements.property(elements.FEYNMAN_PT_NPLM, "Explosive", 0)
elements.property(elements.FEYNMAN_PT_NPLM, "Loss", 1)
elements.property(elements.FEYNMAN_PT_NPLM, "AirLoss", .5)
elements.property(elements.FEYNMAN_PT_NPLM, "AirDrag", .01)
elements.property(elements.FEYNMAN_PT_NPLM, "Advection", .01)
elements.property(elements.FEYNMAN_PT_NPLM, "Weight", 50)
elements.property(elements.FEYNMAN_PT_NPLM, "Diffusion", 0)
NPLMUpdate = function(i, x, y, s, n)
	if tpt.get_property('type', x, y) ~= 0 then
		clife = tpt.get_property('life', x, y)
	else
		clife = 0
	end
	if clife > 1 then
		for cx = -1, 1, 2 do
			for cy = -1, 1, 2 do
				tpt.create(x + cx, y + cy, 'fire')
			end
		end
		tpt.set_property('life', clife - 1, x, y)
	elseif clife == 1 then
		tpt.set_property('type', 0, x, y)
	elseif s > 0 then
		for cx = -1, 1, 2 do
			for cy = -1, 1, 2 do
				if tpt.get_property('type', x + cx, y + cy) == 4 or tpt.get_property('type', x + cx, y + cy) == 49 then
					tpt.set_property('life', 500, x, y)
					return true
				end
			end
		end
	end
end
tpt.element_func(NPLMUpdate, tpt.element('nplm'))
NPLMgraphics = function(i, colr, colg, colb)
        return 1,0x00000011,255,125,0,0,255,125,0,0
end
tpt.graphics_func(NPLMgraphics, tpt.element('nplm'))
--[[end]]--

--[[FeynmanLgooMaker's Lua Elements Pack, REP
local REP = elements.allocate("FEYNMAN", "REP")
elements.element(elements.FEYNMAN_PT_REP, elements.element(elements.DEFAULT_PT_BCOL))
elements.property(elements.FEYNMAN_PT_REP, "Name", "REP")
elements.property(elements.FEYNMAN_PT_REP, "Description", "Replicating Powder!")
elements.property(elements.FEYNMAN_PT_REP, "Colour", 0xFF9000)
elements.property(elements.FEYNMAN_PT_REP, "MenuSection", elem.SC_POWDERS)
elements.property(elements.FEYNMAN_PT_REP, "Gravity", .5)
elements.property(elements.FEYNMAN_PT_REP, "Flammable", 0)
elements.property(elements.FEYNMAN_PT_REP, "Explosive", 0)
elements.property(elements.FEYNMAN_PT_REP, "Loss", 1)
elements.property(elements.FEYNMAN_PT_REP, "AirLoss", .5)
elements.property(elements.FEYNMAN_PT_REP, "AirDrag", .01)
elements.property(elements.FEYNMAN_PT_REP, "Advection", .01)
elements.property(elements.FEYNMAN_PT_REP, "Weight", 0)
elements.property(elements.FEYNMAN_PT_REP, "Diffusion", 0)
REPUpdate = function(i, x, y, s, n)
	if not(cx == 0 and cy == 0) and tpt.get_property('life', x, y) == 0 then
		local ctmp = tpt.get_property('tmp', x, y)
		for cx = -1, 1 do
			for cy = -1, 1 do
				tpt.create(x + cx, y + cy, 'rep')
				tpt.set_property('life', ctmp + 1, x+cx, y+cy)
				if ctmp == 0 then
					tpt.set_property('tmp', ctmp + 10, x+cx, y+cy)
				else
					tpt.set_property('tmp', ctmp, x+cx, y+cy)
				end
			end
		end
		tpt.set_property('type', 0, x, y)
	elseif tpt.get_property('life', x, y) == 0 then
		tpt.set_property('tmp', 10, x, y) --Default tmp to 10
	else
		tpt.set_property('life', tpt.get_property('life', x, y) - 1, x, y)
	end
end
	
end
tpt.element_func(REPUpdate, tpt.element('REP'))
--[[end]]--

--[[QuentinADay's Pure Energy, ERGY]]--
local ERGY = elements.allocate("PURE" , "ENERGY")
elements.element(ERGY, elements.element(elements.DEFAULT_PT_SING))
elements.property(ERGY, "Name" , "ERGY")
elements.property(ERGY, "Description" , "Pure Energy, Extremely Powerful")
function ENERGYUpdate(i,x,y,s,n)
    if math.random(1,3) == 1 then
        tpt.create(x + math.random(-1,1), y + math.random(-1,1), 'phot')
    elseif math.random(1,3) == 2 then
        tpt.create(x + math.random(-1,1), y + math.random(-1,1), 'neut')
    elseif math.random(1,3) == 3 then
        tpt.create(x + math.random(-1,1), y + math.random(-1,1), 'elec')
    end
    tpt.set_property("temp", math.huge, x, y)
    sim.pressure(x/4,y/4,math.huge)
end
tpt.element_func(ENERGYUpdate,ERGY)
--[[end]]--

--[[electronic_steve's Light and lamps, LAMP
local quality=2
local function light(x,y,speed,radius,RGBA)
	if RGBA[1] == 0 and RGBA[2] == 0 and RGBA[3] == 0 then return end
	for angle =0,360,speed do 
		for radiuss=2,radius,quality do 
		local tx=x+(radiuss*(math.cos(math.deg (angle))))
		local ty=y+(radiuss*(math.sin(math.deg (angle))))
			if x >0 and x<610 and y>0 and y<383 and  tx >0 and tx<610 and ty>0 and ty<383  then 

				if tpt.get_property("type",tx,ty) == 0 then if radius == radiuss then tpt.drawline(x,y,tx,ty,RGBA[1],RGBA[2],RGBA[3],RGBA[4])   end  else 
				tpt.drawline(x,y,tx,ty,RGBA[1],RGBA[2],RGBA[3],RGBA[4])  break    
			
				end
			end
		end
	end
end

local ESMD = elements.allocate("ESMD", "LAMP")
elements.element(elements.ESMD_PT_LAMP, elements.element(tpt.element("BRCK")))
elements.property(elements.ESMD_PT_LAMP, "Name", "LAMP")
elements.property(elements.ESMD_PT_LAMP, "Description", " Color code: red=life, green=tmp, blue=tmp2.")
elements.property(elements.ESMD_PT_LAMP, "MenuVisible", 1)
elements.property(elements.ESMD_PT_LAMP, "MenuSection", 1)
elements.property(elements.ESMD_PT_LAMP, "Colour", 0xcdc9c9)
elements.property(elements.ESMD_PT_LAMP, "Temperature", 20+273.15)

local function lampFunc(i)
	light(tpt.get_property("x",i),tpt.get_property("y",i),1,50,{tpt.get_property("life",i),tpt.get_property("tmp",i),tpt.get_property("tmp2",i),15})
end
tpt.graphics_func(lampFunc,tpt.element("LAMP"))
--[[end]]--

--[[boxmein's breakpoints, BRPT]]--
-- breakpoint element for very slow spark circuit debugging
brptbypass = 0
local ellie = elem.allocate("boxmein", "BRPT")
elem.element(ellie, elem.element(elem.DEFAULT_PT_DMND))
elem.property(ellie, "Name", "BRPT")
elem.property(ellie, "Colour", 0xDEADBEEF)
elem.property(ellie, "Description", "Breakpoints. When spark is touching, will pause the game and turn themselves red. Also glowy.")
elem.property(ellie, "MenuSection", elem.SC_POWERED)
elem.property(ellie, "Properties", elem.PROP_LIFE_DEC)
elem.property(ellie, "Update", function (i, x, y, ss, nt) 
    local life = sim.partProperty(i, "life")
    for ry=-1,1,1 do 
      for rx=-1,1,1 do
        if life == 0 and tpt.get_property("type", x+rx, y+ry) == 15 then
          if brptbypass == 0 then
            tpt.set_pause(1)
            sim.partProperty(i, "life", 10)
          end
        end
      end
    end
  end)

elem.property(ellie, "Graphics", function (i, colr, colg, colb) 
  local x, y = sim.partPosition(i)
  local life = sim.partProperty(i, "life")
  if life > 0 then
    pixel_mode = 296
    colg, colb = 0, 0
    colr = 255
  else

    pixel_mode = 1
  end
  return 0,pixel_mode,255,colr,colg,colb,255,colr,colg,colb
  end)
--[[end]]--

--[[MrSalit0s Mod, CLD]]--
local Cloud = elements.allocate("MOD", "RCLD")
elements.element(elements.MOD_PT_RCLD, elements.element(elements.DEFAULT_PT_WTRV))
elements.property(elements.MOD_PT_RCLD, "Name", "RCLD")
elements.property(elements.MOD_PT_RCLD, "Description", "Raincloud - produces water")
elements.property(elements.MOD_PT_RCLD, "Colour", 0x00FFFFFF)
elements.property(elements.MOD_PT_RCLD, "MenuSection", 6)
elements.property(elements.MOD_PT_RCLD, "Loss", 0.1)
elements.property(elements.MOD_PT_RCLD, "AirLoss", 0.3)
elements.property(elements.MOD_PT_RCLD, "Advection", 1)
elements.property(elements.MOD_PT_RCLD, "Diffusion", 0.3)
elements.property(elements.MOD_PT_RCLD, "Temperature", 273.15)

local function cloud(i,x,y,s,n)
local w=math.random(0,2000)
	if w==1000 then
		tpt.parts[i].type=elements.DEFAULT_PT_WATR
	end
end

tpt.element_func(cloud,elements.MOD_PT_RCLD)
--[[end]]--

--[[MrSalit0s Mod, NEON]]--
local NEON = elements.allocate("MOD", "NEON")
elements.element(elements.MOD_PT_NEON, elements.element(elements.DEFAULT_PT_NBLE))
elements.property(elements.MOD_PT_NEON, "Name", "NEON")
elements.property(elements.MOD_PT_NEON, "Description", "Neon gas - glows in contact with electricity")
elements.property(elements.MOD_PT_NEON, "Colour", 0x00242424)
elements.property(elements.MOD_PT_NEON, "MenuSection", 6)
elements.property(elements.MOD_PT_NEON, "Loss", 0.1)
elements.property(elements.MOD_PT_NEON, "AirLoss", 1)
elements.property(elements.MOD_PT_NEON, "Advection", 0.4)
elements.property(elements.MOD_PT_NEON, "Diffusion", 0.5)
elements.property(elements.MOD_PT_NEON, "Temperature", 295)
elements.property(elements.MOD_PT_NEON, "Gravity", 0)
elements.property(elements.MOD_PT_NEON, "Flammable", 0)
elements.property(elements.MOD_PT_NEON, "Weight", 0)
elements.property(elements.MOD_PT_NEON, "Properties", 0x4828)

local colour={0xFFAA0000,0xFFFF6600,0xFFFFFF00,0xFF00FF00,0xFF00FFFF,0xFF0000FF,0xFF9900CC}
local none=0x00242424

local function neon(i,x,y,s,n)
    if tpt.get_property("tmp",i)== 0 then
        tpt.set_property("tmp",1,i)
    end
    if tpt.get_property("tmp2",i)== 1 then
        tpt.set_property("life",180+math.random(0,20),i)
        tpt.set_property("tmp2",0,i)
    end
    if tpt.parts[i].life<=0 then
        tpt.set_property("dcolour",none,i)
    end
end

local function neonsprk(i,x,y,s,n)
	local ntmp=tpt.get_property("tmp",i)
	local neontype=tpt.get_property("ctype",i)
	if tpt.get_property("ctype",i)==elements.MOD_PT_NEON then
		if tpt.get_property("tmp",i)==ntmp then
			if colour[ntmp] ~= nil then
				tpt.set_property("dcolour",colour[ntmp], x, y)
				tpt.set_property("tmp2",1, x, y)
			end
		end
		if tpt.get_property("tmp",i)==8 then
			tpt.set_property("dcolour",colour[math.random(1,7)],i)
			tpt.set_property("tmp2",1,i)
		end
	end
end

local function neongraphics(i, colr, colg, colb)
    return 1,0x00022110,30,30,30,30,30,30,30,30
end

tpt.graphics_func(neongraphics,elements.MOD_PT_NEON)
tpt.element_func(neon,elements.MOD_PT_NEON)
tpt.element_func(neonsprk,elements.DEFAULT_PT_SPRK)
--[[end]]--

--[[QbaMod, MEXP]]--
elements.allocate('QBAMOD', 'MEXP')
elements.element(elements.QBAMOD_PT_MEXP, elements.element(elements.DEFAULT_PT_TNT))
elements.property(elements.QBAMOD_PT_MEXP, 'Name', 'MEXP')
elements.property(elements.QBAMOD_PT_MEXP, 'Description', 'Mixed Explosive')
elements.property(elements.QBAMOD_PT_MEXP, 'MenuSection', '5')
elements.property(elements.QBAMOD_PT_MEXP, 'Colour', '0xAD9B12')
elements.property(elements.QBAMOD_PT_MEXP, 'Properties', elements.ST_SOLID + elements.TYPE_SOLID)
function mexp_update(i,x,y,s,n)
mexprandom = math.random(0,5)
	if mexprandom == 0 then
		tpt.set_property("type", "ligh", x, y)
	elseif mexprandom == 1 then
		tpt.set_property("type", "plsm", x, y)
	elseif mexprandom == 2 then
		tpt.set_property("type", "bomb", x, y)
	elseif mexprandom == 3 then
		tpt.set_property("type", "dest", x, y)
	elseif mexprandom == 4 then
		tpt.set_property("type", "thdr", x, y)
	else
		tpt.set_property("type", "nitr", x, y)
	end
end
tpt.element_func(mexp_update, tpt.element("mexp"))
--[[end]]--

--[[QbaMod, GARM]]--
elements.allocate('QBAMOD', 'GARM')
elements.element(elements.QBAMOD_PT_GARM, elements.element(elements.DEFAULT_PT_TTAN))
elements.property(elements.QBAMOD_PT_GARM, 'Name', 'FAMR')
elements.property(elements.QBAMOD_PT_GARM, 'Description', 'Fire forged armour.')
elements.property(elements.QBAMOD_PT_GARM, 'Properties', elements.ST_SOLID + elements.TYPE_SOLID)

function garm_update(i,x,y,s,n)
	garmrandom = math.random(0,4)
	if garmrandom == 0 then
		tpt.set_property("type", "ttan", x, y)
	elseif garmrandom == 1 then
		tpt.set_property("type", "qrtz", x, y)
	elseif garmrandom == 2 then
		tpt.set_property("type", "coal", x, y)
	elseif garmrandom == 3 then
		tpt.set_property("type", "brck", x, y)
	else
		tpt.set_property("type", "iron", x, y)
	end
end
tpt.element_func(garm_update, elements.QBAMOD_PT_GARM)
--[[end]]--

--[[QuentinADay's Extremely Durable TTAN, DTTN]]--
elements.allocate('QAD', 'DTTN')
elements.element(elements.QAD_PT_DTTN, elements.element(elements.DEFAULT_PT_TTAN))
elements.property(elements.QAD_PT_DTTN, 'Name', 'DTTN')
elements.property(elements.QAD_PT_DTTN, 'Description', 'Extremely durable TTAN. Evades VIRS and DEST.')
elements.property(elements.QAD_PT_DTTN, 'Properties', elements.ST_SOLID + elements.TYPE_SOLID)
elements.property(elements.QAD_PT_DTTN, "HeatConduct" , 0)
elements.property(elements.QAD_PT_DTTN, "Hardness" , 0)
elements.property(elements.QAD_PT_DTTN, "Weight" , 10000)
sim.can_move(elements.DEFAULT_PT_DEST, elements.QAD_PT_DTTN, 0)
function ttan1(i,x,y,s,n)
	local type = tpt.get_property("temp", x, y)
	if type > 300 then
		tpt.set_property("temp", -math.huge, x, y)
	end
	tpt.set_property("temp", -math.huge, x, y)
	local type = tpt.get_property("type", x + math.random(-3,3), y + math.random(-3,3))
	if type == tpt.el.dest.id then
		sim.gravMap(x/4, y/4, -256)
	end
	local type = tpt.get_property("type", x + math.random(-1,1), y + math.random(-1,1))
	if type == tpt.el.virs.id or type == tpt.el.vrss.id or type == tpt.el.vrsg.id then
		tpt.create(x + math.random(-1,1), y + math.random(-1,1), 'soap')
	end
	local rx,ry = x + math.random(-1,1), y + math.random(-1,1)
	local type = tpt.get_property("type", rx, ry)
	if type == tpt.el.soap.id then
		tpt.delete(rx, ry)
	end
end
tpt.element_func(ttan1,elements.QAD_PT_DTTN)
--[[end]]--

--[[mjpowder's Vols, VOLS]]--
local VOLS = elements.allocate("MOD", "VOLS")
elements.element(elements.MOD_PT_VOLS, elements.element(elements.DEFAULT_PT_DUST))
elements.property(elements.MOD_PT_VOLS, "Name", "VOLS")
elements.property(elements.MOD_PT_VOLS, "Description", "VOL")
elements.property(elements.MOD_PT_VOLS, "Colour", 0x2BE0CB)
elements.property(elements.MOD_PT_VOLS, "MenuSection", elem.SC_GAS)
elements.property(elements.MOD_PT_VOLS, "Loss", 0.1)
elements.property(elements.MOD_PT_VOLS, "AirLoss", 1)
elements.property(elements.MOD_PT_VOLS, "Advection", 0.4)
elements.property(elements.MOD_PT_VOLS, "Diffusion", 0.5)
elements.property(elements.MOD_PT_VOLS, "Temperature", 295)
elements.property(elements.MOD_PT_VOLS, "Gravity", 15)
elements.property(elements.MOD_PT_VOLS, "Flammable",98997)
elements.property(elements.MOD_PT_VOLS, "Weight", 999)
elements.property(elements.MOD_PT_VOLS, "Properties", 0x4828)
--[[end]]--

--[[jacob1's Powered BHOL/WHOL]]--
local jmod = tpt.version.jacob1s_mod --my mod has PROP_POWERED and makes things much simpler
if elem.JACOB1_PT_PBHL then elem.free(elem.JACOB1_PT_PBHL) end --don't error with "Identifier already in use"
if elem.JACOB1_PT_PWHL then elem.free(elem.JACOB1_PT_PWHL) end --don't error with "Identifier already in use"

local PBHL = elem.allocate("JACOB1", "PBHL")
elem.element(PBHL, elem.element(elem.DEFAULT_PT_NBHL))
elem.property(PBHL, "Name", "PBHL")
elem.property(PBHL, "Description", "Powered black hole.")
elem.property(PBHL, "MenuSection", elem.SC_POWERED)
if jmod then
	elem.property(PBHL, "Properties", elem.property(PBHL, "Properties") + elem.PROP_POWERED)
end

local PWHL = elem.allocate("JACOB1", "PWHL")
elem.element(PWHL, elem.element(elem.DEFAULT_PT_NWHL))
elem.property(PWHL, "Name", "PWHL")
elem.property(PWHL, "Description", "Powered white hole.")
elem.property(PWHL, "MenuSection", elem.SC_POWERED)
if jmod then
	elem.property(PWHL, "Properties", elem.property(PWHL, "Properties") + elem.PROP_POWERED)
end

local function pbhlupdate(i,x,y,s,n)
	local life = sim.partProperty(i, sim.FIELD_LIFE)
	local itype = sim.partProperty(i, sim.FIELD_TYPE)
	if life == 10 then
		local amount = 1.5 --normal BHOL is .1, use 1.5 here because we can't add .1 to the current gravity, we can only set exact values
		local tmp = sim.partProperty(i, sim.FIELD_TMP) --tmp affects strength
		if tmp > 0 then
			amount = .015*tmp
			if amount < 1.5 then amount = 1.5
			elseif amount > 768 then amount = 768 end
		end
		sim.gravMap(x/4, y/4, itype == PBHL and amount or -amount)

		for r in sim.neighbors(x,y,1,1) do --loop through neighbors for things to kill or (if not my mod) things that turn it off
			local rtype = sim.partProperty(r, sim.FIELD_TYPE)
			if not jmod then
				if rtype == itype and sim.partProperty(r, sim.FIELD_LIFE) == 9 then
					sim.partProperty(i, sim.FIELD_LIFE, 9)
				elseif rtype == tpt.el.sprk.id and sim.partProperty(r, sim.FIELD_CTYPE) == tpt.el.nscn.id then
					sim.partProperty(i, sim.FIELD_LIFE, 9)
				end
			end
			if rtype ~= nil then
				if itype == PBHL and rtype ~= itype and bit.band(elem.property(rtype, "Properties"), 0x1F) ~= 4 then
					sim.partKill(r)
				end
			end
		end
	elseif not jmod then
		if life > 0 then sim.partProperty(i, sim.FIELD_LIFE, life-1) return end --decrease life by 1 every frame
		for r in sim.neighbors(x,y,1,1) do --loop through neighbors for things to turn it on
			local rtype = sim.partProperty(r, sim.FIELD_TYPE)
			if rtype == itype and sim.partProperty(r, sim.FIELD_LIFE) == 10 then
				sim.partProperty(i, sim.FIELD_LIFE, 10)
			elseif rtype == tpt.el.sprk.id and sim.partProperty(r, sim.FIELD_CTYPE) == tpt.el.pscn.id then
				sim.partProperty(i, sim.FIELD_LIFE, 10)
			end
		end
	end
end
elem.property(PBHL, "Update", pbhlupdate)

local function pbhlgraphics(i,colr,colg,colb)
	local life = sim.partProperty(i, sim.FIELD_LIFE)
	local divide = life == 10 and 1 or (2.5-life/8)
    return 0,1,255,colr/divide,colg/divide,colb/divide
end
elem.property(PBHL, "Graphics", pbhlgraphics)


elem.property(PWHL, "Update", pbhlupdate)
elem.property(PWHL, "Graphics", pbhlgraphics)
--[[end]]--

--[[rdococ's RMod, Sound Waves SONG]]--
local sound = elem.allocate("ENERGY", "SOUND")
elem.element(sound, elem.element(elem.DEFAULT_PT_ELEC))
elem.property(sound, "Name", "SONG")
elem.property(sound, "Description", "Sound waves. Heavy energy. Displaces non-solid materials. By rdococ.")
elem.property(sound, "Colour", 0x0080A0)
elem.property(sound, "MenuSection", elem.SC_RADIOACTIVE)
elem.property(sound, "Properties", elem.TYPE_ENERGY)
elem.property(sound, "State", elem.ST_NONE)
elem.property(sound, "Temperature", 273.15)
elem.property(sound, "HeatConduct", 0)
elem.property(sound, "Weight", 99)

local function supdate(i, x, y, s, nt)
	local tmp2 = sim.partProperty(i, sim.FIELD_TMP2)
	if tmp2 == 0 then
		local angle = math.random() * math.pi*2

		sim.partProperty(i, sim.FIELD_TMP2, 1)
		sim.partProperty(i, sim.FIELD_VX, math.sin(angle)*5)
		sim.partProperty(i, sim.FIELD_VY, math.cos(angle)*5)
	end
end
local function sglow(i, colr, colg, colb)
    return 1,ren.PMODE_FLAT+ren.FIRE_BLEND,1,colr,colg,colb,210,colr,colg,colb
end

elem.property(sound, "Update", supdate)
elem.property(sound, "Graphics", sglow)
--[[end]]--