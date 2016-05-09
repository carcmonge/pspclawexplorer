function slideY2(bool,color1,color2)
	if bool == true then
		draw.gradrect(Xmenu2,0,140,272,color1,color1,color2,color2) 
		if Xmenu2 > 340 then 
			Xmenu2 = Xmenu2 - 10 
		end
		if Xmenu2 <= 340 then
			menuSlide2()
		end
	else 
		draw.gradrect(Xmenu2,0,140,272,color1,color1,color2,color2)
		if Xmenu2< 480 then Xmenu2 = Xmenu2 + 10    end
	end
end
function menuSlide2()
	if menu then
		if slideAlpha == 60 then
			slideAlphaPlus = -1 
		elseif slideAlpha == 0 then
			slideAlphaPlus = 1
		end
		slideAlpha = slideAlpha + slideAlphaPlus
		blancoAlpha = color.new(255,255,255,slideAlpha)
		screen.print(350,105,"Borrar")--1 
		screen.print(350,125,"Opcion 2")--2
		screen.print(350,145,"Opcion 3")--3
		screen.print(350,165,"Opcion 4")--4
		screen.print(350,185,"Opcion 5")--5
		if VM == 1 then
			image.blit(340,95,slide_select)
			draw.gradrect(340,95,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
			borrarCC()
		 elseif VM == 2 then
			image.blit(340,115,slide_select)
			draw.gradrect(340,115,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
		elseif VM == 3 then
			image.blit(340,135,slide_select)
			draw.gradrect(340,135,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
		elseif VM == 4 then
			image.blit(340,155,slide_select)
			draw.gradrect(340,155,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
		elseif VM == 5 then
			image.blit(340,175,slide_select)
			draw.gradrect(340,175,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
		end
		collectgarbage(restart)
	end
end
function navegador2()
   if controls.press("down") and VM > 0 and VM ~= numOpci then
      VM = VM + 1
   elseif  controls.press("down") and VM >= numOpci then 
      VM = 1
   end
   
   if controls.press("up") and (VM ~= 1 or VM > 1) and VM <= numOpci then   
      VM = VM - 1
   elseif  controls.press("up") and VM == 1 then 
      VM = numOpci
   end
end
function borrarCC()
	if controls.press("cross") then
		lista = "\n"
		MensajeCopiar = "¿Quieres eliminar estos archivos?"	
		tmpB = screen.toimage()
		for i=1,#marcados do
			lista = lista.."\n* "..files.nopath(marcados[i])
		end
		if #marcados < 1 then
			os.message("Selecciona alguna opcion de la lista")
		elseif #marcados == 1 then 
			MensajeCopiar = "¿Quieres eliminar este archivo?"
			if os.message(MensajeCopiar..lista,1) == 1 then
				if files.exists(marcados[1]) then
					files.remove(marcados[1],true)
					barraCargado("Eliminando...",1)
				end
			end
		elseif #marcados > 1 then
			if os.message(MensajeCopiar..lista,1) == 1 then
			for m = 1,#marcados do
				if files.exists(marcados[m]) then
					files.remove(marcados[m],true)
					barraCargado("Eliminando...",m)
				end
			end
		end

		os.message(okEliminar)
		--ordenar()
		marcados = {""}
		num_marck = 1
		end
		tmpB:free()
		menu = false
		totalsize = 0
		explorar()
	end
end
size = 0
function explorar()
	rutasCC = {
	memoSelect.."PSP/SYSTEM/ISOCACHE.BIN", 
	memoSelect.."PSP/SYSTEM/BROWSER/historyv.dat",
	memoSelect.."PSP/SYSTEM/BROWSER/bookmarks.html",
	memoSelect.."RECYCLER"
	}
	sizesCC = {}
	for i = 1,#rutasCC do
		if files.exists(rutasCC[i]) then
			workDir = files.list(files.nofile(rutasCC[i]))
			for j=1,#workDir do
				if	workDir[j].name == rutasCC[i] and workDir[j].directory then
					pesoDirCC(workDir[j].name)
					sizesCC[i] = size
					size = 0
				elseif workDir[j].name == rutasCC[i] then
					sizesCC[i] = workDir[j].size
				end
			end
		else
			sizesCC[i] = 0
		end
	end
end

--explorar()
totalsize = 0
--exten = {"jpg","png","rufo","lua"}
--numFileExte = {img=0,music=0,otros=0}
--tmp = io.open("tmp","w")
--recolector(memoSelect,exten)
--io.close(tmp)
rutasCC = {"Accesos Directos"}
marcados = {}
explorar()
--teclados()
--marcados = buscarEXT(memoSelect,newName,marcados)
--os.message(tostring(#marcados).." "..totalsize)

inf = 1
posicion = 1
Xmenu2 = 480
numOpci = 5
menu = false
function fu()   
	if controls.press("down") then
		posicion = posicion + 1
		if posicion > 19 then inf = inf + 1 end
		if posicion > #rutasCC then posicion = 1 end
	end
	if controls.press("up") then  
		posicion = posicion - 1
		if posicion > 18 then inf = inf - 1 end
		if posicion < 1 then posicion = #rutasCC end
	end
end
while true do
   elementosBases()
	for i=inf, #rutasCC do
		check = negro
		for p=1,#marcados do
			if marcados[p] == rutasCC[i] then
				check = color.new(255,255,255)
			end
		end
		if i == posicion then
			Color = colorTXT[valorFonte]
			draw.fillrect(0,y.dir-5,480,20,color.new(0,0,0,100))
			screen.print(20,y.dir,string.format("%.56s",files.nopath(rutasCC[i])),0.6,colorTXT[valorFonte],check)
		else
			Color = blanco
			screen.print(20,y.dir,string.format("%.56s",files.nopath(rutasCC[i])),0.6,blanco,check)
		end
		image.blit(0,y.ico,ico.carpeta)
		screen.print(410,y.dir,files.sizeformat(sizesCC[i]),0.6,Color,negro)
		y.dir = y.dir + 20
		y.ico = y.ico + 20
    end
    y.dir = 45
    y.ico = 40
	if menu == false then fu() end
	slideY2(menu,colorAlpha[valorFonte],colorAlpha[valorFonte])
	screen.flip()
	if controls.press("circle") then
		lanzarLua = nil
		break
	end
	if controls.press("square") then
		for i = 1,#marcados do
			if marcados[i] == rutasCC[posicion] then
				table.remove(marcados,i)
				num_marck = num_marck - 1
			end 
		end
		marcados[num_marck] = rutasCC[posicion]
		num_marck = num_marck + 1
   end
   if controls.press("r") then
		for i = 1,#marcados do
			if marcados[i] == rutasCC[posicion] then
				table.remove(marcados,i)
				num_marck = num_marck - 1
			end 
		end
		if #marcados == 0 then marcados={""} end 
	end
   if menu then navegador2() end
   	if controls.press("triangle") then
		menu = not menu
		VM = 1
	end
end
