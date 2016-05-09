contador2 = 0
tablaTXT = {}
txt = io.open(curDicT[indice].name,"r")
for linea in io.lines(curDicT[indice].name) do
	contador2 = contador2 + 1
	tablaTXT[contador2] = linea
end
io.close(txt)
local posicion  = 1
local limiteInf = 1
local limiteSup = 19
local posicionX = 0
function textoArriba()
	if posicion > 1 then  
		posicion = posicion - 1
		if posicion > 17 then limiteInf = limiteInf - 1   end
		if limiteSup-limiteInf == 19  then 
			limiteSup = limiteSup - 1  
		end
	end
end
function textoAbajo()
	if posicion < #tablaTXT then
		posicion = posicion + 1
		if posicion > 18 then limiteInf = limiteInf + 1 end
		if posicion > 18 and posicion < #tablaTXT then 
			limiteSup = limiteSup + 1  
		end
	end
end
while true do
	controls.read()
	draw.fillrect(0,0,480,272,blanco)
	draw.gradrect(0,0,480,25,GhostWhite,GhostWhite,negro,negro)
	if 	limiteSup < 100 then
		posicionX = 20
	elseif limiteSup >= 100 and limiteSup < 1000 then
		posicionX = 25
	elseif limiteSup >= 1000 and limiteSup < 10000 then
		posicionX = 35
	end
	draw.gradrect(0,25,posicionX,272,AliceBlue,GhostWhite,AliceBlue,GhostWhite)
	local x       = 40
	local y       = 25
   
	for i= limiteInf, limiteSup do
		if posicion == i  then
			draw.fillrect(posicionX,y-1,480,12,color.new(0,0,0,100))
		end
		screen.print(posicionX+5,y,tablaTXT[i],0.6,negro,0x0)
		screen.print(0,y,i,0.5,negro,0x0)
		y    = y + 13
	end


	if controls.press("up") then textoArriba() end
	if controls.press("down") then textoAbajo() end
	if controls.down() and controls.r() then textoAbajo() end
	if controls.up() and controls.r() then textoArriba() end
	if controls.press("start") then
		lineaModificada = os.osk("Edita el texto",tablaTXT[posicion],1000,1000,0)
		if lineaModificada then
			table.insert(tablaTXT,posicion,lineaModificada)
			table.remove(tablaTXT,posicion+1)
		end
	end
	screen.flip()
	if controls.press("circle") then
		controls.read()
		break
	end
end
