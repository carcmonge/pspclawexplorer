function scrollList()   
	if controls.press("down") then
		posicion = posicion + 1
		if posicion > 11 then inf = inf + 1 end
		if posicion > #listasT then 
			posicion = 1
			inf = 1			
		end
	end
	if controls.press("up") then  
		posicion = posicion - 1
		if posicion > 10 then inf = inf - 1 end
		if posicion == 0 then 
			posicion = #listasT
			if posicion > 10 then inf = #listasT-10 end		
		end
	end
end
function scrollListCon()   
	if controls.press("down") then
		posicion = posicion + 1
		if posicion > 11 then inf = inf + 1 end
		if posicion > #TfileContenidos then 
			posicion = 1
			inf = 1			
		end
	end
	if controls.press("up") then  
		posicion = posicion - 1
		if posicion > 10 then inf = inf - 1 end
		if posicion == 0 then 
			posicion = #TfileContenidos
			if posicion > 10 then inf = #TfileContenidos-10 end		
		end
	end
end
function pintarListas()
	for i=inf, #listasT do
		if i == posicion then
			Color = colorTXT[valorFonte]
			draw.fillrect(0,y.dir-5,480,20,color.new(0,0,0,100))
			screen.print(20,y.dir,files.nopath(listasT[i].name),0.6,Color,negro)
		else
			Color = blanco
			screen.print(20,y.dir,files.nopath(listasT[i].name),0.6,Color,negro)
		end
		image.blit(0,y.ico,ico.txt)
		y.dir = y.dir + 20
		y.ico = y.ico + 20
    end
end
function pintarArchivos()
	for i=inf, #TfileContenidos do
		if i == posicion then
			Color = colorTXT[valorFonte]
			draw.fillrect(0,y.dir-5,480,20,color.new(0,0,0,100))
			screen.print(10,y.dir,files.nopath(TfileContenidos[i].name),0.6,Color,negro)
		else
			Color = blanco
			screen.print(10,y.dir,files.nopath(TfileContenidos[i].name),0.6,Color,negro)
		end
			screen.print(400,y.dir,TfileContenidos[i].exists,0.6,Color,negro)
		y.dir = y.dir + 20
    end
end
while true do		
	elementosBases()
	if boolListas then
		screen.print(5,10,"< "..memoSelect..nameplaylist.." >",0.7,blanco,negro)
	else
		screen.print(5,10,nomLista,0.7,blanco,negro)
	end
	if boolListas then
		pintarListas()
		scrollList()
	else
		pintarArchivos()
		scrollListCon()
	end

	y.dir = 45
	y.ico = 40

	if controls.press("cross") and boolListas then
		txt = io.open(listasT[posicion].name)
		TfileContenidos = {}
		contador2 = 0
		for linea in io.lines(listasT[posicion].name) do
			contador2 = contador2 + 1      
			if files.exists(linea) then
				archivoexist= "Existe"
			else
				archivoexist= "No Existe"
			end
			TfileContenidos[contador2] = {name=linea,exists=archivoexist}
		end
		io.close(txt)
		boolListas = false
		nomLista = files.nopath(listasT[posicion].name)
		posicion = 1
		inferior = 1
		tope = 16
		posicion = 1
		inf = 1
	end
	
	if controls.press("l") and boolListas then
		boolListas = true
		valorList = valorList - 1
		if valorList == 0 then
			valorList = 3 
		end
		nameplaylist = Tnameplaylist[valorList]
		listasT = files.list(memoSelect.."PSP/PLAYLIST/"..nameplaylist)
		for i = 1, #listasT do
			if files.ext(listasT[i].name) != "m3u8" then
				table.remove(listasT,i)
			end
		end
		posicion = 1
		inferior = 1
		tope = 16
		posicion = 1
		inf = 1
	end
	if controls.press("r") and boolListas then
		boolListas = true
		valorList = valorList + 1
		if valorList == 4 then
			valorList = 1 
		end
		nameplaylist = Tnameplaylist[valorList]
		listasT = files.list(memoSelect.."PSP/PLAYLIST/"..nameplaylist)
		for i = 1, #listasT do
			if files.ext(listasT[i].name) != "m3u8" then
				table.remove(listasT,i)
			end
		end
		posicion = 1
		inferior = 1
		tope = 16
		posicion = 1
		inf = 1
	end
	screen.flip()
	if boolListas then
		if controls.press("start") or controls.press("circle") then
			controls.read()
			break
		end
		if controls.press("square") then
			if os.message("¿Estas seguro de eliminar este Playlist?",1) == 1 then
				if files.exists(listasT[posicion].name) then
					files.remove(listasT[posicion].name,true)
					table.remove(listasT,posicion)
					boolListas = true
					nameplaylist = Tnameplaylist[valorList]
					listasT = files.list(memoSelect.."PSP/PLAYLIST/"..nameplaylist)
					for i = 1, #listasT do
						if files.ext(listasT[i].name) != "m3u8" then
							table.remove(listasT,i)
						end
					end
					posicion = 1
					inferior = 1
					tope = 16
					posicion = 1
					inf = 1
				end
			end
		end
		if controls.press("triangle") then
			
		end
	else
		if controls.press("start") or controls.press("circle") then
			boolListas = true
			nameplaylist = Tnameplaylist[valorList]
			listasT = files.list(memoSelect.."PSP/PLAYLIST/"..nameplaylist)
			for i = 1, #listasT do
				if files.ext(listasT[i].name) != "m3u8" then
					table.remove(listasT,i)
				end
			end
			posicion = 1
			inferior = 1
			tope = 16
			posicion = 1
			inf = 1
		end
	end
end
