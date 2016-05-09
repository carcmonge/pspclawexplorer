cargaPlug()
while true do		
	elementosBases()
	screen.print(5,10,"< "..files.nopath(memoSelect.."seplugins/"..namePlug).." >",0.7,blanco,negro)
	for i=inf, #tablaPlug do
		if i == posicion then
			Color = colorTXT[valorFonte]
			draw.fillrect(0,y.dir-5,480,20,color.new(0,0,0,100))
			screen.print(20,y.dir,tablaPlug[i].plugin,0.6,Color,negro)
			if controls.press("right") or controls.press("left") then
				tablaPlug[i].estado = tostring((navegador(false,false,true,true,tonumber(tablaPlug[i].estado)+1,2,1)-1))
				pluG = io.open(memoSelect.."seplugins/"..namePlug,"w")
				for j = 1,#tablaPlug do
					pluG:write(tablaPlug[j].plugin..""..tablaPlug[j].estado.."\n")
				end
			io.close(pluG)
			end
		else
			Color = blanco
			screen.print(20,y.dir,tablaPlug[i].plugin,0.6,Color,negro)
		end
		if tablaPlug[i].estado == "0" then
			screen.print(400,y.dir,"Desactivado",0.6,Color,negro)
		elseif tablaPlug[i].estado == "1" then
			screen.print(400,y.dir,"Activado",0.6,Color,negro)
		end
		image.blit(0,y.ico,ico.plug)
		y.dir = y.dir + 20
		y.ico = y.ico + 20
    end
   y.dir = 45 
   y.ico = 40
   scrollPlug()
	if controls.press("square") then
		if os.message("¿Estas seguro de eliminar este plugin?",1) == 1 then
			table.remove(tablaPlug,posicion)
			pluG = io.open(memoSelect.."seplugins/"..namePlug,"w")
			for j = 1,#tablaPlug do
				pluG:write(tablaPlug[j].plugin..""..tablaPlug[j].estado.."\n")
			end
			io.close(pluG)
			cargaPlug()
			posicion = 1
		end
	end
	if controls.press("l") then
		valorPlug = valorPlug - 1
		if valorPlug == 0 then
			valorPlug = 3 
		end
		namePlug = TnamePlugins[valorPlug]..".txt"
		cargaPlug()
		posicion = 1
	end
	if controls.press("r") then
		valorPlug = valorPlug + 1
		if valorPlug == 4 then
			valorPlug = 1 
		end
		namePlug = TnamePlugins[valorPlug]..".txt"
		cargaPlug()
		posicion = 1
	end
	screen.flip()
	if controls.press("start") or controls.press("circle") then
		controls.read()
		break
	end
end
