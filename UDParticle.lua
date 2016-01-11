--User Datagram Particle
--Sends to UDParticle server, default 127.0.0.1 25533
--Set dgserver to the server to send data to
--Set dgport to the port of the server

dgserver = "127.0.0.1"
dgport   = 25533

sok = socket.udp()
sok:settimeout(0)
function sokconnect()
	sok:settimeout(0)
	sok:setpeername(dgserver, dgport)
	sok:send("hello")
end

local UDPS = elements.allocate("SOLACE", "UDPS")
elements.element(elements.SOLACE_PT_UDPS, elements.element(elements.DEFAULT_PT_WIFI))
elements.property(elements.SOLACE_PT_UDPS, "Name", "UDP")
elements.property(elements.SOLACE_PT_UDPS, "Description", "Send/receive sparks with UDP server, variable dgserver:dgport, works like WIFI")
elements.property(elements.SOLACE_PT_UDPS, "Colour", 0x00FF00)
elements.property(elements.SOLACE_PT_UDPS, "MenuSection", elem.SC_ELEC)
elements.property(elements.SOLACE_PT_UDPS, "Update", function (i,x,y,s,n)
	for dx = -1, 1, 1 do
		for dy = -1, 1, 1 do
			if tpt.get_property("type", x + dx, y + dy) == elements.DEFAULT_PT_SPRK and tpt.get_property("ctype", x + dx, y + dy) ~= elements.DEFAULT_PT_NSCN then
				sok:setpeername(dgserver, dgport)
				sok:send(math.floor(tpt.get_property("temp", i)))
				return
			end
		end
	end
end)

--[[local UDPS = elements.allocate("SOLACE", "UDPR")
elements.element(elements.SOLACE_PT_UDPR, elements.element(elements.DEFAULT_PT_WIFI))
elements.property(elements.SOLACE_PT_UDPR, "Name", "UDPR")
elements.property(elements.SOLACE_PT_UDPR, "Description", "Receive spark from UDP server, variable dgserver:dgport")
elements.property(elements.SOLACE_PT_UDPR, "Colour", 0xFFFF00)
elements.property(elements.SOLACE_PT_UDPR, "MenuSection", elem.SC_ELEC)
elements.property(elements.SOLACE_PT_UDPR, "Update", function (i,x,y,s,n)
	rb = sok:receive()
	if rb ~= nil then
		--tpt.log("got a datagram " .. tostring(tonumber(rb)) .. ", my temp is " .. tostring(tpt.get_property("temp", i)))
		if math.floor(tonumber(rb)) == math.floor(tpt.get_property("temp", i)) then
			--tpt.log("is my channel")
			for dx = -1, 1, 1 do
				for dy = -1, 1, 1 do
					if tpt.get_property("type", x+dx, y+dy) == elements.DEFAULT_PT_NSCN then
						tpt.set_property("type", elements.DEFAULT_PT_SPRK, x+dx, y+dy)
						tpt.set_property("ctype", elements.DEFAULT_PT_NSCN, x+dx, y+dy)
					end
				end
			end
		end
	end
end)]]--

tpt.register_step( function ()
	rb = sok:receive()
	if rb ~= nil then
		for i in sim.parts() do
			if tpt.get_property("type", i) == elements.SOLACE_PT_UDPS then
				y = tpt.get_property("y", i)
				x = tpt.get_property("x", i)
				if math.floor(tonumber(rb)) == math.floor(tpt.get_property("temp", i)) then
					--tpt.log("is my channel")
					for dx = -1, 1, 1 do
						for dy = -1, 1, 1 do
							if tpt.get_property("type", x+dx, y+dy) == elements.DEFAULT_PT_NSCN then
								tpt.set_property("type", elements.DEFAULT_PT_SPRK, x+dx, y+dy)
								tpt.set_property("ctype", elements.DEFAULT_PT_NSCN, x+dx, y+dy)
							end
						end
					end
				end
			end
		end
	end
end)

sokconnect()