
--[[
        Multi-logic Gate mod for TPT:
 
        tmp = 1 for AND: SPRKs nearby NSCN when powered by 2 or more PSCN
        tmp = 2 for OR: Conducts from PSCN and to NSCN
        tmp = 3 for NOT: SPRKs nearby NSCN unless powered by PSCN
        tmp = 4 for XOR: SPRKs nearby NSCN if powered by ONE PSCN
        tmp = 5 for NAND: SPRKs nearby NSCN unless powered by 2 or more PSCN
        tmp = 6 for XNOR: SPRKs nearby NSCN unless powered by ONE PSCN
--]]
 
local frame_counter = 0         -- Counter to prevent crazy nots.
local frame_max = 8             -- More stuff to prevent crazy nots.
 
local el_gate = elements.allocate("logic", "gate")
-- (Begin GATE properties)
 elements.element(el_gate, elements.element(elements.DEFAULT_PT_BRCK))
 elements.property(el_gate, "Name", "GATE")
 elements.property(el_gate, "Colour", 0x800000)
 elements.property(el_gate, "Description", "Multi Logic Gate. PSCN/NSCN in/out. Set tmp: 1=AND 2=OR 3=NOT 4=XOR 5=NAND 6=XNOR")
 elements.property(el_gate, "MenuSection", 1)
-- (End GATE properties)
 
-- Update Functions
-- AND
function and_update(index, partx, party, surround, nt)
        local n_pscn = 0        -- number of SPRK(PSCN found)
 
        for dx = -2, 2, 1 do
                for dy = -2, 2, 1 do
                        if tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_SPRK and tpt.get_property("ctype", partx + dx, party + dy) == elements.DEFAULT_PT_PSCN then
                                n_pscn = n_pscn + 1 -- Increment PSCN count
                        end
                end
        end
 
        if n_pscn >= 2 then
                for dx = -2, 2, 1 do
                        for dy = -2, 2, 1 do
                                if tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_NSCN and tpt.get_property("life", partx + dx, party + dy) == 0 then
                                        tpt.set_property("life", 4, partx + dx, party + dy)     -- SPRK nscn
                                        tpt.set_property("ctype", elements.DEFAULT_PT_NSCN, partx + dx, party + dy)
                                        tpt.set_property("type", elements.DEFAULT_PT_SPRK, partx + dx, party + dy)
                                end
                        end
                end
        end
        return 0
end
 
-- OR
function or_update(index, partx, party, surround, nt)
        local n_pscn = 0        -- number of SPRK(PSCN found)
 
        for dx = -2, 2, 1 do
                for dy = -2, 2, 1 do
                        if tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_SPRK and tpt.get_property("ctype", partx + dx, party + dy) == elements.DEFAULT_PT_PSCN then
                                n_pscn = n_pscn + 1     -- Increment PSCN count
                        end
                end
        end
 
        if n_pscn >= 1 then
                for dx = -2, 2, 1 do
                        for dy = -2, 2, 1 do
                                if tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_NSCN and tpt.get_property("life", partx + dx, party + dy) == 0 then
                                        tpt.set_property("life", 4, partx + dx, party + dy)     -- SPRK nscn
                                        tpt.set_property("ctype", elements.DEFAULT_PT_NSCN, partx + dx, party + dy)
                                        tpt.set_property("type", elements.DEFAULT_PT_SPRK, partx + dx, party + dy)
                                end
                        end
                end
        end
        return 0
end
 
-- NOT
function not_update(index, partx, party, surround, nt)
        frame_counter = frame_counter + 1;
        if frame_counter == frame_max then
                frame_counter = 0
        end
 
        local n_pscn = 0        -- number of SPRK(PSCN found)
 
        for dx = -2, 2, 1 do
                for dy = -2, 2, 1 do
                        if (tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_SPRK and tpt.get_property("ctype", partx + dx, party + dy) == elements.DEFAULT_PT_PSCN) or (tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_PSCN and tpt.get_property("life", partx + dx, party + dy) > 0) then
                                n_pscn = n_pscn + 1     -- Increment PSCN count
                        end
                end
        end
 
        if n_pscn == 0 and frame_counter == 0 then
                for dx = -2, 2, 1 do
                        for dy = -2, 2, 1 do
                                if tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_NSCN and tpt.get_property("life", partx + dx, party + dy) == 0 then
                                        tpt.set_property("life", 4, partx + dx, party + dy)     -- SPRK nscn
                                        tpt.set_property("ctype", elements.DEFAULT_PT_NSCN, partx + dx, party + dy)
                                        tpt.set_property("type", elements.DEFAULT_PT_SPRK, partx + dx, party + dy)
                                end
                        end
                end
        end
        return 0
end
 
-- XOR
function xor_update(index, partx, party, surround, nt)
        local n_pscn = 0        -- number of SPRK(PSCN found)
 
        for dx = -2, 2, 1 do
                for dy = -2, 2, 1 do
                        if tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_SPRK and tpt.get_property("ctype", partx + dx, party + dy) == elements.DEFAULT_PT_PSCN then
                                n_pscn = n_pscn + 1     -- Increment PSCN count
                        end
                end
        end
 
        if n_pscn == 1 then
                for dx = -2, 2, 1 do
                        for dy = -2, 2, 1 do
                                if tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_NSCN and tpt.get_property("life", partx + dx, party + dy) == 0 then
                                        tpt.set_property("life", 4, partx + dx, party + dy)     -- SPRK nscn
                                        tpt.set_property("ctype", elements.DEFAULT_PT_NSCN, partx + dx, party + dy)
                                        tpt.set_property("type", elements.DEFAULT_PT_SPRK, partx + dx, party + dy)
                                end
                        end
                end
        end
        return 0
end
 
-- NAND
function nand_update(index, partx, party, surround, nt)
        frame_counter = frame_counter + 1;
        if frame_counter == frame_max then
                frame_counter = 0
        end
       
        local n_pscn = 0        -- number of SPRK(PSCN found)
       
 
        for dx = -2, 2, 1 do
                for dy = -2, 2, 1 do
                        if (tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_SPRK and tpt.get_property("ctype", partx + dx, party + dy) == elements.DEFAULT_PT_PSCN) or (tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_PSCN and tpt.get_property("life", partx + dx, party + dy) > 0) then
                                n_pscn = n_pscn + 1     -- Increment PSCN count
                        end
                end
        end
 
        if n_pscn < 2 and frame_counter == 0 then
                for dx = -2, 2, 1 do
                        for dy = -2, 2, 1 do
                                if tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_NSCN and tpt.get_property("life", partx + dx, party + dy) == 0 then
                                        tpt.set_property("life", 4, partx + dx, party + dy)     -- SPRK nscn
                                        tpt.set_property("ctype", elements.DEFAULT_PT_NSCN, partx + dx, party + dy)
                                        tpt.set_property("type", elements.DEFAULT_PT_SPRK, partx + dx, party + dy)
                                end
                        end
                end
        end
        return 0
end
 
-- XNOR
function xnor_update(index, partx, party, surround, nt)
        frame_counter = frame_counter + 1;
        if frame_counter == frame_max then
                frame_counter = 0
        end
       
        local n_pscn = 0        -- number of SPRK(PSCN found)
 
        for dx = -2, 2, 1 do
                for dy = -2, 2, 1 do
                        if (tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_SPRK and tpt.get_property("ctype", partx + dx, party + dy) == elements.DEFAULT_PT_PSCN) or (tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_PSCN and tpt.get_property("life", partx + dx, party + dy) > 0) then
                                n_pscn = n_pscn + 1     -- Increment PSCN count
                        end
                end
        end
 
        if (n_pscn ~= 1) and frame_counter == 0 then
                for dx = -2, 2, 1 do
                        for dy = -2, 2, 1 do
                                if tpt.get_property("type", partx + dx, party + dy) == elements.DEFAULT_PT_NSCN and tpt.get_property("life", partx + dx, party + dy) == 0 then
                                        tpt.set_property("life", 4, partx + dx, party + dy)     -- SPRK nscn
                                        tpt.set_property("ctype", elements.DEFAULT_PT_NSCN, partx + dx, party + dy)
                                        tpt.set_property("type", elements.DEFAULT_PT_SPRK, partx + dx, party + dy)
                                end
                        end
                end
        end
        return 0
end


elements.property(el_gate, "Update", function (i, x, y, s, n)
	if tpt.get_property("tmp", i) == 1 then
		return and_update(i, x, y, s, n)
	elseif tpt.get_property("tmp", i) == 2 then
		return or_update(i, x, y, s, n)
	elseif tpt.get_property("tmp", i) == 3 then
		return not_update(i, x, y, s, n)
	elseif tpt.get_property("tmp", i) == 4 then
		return xor_update(i, x, y, s, n)
	elseif tpt.get_property("tmp", i) == 5 then
		return nand_update(i, x, y, s, n)
	elseif tpt.get_property("tmp", i) == 6 then
		return xnor_update(i, x, y, s, n)
	end
end)
 
--[[  ^_^  ]]-- TPT logic gates mod, iamdumb