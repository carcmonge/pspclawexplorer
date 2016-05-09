if in_slideTrans == true and #curDicT > 0 and #marcados <= 1 then
	if slideAlpha == 60 then
		slideAlphaPlus = -1 
	elseif slideAlpha == 0 then
		slideAlphaPlus = 1
	end
	slideAlpha = slideAlpha + slideAlphaPlus
	blancoAlpha = color.new(255,255,255,slideAlpha)
	if curDicT[indice].directory then
        if portapapeles ~= "" and portapapeles ~= nil then
			numOpci = 8
        else
			numOpci = 7
        end
        if busqueda then
            screen.print(350,85,"Ir a carpeta")   
        else 
            screen.print(350,85,"Buscar")
        end
        screen.print(350,105,renom)--2 
        screen.print(350,125,copi)
		screen.print(350,145,cort)
        screen.print(350,165,elim)
        screen.print(350,185,informa)
        screen.print(350,205,NC)--7
        if portapapeles ~= "" and portapapeles ~= nil then
			screen.print(350,225,peg)--8
        end
         if VM == 1 then
            image.blit(340,75,slide_select)
            draw.gradrect(340,75,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
           if busqueda then
              ir() 
           else 
              buscar()
           end
         elseif VM == 2 then
            image.blit(340,95,slide_select)
            draw.gradrect(340,95,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            renameFile()
          elseif VM == 3 then
            image.blit(340,115,slide_select)
            draw.gradrect(340,115,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            copyFile()
          elseif VM == 4 then
            image.blit(340,135,slide_select)
            draw.gradrect(340,135,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            cutFile()
         elseif VM == 5 then
            image.blit(340,155,slide_select)
            draw.gradrect(340,155,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            removeFile()
         elseif VM == 6 then
            image.blit(340,175,slide_select)
            draw.gradrect(340,175,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            if controls.press("cross") then
				numFiles = 0
				numCarpetas = 0
				sizeDic = 0
				indiceCur = 1
				in_slideTrans = false
				bool_fondoTrans = true
				cargaTemp = true
				pesoDir(curDicT[indice].name)
            end
         elseif VM == 7 then
            image.blit(340,195,slide_select)
            draw.gradrect(340,195,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            newDir()
         elseif VM == 8 then
            image.blit(340,215,slide_select)
            draw.gradrect(340,215,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            pasteFile()
         end
   elseif files.ext(curDicT[indice].name) == "mp3" or files.ext(curDicT[indice].name) == "jpg" or files.ext(curDicT[indice].name) == "png" or files.ext(curDicT[indice].name) == "gif" or files.ext(curDicT[indice].name) == "pbp" or files.ext(curDicT[indice].name) == "cso" or files.ext(curDicT[indice].name) == "iso" or files.ext(curDicT[indice].name) == "zip" or files.ext(curDicT[indice].name) == "rar" or files.ext(curDicT[indice].name) == "lua" or files.ext(curDicT[indice].name) == "lue" or files.ext(curDicT[indice].name) == "prx" or files.ext(curDicT[indice].name) == "obj" then
        if portapapeles ~= "" and portapapeles ~= nil then
         numOpci = 9
        else
         numOpci = 8
        end
        if busqueda and not boolPLayList  then
            screen.print(350,65,"Ir a carpeta")   
        elseif not busqueda and not boolPLayList then
            screen.print(350,65,"Buscar")
		elseif busqueda and boolPLayList then
			screen.print(350,65,"PlayList")
        end
        if files.ext(curDicT[indice].name) == "jpg" or files.ext(curDicT[indice].name) == "png" then
			if opMenuSlide == 1 then
				screen.print(350,85,"< "..ver.." >")--1
			elseif opMenuSlide == 2 then
				screen.print(350,85,"< Fondo >")--1
			elseif opMenuSlide == 3 then
				screen.print(350,85,"< Potof >")--1
			end
		elseif files.ext(curDicT[indice].name) == "gif" then
			screen.print(350,85,ver)--1
		elseif files.ext(curDicT[indice].name) == "mp3" then
			screen.print(350,85,repro)--1
		elseif files.ext(curDicT[indice].name) == "zip" or files.ext(curDicT[indice].name) == "rar" then
			screen.print(350,85,extra)--1
		elseif files.ext(curDicT[indice].name) == "pbp" or files.ext(curDicT[indice].name) == "cso" or files.ext(curDicT[indice].name) == "iso" then
			screen.print(350,85,StarIni)--1
		elseif files.ext(curDicT[indice].name) == "lua" then 
			if opMenuSlide == 1 then
				screen.print(350,85,"< Ver >")--1
			elseif opMenuSlide == 2 then
				screen.print(350,85,"< Lanzar >",0.8,color.new(100,100,100),negro)--1
			elseif opMenuSlide == 3 then
				screen.print(350,85,"< Encriptar >")--1
			end
        elseif files.ext(curDicT[indice].name) == "lue" then screen.print(350,85,"Desencriptar")
        elseif files.ext(curDicT[indice].name) == "prx" then screen.print(350,85,"Instalar")
        elseif files.ext(curDicT[indice].name) == "obj" then screen.print(350,85,"Ver")
		end

        
        screen.print(350,105,renom)--2
       
		screen.print(350,125,copi)
		screen.print(350,145,cort)
        screen.print(350,165,elim)
		screen.print(350,185,informa)
        screen.print(350,205,NC)--7
		
        if portapapeles ~= "" and portapapeles ~= nil then	
			screen.print(350,225,peg)--8
        end
		if VM == 1 then
         image.blit(340,55,slide_select)
         draw.gradrect(340,55,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
           if busqueda then
              ir() 
           else 
              buscar()
           end
        elseif VM == 2 then
            image.blit(340,75,slide_select)
            draw.gradrect(340,75,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)

				if files.ext(curDicT[indice].name) == "mp3" then
					if controls.press("cross") then
						contarMP3()
						openMP3()
					end
				elseif files.ext(curDicT[indice].name) == "pbp" then
					if controls.press("cross") and os.message(ejecutarEboot,1) == 1 then
						os.runeboot(curDicT[indice].name)
					end
				elseif files.ext(curDicT[indice].name) == "rar" then
					if controls.press("cross") then
						extraeRAR()
					end
				elseif files.ext(curDicT[indice].name) == "zip" then
					if controls.press("cross") then
						extraerZIP()
					end
				elseif files.ext(curDicT[indice].name) == "jpg" or files.ext(curDicT[indice].name) == "png" then
					if controls.press("right") or controls.press("left") then
						opMenuSlide = navegador(false,false,true,true,opMenuSlide,3,1)
					end
					if controls.press("cross") then
						if opMenuSlide == 1 then
							openIMG()
						elseif opMenuSlide == 2 then
							fondoPer()
						elseif opMenuSlide == 3 then
							potof()
						end
					end
				elseif files.ext(curDicT[indice].name) == "gif" then
					if controls.press("cross") then
						loadGIF()
					end
				elseif files.ext(curDicT[indice].name) == "lua" then
					if controls.press("right") or controls.press("left") then
						opMenuSlide = navegador(false,false,true,true,opMenuSlide,3,1)
					end
					if controls.press("cross") then
						if opMenuSlide == 1 then
							if  rep_now == false then
								loading("Cargando...")
								inferior = 1
								tope = 16
								in_slideTrans = false
								bool_fondoTrans = false 
								in_explorer = false 
								readText = true
								cargaTemp    = true
								aparecer()
							end
						elseif opMenuSlide == 2 then
							--[[lanzarLua = loadfile(curDicT[indice].name)
							lanzarLua()--]]
						elseif opMenuSlide == 3 then
							encriptar()
						end
					end
				elseif files.ext(curDicT[indice].name) == "obj" then
					if controls.press("cross") then
						objeto = model.load(curDicT[indice].name,0.008,black)
						objvis()
					end
				elseif files.ext(curDicT[indice].name) == "lue" then
					if controls.press("cross") then
						desencriptar()
					end
				elseif files.ext(curDicT[indice].name) == "cso" or files.ext(curDicT[indice].name) == "iso" then
					if controls.press("cross") and os.message(ejecutarISO..files.ext(curDicT[indice].name).."?",1) == 1 then
						os.runiso(curDicT[indice].name)
					end
				elseif files.ext(curDicT[indice].name) == "prx" then
					if controls.press("cross") then
						valorPlug = 1
						inferior = 1
						top = 16
						posicion = 1
						inf = 1
						instalPlug = curDicT[indice].name
						elegir()
						plug()
					end
               end
          elseif VM == 3 then
            image.blit(340,95,slide_select)
            draw.gradrect(340,95,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            renameFile()
          elseif VM == 4 then
            image.blit(340,115,slide_select)
            draw.gradrect(340,115,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            copyFile()
         elseif VM == 5 then
            image.blit(340,135,slide_select)
            draw.gradrect(340,135,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            cutFile()
         elseif VM == 6 then
            image.blit(340,155,slide_select)
            draw.gradrect(340,155,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            removeFile()
         elseif VM == 7 then
            image.blit(340,175,slide_select)
            draw.gradrect(340,175,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            if controls.press("cross") then
               in_slideTrans = false
               bool_fondoTrans = true
               cargaTemp = true
            end
         elseif VM == 8 then
            image.blit(340,195,slide_select)
            draw.gradrect(340,195,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            newDir()
         elseif VM == 9 then
            image.blit(340,215,slide_select)
            draw.gradrect(340,215,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
         end
	else
        if portapapeles ~= "" and portapapeles ~= nil then
         numOpci = 8
        else
         numOpci = 7
        end
        if busqueda then
            screen.print(350,85,"Ir a carpeta")   
        else 
            screen.print(350,85,"Buscar")
        end
        screen.print(350,105,renom)--1
        screen.print(350,125,copi)
		screen.print(350,145,cort) 
		screen.print(350,165,elim)
		screen.print(350,185,informa)
        screen.print(350,205,NC)--6
        if portapapeles ~= "" and portapapeles ~= nil then
         screen.print(350,225,peg)--7
        end
          if VM == 1 then
             image.blit(340,75,slide_select)
             draw.gradrect(340,75,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
           if busqueda then
              ir() 
           else 
              buscar()
           end
           elseif VM == 2 then
             image.blit(340,95,slide_select)
             draw.gradrect(340,95,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
             renameFile()
          elseif VM == 3 then
            image.blit(340,115,slide_select)
            draw.gradrect(340,115,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            copyFile()
          elseif VM == 4 then
            image.blit(340,135,slide_select)
            draw.gradrect(340,135,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            cutFile()
         elseif VM == 5 then
            image.blit(340,155,slide_select)
            draw.gradrect(340,155,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            removeFile()
         elseif VM == 6 then
            image.blit(340,175,slide_select)
            draw.gradrect(340,175,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
          if controls.press("cross") then
            in_slideTrans = false
            bool_fondoTrans = true
            cargaTemp = true
          end
         elseif VM == 7 then
            image.blit(340,195,slide_select)
            draw.gradrect(3340,195,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            newDir()
         elseif VM == 8 then
            image.blit(340,215,slide_select)
            draw.gradrect(340,215,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
            pasteFile()
        end
	end
   collectgarbage(restart)
end
if in_slideTrans == true and #curDicT < 1 then
   if portapapeles ~= "" and portapapeles ~= nil then
      numOpci = 2
   else
      numOpci = 1
   end
   screen.print(350,145,NC)
	if portapapeles ~= "" and portapapeles ~= nil then
		if #marcados <= 1 then screen.print(350,165,peg) else screen.print(350,165,"Pegar Todos") end 
	end
   if VM == 1 then
      image.blit(340,135,slide_select)
      draw.gradrect(340,135,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
      newDir()
   elseif VM == 2 then
      image.blit(340,155,slide_select)
      draw.gradrect(340,155,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
      pasteFileN()
   end
end
if in_slideTrans == true and #curDicT > 0 and #marcados > 1 then
	if portapapeles ~= "" and portapapeles ~= nil then
		numOpci = 6
	else
		numOpci = 4
	end
	if busqueda and boolPLayList then
		screen.print(350,105,"PlayList")
    end
	screen.print(350,125,"Copiar Todos")
	screen.print(350,145,"Cortar Todos")
	screen.print(350,165,"Eliminar Todos")

	if portapapeles ~= "" and portapapeles ~= nil then
		screen.print(350,185,"Limpiar")
		screen.print(350,205,"Pegar Todos")
	end
	if VM == 1 then
		image.blit(340,95,slide_select)
		draw.gradrect(340,95,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
		if controls.press("cross") then	os.message(";D") end	
	elseif VM == 2 then
		image.blit(340,115,slide_select)
		draw.gradrect(340,115,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
		copyFile()
	elseif VM == 3 then
		image.blit(340,135,slide_select)
		draw.gradrect(340,135,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
		cutFile()
	elseif VM == 4 then
		image.blit(340,155,slide_select)
		draw.gradrect(340,155,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
		removeFile()
	elseif VM == 5 then
		image.blit(340,175,slide_select)
		draw.gradrect(340,175,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
		if controls.press("cross") then
			portapapeles = ""
			ordenar()
			marcados = {""}
			num_marck = 1
		end
	elseif VM == 6 then
		image.blit(340,195,slide_select)
		draw.gradrect(340,195,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
		pasteFile()
	end
end
