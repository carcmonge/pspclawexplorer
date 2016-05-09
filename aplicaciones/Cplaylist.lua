--[[
 * PSP Claw Explorer
 * Copyright 2016 Carlos Monge.
 * Licensed under MIT (https://github.com/carcmonge/pspclawexplorer/blob/master/LICENSE)
]]--
function serachFilesList(dirc)
	local lugar2 = files.list(dirc)
	for c = 1,#lugar2 do
		demo:write("\n"..lugar2[c].name)
		if lugar2[c].directory then
			serachFilesList(lugar2[c].name)
		else
			demo:write("\n"..lugar2[c].name)
			numReSearch[indiceCur] = lugar2[c]
			indiceCur = indiceCur + 1
		end
   end
end
VM = 1
while true do
	elementosBases()
	VM = navegador(true,true,false,false,VM,numOpci,1)
	screen.print(5,10,"Creador de Playlist",0.8,blanco,negro)
	screen.print(73,60,palabra,0.7,blanco,negro)
	draw.rect(72,55,360,20,negro)
	draw.line(0,125,480,125,negro)
	if VM == 1 then
		screen.print(240,40,"Nombre del Playlist:",0.6,blanco,AliceBlue,"center",480)
		draw.rect(72,55,360,20,blanco)
		if controls.press("cross") then
			teclados(palabra)
			palabra = newName
		end
	else
		screen.print(240,40,"Nombre del Playlist:",0.6,blanco,colorTXT[valorFonte],"center",480)
	end
			
	if VM == 2 then
		screen.print(70,90,"Lugar: ",0.6,blanco,AliceBlue)
		screen.print(70+(screen.textwidth("Lugar: ")),90,typeList[valortypeList],0.6,blanco,AliceBlue)
		if controls.press("right") or controls.press("left") then
			valortypeList = navegador(false,false,true,true,valortypeList,#typeList,1)
			word_trac = ""
		end
	else  
		screen.print(70,90,"Lugar: ",0.6,blanco,colorTXT[valorFonte])
		screen.print(70+(screen.textwidth("Lugar: ")),90,typeList[valortypeList],0.6,blanco,negro)
	end
			
	if VM == 3 then
		screen.print(240,110,"Buscar archivos en "..typeList[valortypeList]..":",0.6,blanco,AliceBlue,"center",480)
		if controls.press("cross") then
			if valortypeList == 1 then
				dir_busqueda = memoSelect.."MUSIC"
			elseif valortypeList == 2 then
				dir_busqueda = memoSelect.."PICTURE"
			elseif valortypeList == 3 then
				dir_busqueda = memoSelect.."VIDEO"
			end
			indiceCur = 1
			busqueda = true
			numReSearch = {}
			demo = io.open("busqueda.txt","w")
			serachFilesList(dir_busqueda)
			io.close(demo)
			os.message("Se encontraron "..#numReSearch.." archivos")
		end
	else
		screen.print(240,110,"Buscar archivos en "..typeList[valortypeList]..":",0.6,blanco,negro,"center",480)
	end
	if busqueda then
		draw.line(0,165,480,165,negro)
		numOpci = 6
		if VM == 4 then
			screen.print(240,130,"Archivos en la carpeta "..typeList[valortypeList].." ("..#numReSearch..")",0.6,blanco,AliceBlue,"center",480)
			draw.line(0,125,480,125,blanco)
			if controls.press("cross") then
				in_slideTrans = false
				in_explorer = true
				boolPLayList = true
				busqueda = true
				shell = false
				indice      = 1
				indice2    = 11
				limInf     = 1
				curDicT = numReSearch
				--numReSearch = nil
				--numReSearch = {}
				table.sort(curDicT,sp)
				break
			end
		else
			screen.print(240,130,"Archivos en la carpeta "..typeList[valortypeList].." ("..#numReSearch..")",0.6,blanco,negro,"center",480)
		end
		if VM == 5 then
			screen.print(240,150,"Archivos en la lista de reproduccion ("..#numReSearch..")",0.6,blanco,AliceBlue,"center",480)
			
			if controls.press("cross") then
				os.message(";D")
			end
		else
			screen.print(240,150,"Archivos en la lista de reproduccion ("..#numReSearch..")",0.6,blanco,negro,"center",480)
		end
		if VM == 6 then
			screen.print(240,170,"Crear Playlist",0.6,blanco,AliceBlue,"center",480)
			draw.line(0,165,480,165,blanco)
			if palabra != nil and palabra != "" then
				os.message(";D")
			else
				os.message(errorRenomb)
			end
		else
			screen.print(240,170,"Crear Playlist",0.6,blanco,negro,"center",480)
		end
	else
		numOpci = 3
	end
	
	if controls.press("circle") then
		break
	end
	screen.flip()
end