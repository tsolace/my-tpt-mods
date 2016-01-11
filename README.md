# TPT Mods
Lua mods for TPT (actually jacob1's mod, haven't tested them on TPT++)

## FaveElements.lua
Adds the following elements:
- Napalm NPLM from FeynmanLogoMkaer's Lua Elements Pack
- Pure energy ERGY by QuentinADay
- Breakpoints BRPT by boxmein
- Raincloud RCLD (CLD) by mrsalit0s
- Neon gas NEON by mrsalit0s
- Mixed explosive MEXP from QbaMod
- Fire Armour FAMR (GARM) from QbaMod
- Extremely Durable Titanium DTTN by QuentinADay
- VOLS??? by mjpowder
- Powered white hole/black hole PWHL/PBHL by jacob1
- Sound waves SONG from rdococ's RMod

## KeyFinder.lua
Simple keypress printer, only useful for finding keys to use in lua scripts

## LilDude.lua
Adds a controllable particle, DUDE, that can only exist once on screen.
Control with arrow keys. Numpad number keys relative in position to 5 to build a particle (default DMND), change ctype to change building material.
Numpad PLUS for antigravity mode (to stop falling), Numpad 0 to toggle mining mode (destroy particles instead of colliding with them), Numpad decimal (.) to toggle turbo mode (crazy fast movement)

## SingleGate.lua
Implements all of iamdumb's logic gates into one particle. Change tmp value to change functionality.
Functionality for tmp:
 1. AND: SPRKs nearby NSCN when powered by 2 or more PSCN
 2. OR: Conducts from PSCN and to NSCN
 3. NOT: SPRKs nearby NSCN unless powered by PSCN
 4. XOR: SPRKs nearby NSCN if powered by ONE PSCN
 5. NAND: SPRKs nearby NSCN unless powered by 2 or more PSCN
 6. for XNOR: SPRKs nearby NSCN unless powered by ONE PSCN

## TimedElements.lua
Adds elements TRES, RBOM, TTIM, TCOL
- TRES: Tree seed, generates a random tree after existing for 2 seconds (algorithm from SSCCSSCC's Random Tree.lua)
- RBOM: Random bomb, particle changes to a random element after 30 seconds of existance (element randomizer from jacob1's random element mod)
- TTIM: Type timer, changes into its ctype after 30 seconds (variable `timertype` can be changed in console to change default ctype)
- TCOL: Timed color, changes color of all particles every tenth of a second.

## UDParticle.lua (and udprelay.lua.notamod)
Adds the UDP element. Works like WIFI, transmits its temp (in kelvin, floored to an integer) to a UDP relay server. Takes spark from NSCN(?).
UDP relay server is (`udprelay.lua.notamod`) can be run with Lua/LuaJIT on the command line. Be sure to install luasocket (`luarocks(-5.1) install luasocket`)
