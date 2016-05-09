function serachP(dirc)
	local lugar2 = files.list(dirc)
	for c = 1,#lugar2 do
		demo:write("\n"..lugar2[c].name)
		if lugar2[c].directory then
			serachP(lugar2[c].name)
		elseif lugar2[c].name:lower():match(palabra) then
			demo:write("\n"..lugar2[c].name)
			numReSearch[indiceCur] = lugar2[c]
			indiceCur = indiceCur + 1
		end
   end
end
function serachE(dirc,ext)
	local lugar2 = files.list(dirc)
	for c = 1,#lugar2 do
		if lugar2[c].directory then
			serachE(lugar2[c].name,ext)
		elseif files.ext(lugar2[c].name) == ext then
			numReSearch[#numReSearch+1] = lugar2[c]
		end
   end
end
function serachtitle(dirc,nombre)
	local lugar2 = files.list(dirc)
	for c = 1,#lugar2 do
		if lugar2[c].directory then
			serachtitle(lugar2[c].name,nombre)
		elseif files.ext(lugar2[c].name) == "mp3" then
			ID3S = sound.id3(lugar2[c].name)
			if ID3S.title:lower():match(nombre) then
				numReSearch[#numReSearch+1] = lugar2[c]
			end
		end
   end
end
function serachartist(dirc,nombre)
	local lugar2 = files.list(dirc)
	for c = 1,#lugar2 do
		if lugar2[c].directory then
			serachartist(lugar2[c].name,nombre)
		elseif files.ext(lugar2[c].name) == "mp3" then
			ID3S = sound.id3(lugar2[c].name)
			if ID3S.artist:lower():match(nombre) then
				numReSearch[#numReSearch+1] = lugar2[c]
			end
		end
   end
end
palabra = ""
VM = 1
numOpci = 4
typeSearch={"Palabra","Extensión","Titulo","Artista"}
valortypeSearch = 1
memoSearch = {"ms0:/","ef0:/"}
valormemoSearch = 1
while true do
	elementosBases()
	VM = navegador(true,true,false,false,VM,numOpci,1)
	screen.print(73,60,palabra,0.7,blanco,negro)
	draw.rect(72,55,360,20,negro)
	draw.line(0,145,480,145,negro)
	if VM == 1 then
		screen.print(240,40,typeSearch[valortypeSearch],0.6,blanco,AliceBlue,"center",480)
		draw.rect(72,55,360,20,blanco)
		if controls.press("cross") then
			teclados(palabra)
			palabra = newName
		end
	else
		screen.print(240,40,typeSearch[valortypeSearch],0.6,blanco,colorTXT[valorFonte],"center",480)
	end
			
	if VM == 2 then
		screen.print(70,90,"Busqueda por: ",0.6,blanco,AliceBlue)
		screen.print(70+(screen.textwidth("Busqueda por: ")),90,typeSearch[valortypeSearch],0.6,blanco,AliceBlue)
		if controls.press("right") or controls.press("left") then
			valortypeSearch = navegador(false,false,true,true,valortypeSearch,#typeSearch,1)
			word_trac = ""
		end
	else  
		screen.print(70,90,"Busqueda por: ",0.6,blanco,colorTXT[valorFonte])
		screen.print(70+(screen.textwidth("Busqueda por: ")),90,typeSearch[valortypeSearch],0.6,blanco,negro)
	end
			
	if VM == 3 then
		screen.print(70,110,"Buscar en: ",0.6,blanco,AliceBlue)
		if pspGO then
			screen.print(70+(screen.textwidth("Buscar en: ")),110,memoSearch[valormemoSearch],0.6,blanco,AliceBlue)
			if controls.press("right") or controls.press("left") then
				valormemoSearch = navegador(false,false,true,true,valormemoSearch,#memoSearch,1)
			end
		else
			screen.print(70+(screen.textwidth("Buscar en: ")),110,memoSearch[valormemoSearch],0.6,color.new(100,100,100),negro)
			if controls.press("right") or controls.press("left") then
				valormemoSearch = navegador(false,false,true,true,valormemoSearch,1,1)
			end
		end
	else 
		screen.print(70,110,"Buscar en: ",0.6,blanco,colorTXT[valorFonte])
		screen.print(70+(screen.textwidth("Buscar en: ")),110,memoSearch[valormemoSearch],0.6,blanco,negro)	
	end		
	if VM == 4 then
		screen.print(240,130,"Buscar",0.6,blanco,AliceBlue,"center",480)
		if controls.press("cross") then
			if valortypeSearch == 1 then
				dir_busqueda = memoSearch[valormemoSearch]
				indiceCur = 1
				if palabra != nil and palabra != "" then
					busqueda = true
					numReSearch = {}
					demo = io.open("busqueda.txt","w")
					serachP(dir_busqueda)
					io.close(demo)
					os.message("Se encontraron "..#numReSearch.." archivos")
				elseif palabra == nil or palabra == "" then
					os.message(errorRenomb)
				end
			elseif valortypeSearch == 2 then
				dir_busqueda = memoSearch[valormemoSearch]
				indiceCur = 1
				if palabra != nil and palabra != "" then
					busqueda = true
					numReSearch = {}
					demo = io.open("busqueda.txt","w")
					serachE(dir_busqueda,palabra)
					io.close(demo)
					os.message("Se encontraron "..#numReSearch.." archivos")
				elseif palabra == nil or palabra == "" then
					os.message(errorRenomb)
				end
			elseif valortypeSearch == 3 then
				dir_busqueda = memoSearch[valormemoSearch]
				indiceCur = 1
				if palabra != nil and palabra != "" then
					busqueda = true
					numReSearch = {}
					demo = io.open("busqueda.txt","w")
					serachtitle(dir_busqueda,palabra)
					io.close(demo)
					os.message("Se encontraron "..#numReSearch.." archivos")
				elseif palabra == nil or palabra == "" then
					os.message(errorRenomb)
				end
			elseif valortypeSearch == 4 then
				dir_busqueda = memoSearch[valormemoSearch]
				indiceCur = 1
				if palabra != nil and palabra != "" then
					busqueda = true
					numReSearch = {}
					demo = io.open("busqueda.txt","w")
					serachartist(dir_busqueda,palabra)
					io.close(demo)
					os.message("Se encontraron "..#numReSearch.." archivos")
				elseif palabra == nil or palabra == "" then
					os.message(errorRenomb)
				end
			end
				
		end
	else
		screen.print(240,130,"Buscar",0.6,blanco,negro,"center",480)
	end
	if busqueda then
		numOpci = 5
		if VM == 5 then
			screen.print(240,150,"Ver resultados ("..#numReSearch..")",0.6,blanco,AliceBlue,"center",480)
			draw.line(0,145,480,145,blanco)
			if controls.press("cross") then
				in_slideTrans = false
				in_explorer = true
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
			screen.print(240,150,"Ver resultados ("..#numReSearch..")",0.6,blanco,negro,"center",480)
		end
	end
	if controls.press("circle") then
		break
	end
	screen.flip()
end