	function newDir()
		if controls.press("cross") then
			teclados()
			if newName ~= nil and newName ~= "" then
				loading("Creando Carpeta...")
				if #curDicT > 0 then
				   files.mkdir(files.nofile(curDicT[indice].name)..newName)
				else
				   files.mkdir(curAux.."/"..newName)
				end
				os.message(okRenomb)
				ordenar()      
			elseif newName == nil or newName == "" then
				os.message(errorRenomb)
				ordenar()
			end
			newName = ""
		end
	end
   function renameFile()
		if controls.press("cross") then
			teclados(files.nopath(curDicT[indice].name))
			if newName ~= nil and newName ~= "" then
				loading("Renombrando...")
				files.rename(curDicT[indice].name,newName)
				os.message(okRenombF)
				ordenar()
			elseif newName == nil or newName == "" then
				os.message(errorRenombF)
				ordenar()
			end
			newName = ""
		end
   end
   function removeFile()
      if controls.press("cross") then
		lista = "\n"
		MensajeCopiar = "¿Quieres eliminar estos archivos?"	
        if #marcados == 1 then 
			marcados[1] = curDicT[indice].name
			MensajeCopiar = "¿Quieres eliminar este archivo?"			
		end
		tmpB = screen.toimage()
		for i=1,#marcados do
			lista = lista.."\n* "..files.nopath(marcados[i])
		end
        if os.message(MensajeCopiar..lista,1) == 1 then
            for m = 1,#marcados do
				files.remove(marcados[m],true)
				barraCargado("Eliminando...",m)
            end
            os.message(okEliminar)
			indice      = 1
			indice2    = 11
			limInf     = 1   
			ordenar()
            marcados = {""}
            num_marck = 1
        end
		tmpB:free()
      end
   end
	function copyFile()
		if controls.press("cross") then
			lista = "\n"
			MensajeCopiar = "La ruta de estos archivos se copiaran al portapapeles"
			if #marcados == 1 then 
				marcados[1] = curDicT[indice].name 
				MensajeCopiar = "La ruta de este archivo se copiara al portapapeles"
			end
			for i=1,#marcados do
				lista = lista.."\n* "..files.nopath(marcados[i])
			end
			loading("Portapapeles...")
			portapapeles = marcados
			CC = 0
			os.message(MensajeCopiar..lista)
			in_slideTrans = false
			in_explorer = true   
      end
   end
   function pasteFile()
      if controls.press("cross") then
		tmpB = screen.toimage()
         if controls.press("cross") and CC == 0 then
			barraCargado("Copiando...",0)
            for m = 1,#marcados do
               if files.exists(files.nofile(curDicT[indice].name)..files.nopath(marcados[m])) == true then
                  if os.message("El archivo \""..files.nopath(marcados[m]).."\" ya existe \n¿Estas seguro de que quieres sobreescribir este archivo?",1) == 1 then
					 files.copy(marcados[m],files.nofile(curDicT[indice].name)..files.nopath(marcados[m]),true,true)  
                     portapapeles = ""
                  end
               else
                  files.copy(marcados[m],files.nofile(curDicT[indice].name)..files.nopath(marcados[m]),true,true)
                  portapapeles = ""
               end
			   barraCargado("Copiando...",m)
            end--aqui termina el for :D
         os.message(okCopi)
		 ordenar()
         marcados = {""}
         num_marck = 1
         end
    if controls.press("cross") and CC == 1 then
		barraCargado("Cortando...",0)
        for m = 1,#marcados do
            if files.exists(files.nofile(curDicT[indice].name)..files.nopath(marcados[m])) == true then
                if os.message("El archivo \""..files.nopath(marcados[m]).."\" ya existe \n¿Estas seguro de que quieres sobreescribir este archivo?",1) == 1 then
                    files.copy(marcados[m],files.nofile(curDicT[indice].name)..files.nopath(marcados[m]),true,true)
                    files.remove(marcados[m])  
                    portapapeles = ""
                end
            else
                files.copy(marcados[m],files.nofile(curDicT[indice].name)..files.nopath(marcados[m]),true,true)
                files.remove(marcados[m])
                portapapeles = ""
				ordenar()
            end
			barraCargado("Cortando...",m)
            end--aqui termina el for : D
        os.message(okCort)
		ordenar()
        marcados = {""}
        num_marck = 1
		end
		tmpB:free()
		end
   
   end
   function pasteFileN()
      if controls.press("cross") then
		tmpB = screen.toimage()
        if controls.press("cross") and CC == 0 then
			barraCargado("Copiando...",0)
			for m = 1,#marcados do
				if files.exists(curAux.."/"..files.nopath(marcados[m])) == true then
				   if os.message("El archivo \""..files.nopath(marcados[m]).."\" ya existe \n¿Estas seguro de que quieres sobreescribir este archivo?",1) == 1 then
					  files.copy(marcados[m],curAux.."/"..files.nopath(marcados[m]),true,true)
					  portapapeles = ""
				   end
				else
				   files.copy(marcados[m],curAux.."/"..files.nopath(marcados[m]),true,true)
				   portapapeles = ""
				end
			barraCargado("Copiando...",m)
			end-- aqui termina el for :D
         os.message(okCopi)
		 ordenar()
         marcados = {""}
         num_marck = 1
		end
        if controls.press("cross") and CC == 1 then
			barraCargado("Cortando...",0)
            for m = 1,#marcados do
				if files.exists(curAux.."/"..files.nopath(marcados[m])) == true then
					  if os.message("El archivo \""..files.nopath(marcados[m]).."\" ya existe \n¿Estas seguro de que quieres sobreescribir este archivo?",1) == 1 then
						 files.copy(marcados[m],curAux.."/"..files.nopath(marcados[m]),true,true)
						 files.remove(marcados[m])  
						 portapapeles = ""
					  end
				   else
					  files.copy(marcados[m],curAux.."/"..files.nopath(marcados[m]),true,true)
					  files.remove(marcados[m])
					  portapapeles = ""
				end
			barraCargado("Cortando...",m)
			end--aqui termina el for : D
         os.message(okCort)
		 ordenar()
         marcados = {""}
         num_marck = 1
		end
      end
   end
   function cutFile()
		if controls.press("cross") then
			lista = "\n"
			MensajeCopiar = "La ruta de estos archivos se copiaran al portapapeles"
			if #marcados == 1 then 
				marcados[1] = curDicT[indice].name 
				MensajeCopiar = "La ruta de este archivo se copiara al portapapeles"
			end
			for i=1,#marcados do
				lista = lista.."\n* "..files.nopath(marcados[i])
			end
			loading("Portapapeles...")
			portapapeles = curDicT[indice].name
			CC = 1
			os.message(MensajeCopiar..lista)
			in_slideTrans = false
			in_explorer = true   
		end   
	end
