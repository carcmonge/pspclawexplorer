--[[
 * PSP Claw Explorer
 * Copyright 2016 Carlos Monge.
 * Licensed under MIT (https://github.com/carcmonge/pspclawexplorer/blob/master/LICENSE)
]]--
dofile("./system/kernel/funcionesprincipales.lua")
dofile("./system/kernel/gestorDeArchivos.lua")

marcados = {""}
image.free(coder)
indices_Lim = {}
indices_Lim[historial] = {indi = 1, indi2 = 11 ,lim = 1}
num_marck = 1
os.cpu(333)
crearParticulas(numParticula,sizeParticula)
PP:start()
		lavenderAlpha = color.new(125,125,125,slideAlpha2)
		if slideAlpha2 == 150 then 
			slideAlphaPlus2 = -1 
		elseif slideAlpha2 == 100 then
			slideAlphaPlus2 = 1
		end
	   slideAlpha2 = slideAlpha2 + slideAlphaPlus2
	   blancoAlpha = color.new(255,255,255,slideAlpha)
				shell = true
				ladoSlideShell = -15
				slideShellBool = true
				slideShell = 500
				image.resize(selek,88,88)

while true do
   collectgarbage(restart)
	controls.read()
	protectorPantalla()
	--cambiarBrillo()
	if controls.press("hold") then
		screen.brightness(30)
		os.cpu(222)
	end
	if controls.release("hold") then
		screen.brightness(90)
		os.cpu(333)
	end
	if rep_now == false then
		--draw.gradrect (0,0,480,272,negro,negro,rojo,rojo)
		if #curDicT > 0 then mostrarEboot(0) end
		fondos()
		onParti()
		if olas == true then
		  if tipOla == 1 then   
			 pintarola(2)
		  else
			 pintarola2(2)
		  end
		end
	   
	   bateria()
	   usbCon()
	   snap()
	   
	   if cambioDir == true and pspGO == true then
		  cambioMemo()
		  cambioDir = false
	   end
	   olasOn()   
	   --contarMP3()

	   Thora = os.date("%I:%M %p")
	   screen.print(320,10,Thora,0.6,blanco,negro)

		if shell == false then
		if #curDicT == 0 then
			curdir_x = screen.print(curdir_x,10,curAux,0.7,blanco,negro,"scroll_left",300)
		else
			curdir_x = screen.print(curdir_x,10,files.nofile(curDicT[indice].name),0.7,blanco,negro,"scroll_left",300)
		end
		if controls.press("cross") then
			infoDicT = {}
			if in_explorer == true and #curDicT > 0 then
				if portapapeles == "" then 
					marcados = {""}
					num_marck = 1
				end
				if curDicT[indice].directory and #files.list(curDicT[indice].name) > 0 then
					indices_Lim[historial] = {indi = indice, indi2 = indice2 ,lim = limInf }
					historial = historial + 1
					curAux = curDicT[indice].name
					curDicT = files.list(curDicT[indice].name)
					table.sort(curDicT, sp)
					indice      = 1
					indice2    = 11
					limInf     = 1          
				elseif curDicT[indice].directory and #files.list(curDicT[indice].name) == 0 then
					if portapapeles == "" then 
						marcados = {""}
						num_marck = 1
					end
					indices_Lim[historial] = {indi = indice, indi2 = indice2 ,lim = limInf }
					historial = historial + 1
					curAux = curDicT[indice].name
					curDicT = files.list(curDicT[indice].name)
					indice      = 1
					indice2    = 11
					limInf     = 1 
				elseif files.ext(curDicT[indice].name) == "mp3" or files.ext(curDicT[indice].name) == "at3" or files.ext(curDicT[indice].name) == "bgm" or files.ext(curDicT[indice].name) == "wav" then
					reproductorIconos("cargar");
					contarMP3();
					done	= pcall(openMP3);
					if done then
					end
				elseif files.ext(curDicT[indice].name) == "mp4" then
					videoyo = video.load(curDicT[indice].name)
					video.play(videyo)
				elseif files.ext(curDicT[indice].name) == "txt" or files.ext(curDicT[indice].name) == "ini" or files.ext(curDicT[indice].name) == "log" or files.ext(curDicT[indice].name) == "lua" then
					if  rep_now == false then
						loading("Cargando...")
						in_slideTrans = false
						bool_fondoTrans = false 
						in_explorer = false 
						aparecer()
						readTXT()
					end
				elseif files.ext(curDicT[indice].name) == "pbp" then
					if os.message(ejecutarEboot,1) == 1 then
						desvanecer()
						os.runeboot(curDicT[indice].name)
					end
				elseif files.ext(curDicT[indice].name) == "iso" or files.ext(curDicT[indice].name) == "cso" then  
					if os.message(ejecutarISO..files.ext(curDicT[indice].name).."?",1) == 1 then
						desvanecer()
						os.runiso(curDicT[indice].name)
					end
				elseif files.ext(curDicT[indice].name) == "docx"  then  
					extraeRAR()
				elseif files.ext(curDicT[indice].name) == "ziap" then    
					extraerZIP()
				elseif files.ext(curDicT[indice].name) == "jpg" or files.ext(curDicT[indice].name) == "png" then
					VisorDeImagenesIconos("cargar");
					openIMG()
					aparecer()
				elseif files.ext(curDicT[indice].name) == "gif" then
					VisorDeImagenesIconos("cargar");
					loadGIF()
					aparecer()
				elseif files.ext(curDicT[indice].name) == "lue" then
					desencriptar()
				elseif files.ext(curDicT[indice].name) == "obj" then
					objeto = model.load(curDicT[indice].name,0.008,black)
					objvis()
				elseif files.ext(curDicT[indice].name) == "prx" then
					if  rep_now == false then
						valorPlug = 1
						inferior = 1
						tope = 16
						posicion = 1
						inf = 1
						instalPlug = curDicT[indice].name
						elegir()
					end
				end
			end
			if rep_nowNum == 0 and in_explorer == true then
				if #curDicT > 0 then contarMP3() end
			end
			collectgarbage(restart)
		end
		--pepe
		if indice == indice2 and dismi == false then
			limInf = limInf + 1
			indice2 = indice2 + 1
		elseif indice > #curDicT and dismi == false then
			limInf = 1         
			indice2 = 11
		elseif indice == limInf and dismi == true and indice ~= 1 and indice ~= 0  then
			limInf = limInf - 1
			indice2 = indice2 - 1
		end
	   --  Imprimir
		valorTabla = #curDicT
		if #curDicT < 11 then
			valorTabla = #curDicT
		elseif #curDicT >= 11 and #curDicT ~= indice2 and indice2 < #curDicT then
			valorTabla = indice2
		elseif #curDicT == indice2 and indice == 0 then
			valorTabla = indice2-1 
		end
		if #curDicT < 1 then
			screen.print(20,45,carpVacia,0.6,Color,0x0)
		end
		if #infoDicT > 0 then 
			pintarExploradorNames(465,155,25)
		else
			pintarExploradorNames(465,20,395)
		end
	end
	   --screen.print(0,25,"Indice: "..indice.." indice2: "..indice2.." limiteInf: "..limInf.." tabla "..#curDicT.." "..Xmenu.." "..y.info.." "..files.sizeformat(os.getfreememory ()))
	   --screen.print(0,5,"Inicio: "..limInf.." Final: "..valorTabla.."Tamaño: "..valorTabla-limInf.."    "..files.nofile(curDicT[indice].name)) 
	   --screen.print(0,5,"Portapapeles: "..portapapeles.." Destino: "..files.nofile(curDicT[indice].name)..files.nopath(portapapeles),0.6,Color,0x0)
		--screen.print(0,5,files.sizeformat(os.getfreememory()).." "..contadorMp3,0.6,blanco,0x0)
	   --ubicacion = curDicT[j].name,numero
	end

	back()
	if shell and configuration == false and in_slideTrans == false then
		moverShell()
		--vib[tostring(xs..","..ys)] = math.random (-2,2)
		if slideAlpha4 == 225 then
			slideAlphaPlus4 = -5 
		elseif slideAlpha4 == 100 then
			slideAlphaPlus4 = 5
		end
		if slideShellBool then
			slideShell = slideShell + ladoSlideShell 
		end
		if slideShellBool and slideShell <= 0 then
			slideShellBool = false
		end
		slideAlpha4 = slideAlpha4 + slideAlphaPlus4
		
		image.blend(selek,seleck[ys..xs].x+slideShell,seleck[ys..xs].y,slideAlpha4)
		screen.print(5,10,shelli[xs..ys].name)
		image.blit(posIcons[1].x+slideShell,posIcons[1].y,shelli["11"].ico)
		image.blit(posIcons[2].x+slideShell,posIcons[2].y,shelli["21"].ico)
		image.blit(posIcons[3].x+slideShell,posIcons[3].y,shelli["31"].ico)
		image.blit(posIcons[4].x+slideShell,posIcons[4].y,shelli["41"].ico)
		image.blit(posIcons[5].x+slideShell,posIcons[5].y,shelli["51"].ico)
		image.blit(posIcons[6].x+slideShell,posIcons[6].y,shelli["12"].ico)
		image.blit(posIcons[7].x+slideShell,posIcons[7].y,shelli["22"].ico)
		image.blit(posIcons[8].x+slideShell,posIcons[8].y,shelli["32"].ico)
		image.blit(posIcons[9].x+slideShell,posIcons[9].y,shelli["42"].ico)
		image.blit(posIcons[10].x+slideShell,posIcons[10].y,shelli["52"].ico)
		image.blit(posIcons[11].x+slideShell,posIcons[11].y,shelli["13"].ico)
		image.blit(posIcons[12].x+slideShell,posIcons[12].y,shelli["23"].ico)
		image.blit(posIcons[13].x+slideShell,posIcons[13].y,shelli["33"].ico)
		image.blit(posIcons[14].x+slideShell,posIcons[14].y,shelli["43"].ico)
		image.blit(posIcons[15].x+slideShell,posIcons[15].y,shelli["53"].ico)
        --draw.rect(80+(xs*40),40+(ys*40),32,32,negro)
		if slideShellBool and slideShell >=500 then
			curDicT = files.list(memoSelect)
			curAux = ""
			table.sort(curDicT, sp)
			shell = false
			slideShellBool = false
			slideShell = 0
			LiveArenaIconos("liberar");
		end
		--"Explorador de Archivos"
		if ys == 1 and xs == 1 and controls.press("cross") then
			iconos("cargar");
			slideShellBool = true
			ladoSlideShell = 15
		end
		--"Buscar"
		if ys == 1 and xs == 2 and controls.press("cross") then
			buscador()
		end
		--"Traductor"
		if ys == 1 and xs == 3 and controls.press("cross") then
			traductor()
		end
		--"Descargar Musica"
		if ys == 1 and xs == 4 and controls.press("cross") then
			buscarMP3()
		end
		--"Paleta de Colores"
		if ys == 1 and xs == 5 and controls.press("cross") then
			paletaton = true
		end
		--"Informacion"
		if ys == 2 and xs == 1 and controls.press("cross") then
			infoPSP()
		end
		--"Wikipedia"
		if ys == 2 and xs == 2 and controls.press("cross") then
			os.message("Esta utilidad no esta disponible para esta version")
		end
		--"Configuracion"
		if ys == 2 and xs == 3 and controls.press("cross") then
			if configuration == true then
				configuration = false
				in_explorer = true
			else
				in_slideTrans = false
				bool_fondoTrans = false 
				in_explorer = false
				rep_now    = false
				configuration = true
				VM = 1
				if pspGO then
					numOpci = 17
				else
					numOpci = 18
				end
			end
		end
		--"Juegos"
		if ys == 2 and xs == 4 and controls.press("cross") then
			rooms()
		end
		--"Descargar Imagenes"
		if ys == 2 and xs == 5 and controls.press("cross") then
			Buscaimg()
		end
		--"Plugins"
		if ys == 3 and xs == 1 and controls.press("cross") then
			loading("Cargando...")
			namePlug = "vsh.txt"
			valorPlug = 1
			inferior = 1
			tope = 16
			posicion = 1
			inf = 1
			plug()
		end
		--"PSP Claw Cleaner"
		if ys == 3 and xs == 2 and controls.press("cross") then
			os.message("Esta utilidad no esta disponible para esta version")
			--CCleaner()
		end
		--"Paint"
		if ys == 3 and xs == 3 and controls.press("cross") then
			os.message("Esta utilidad no esta disponible para esta version")
		end
		--"Reproductor"
		if ys == 3 and xs == 4 and controls.press("cross") then
			dofile("cotch.lua")
		end
		--"Camara"
		if ys == 3 and xs == 5 and controls.press("cross") then
			--os.message("Esta utilidad no esta disponible para esta version")
			elegirLIST()
		end
	end
	if in_slideTrans == true then
		draw.gradrect(Xmenu,0,140,272,colorAlpha[valorFondo],colorAlpha[valorFondo],lavenderAlpha,lavenderAlpha)
		draw.rect(Xmenu,0,140,272,negro)		
		if Xmenu > 340 then 
			Xmenu = Xmenu - 10 
		end
		if Xmenu <= 340 then
			menuSlide()
		end
	else 
		draw.gradrect(Xmenu,0,140,272,colorAlpha[valorFondo],colorAlpha[valorFondo],lavenderAlpha,lavenderAlpha)
		draw.rect(Xmenu,0,140,272,negro)
		if Xmenu < 480 then Xmenu = Xmenu + 10    end
	end
   slideY2(bool_fondoTrans,colorAlpha[valorFondo],colorAlpha[valorFondo])
	if bool_fondoTrans == true then
		if y.info <= 0 then
			if curDicT[indice].directory then
				if controls.press("r") then
					infoGraf(curDicT[indice].name)
					bool_fondoTrans = false
					in_explorer = true
				end
				screen.print(240,40,"Informacion",0.8,blanco,colorTXT[valorFonte],"center",480)
				screen.print(100,100,"Tamaño: ",0.8,blanco,colorTXT[valorFonte])
				screen.print(100+(screen.textwidth("Tamaño: ")),100,files.sizeformat(sizeDic),0.8,blanco,negro)
				screen.print(100,120,"Ruta del archivo: ",0.8,blanco,colorTXT[valorFonte])
				screen.print(100+(screen.textwidth("Ruta del archivo: ")),120,files.nofile(curDicT[indice].name),0.8,blanco,negro)
				screen.print(100,140,"Numero de archivos: ",0.8,blanco,colorTXT[valorFonte])
				screen.print(100+(screen.textwidth("Numero de archivos: ")),140,numFiles,0.8,blanco,negro)
				screen.print(100,160,"Numero de carpetas: ",0.8,blanco,colorTXT[valorFonte])
				screen.print(100+(screen.textwidth("Numero de carpetas: ")),160,numCarpetas,0.8,blanco,negro)
				screen.print(240,260,"Presiona el boton R para obtener un grafico de esta carpeta",0.6,blanco,negro,"center",480)
			elseif files.ext(curDicT[indice].name) == "mp3" then
				if cargaTemp == true then
					id3Temp = sound.id3(curDicT[indice].name)
				end
				screen.print (75,100,titulo,0.8,blanco,0x0) screen.print (155,100,id3Temp.title,0.8,blanco,0x0)
				screen.print (75,120,artista,0.8,blanco,0x0) screen.print (155,120,id3Temp.artist,0.8,blanco,0x0)
				screen.print (75,140,album,0.8,blanco,0x0) screen.print (155,140,id3Temp.album,0.8,blanco,0x0)
				screen.print (75,160,genero,0.8,blanco,0x0) screen.print (155,160,id3Temp.genre,0.8,blanco,0x0)
				screen.print (75,180,tamaño,0.8,blanco,0x0) screen.print (155,180,files.sizeformat(curDicT[indice].size),0.8,blanco,0x0)
				cargaTemp = false
			elseif files.ext(curDicT[indice].name) == "jpeg" or files.ext(curDicT[indice].name) == "png" or files.ext(curDicT[indice].name) == "gif" then
				if cargaTemp == true then
					imgTemporal = image.load(curDicT[indice].name)
				end
				screen.print (100,100,imagen..files.nopath(curDicT[indice].name),0.8,blanco,0x0)
				screen.print (100,120,tamaño..files.sizeformat(curDicT[indice].size),0.8,blanco,0x0)
				screen.print (100,140,actualizado..curDicT[indice].mtime.day.."/"..curDicT[indice].mtime.month.."/"..curDicT[indice].mtime.year,0.8,blanco,0x0)
				screen.print (100,160,resolucion..image.width(imgTemporal).." x "..image.height(imgTemporal),0.8,blanco,0x0)
				screen.print (100,180,formato..files.ext((curDicT[indice].name)),0.8,blanco,0x0)
				image.factorscale(imgTemporal,10)
				image.blit(100,35,imgTemporal)
				cargaTemp = false
			elseif files.ext(curDicT[indice].name) == "pbp" then
				if #curDicT > 0 then mostrarEboot(1) end
				screen.print (150,150,"Eboot: "..files.nopath(curDicT[indice].name),0.8,blanco,0x0)
				screen.print (150,170,tamaño..files.sizeformat(curDicT[indice].size),0.8,blanco,0x0)
			else
				screen.print (100,100,archivoIni..files.nopath(curDicT[indice].name),0.8,blanco,0x0)
				screen.print (100,120,tamaño..files.sizeformat(curDicT[indice].size),0.8,blanco,0x0)
			end
		end
	end
	if valorMiniMusic == 2 then slideRep = 257 end
	if rep_nowNum == 1 and in_explorer  then
		if valorMiniMusic == 1 then
			if sonido:percent() >= 99 then
				adelMP3()
			end
			draw.gradrect(0,slideRep-10,sizeTitle,25,colorTXT[valorFondo],colorTXT[valorFondo],negro,negro)
			draw.rect(0,slideRep-10,sizeTitle,25,negro)
			if valorMini == 1 then
				fft = sound.fft(sonido)
				divi = 1
				for f = 12,15 do
					if math.ceil(fft[f]) > 20 then divi = 3 else divi = 1 end
						draw.gradrect(7*(f-12),slideRep+13,-5,(math.ceil(fft[f])*-1)/divi,colorAlpha[valorFondo],negro,colorAlpha[valorFondo],blanco)
					end
			else
				image.blit(2,slideRep-5,reproductor.notaICO)
			end
			mini_x = screen.print(mini_x,slideRep,"Titulo: "..id3MP3.title.."        Artista: "..id3MP3.artist,0.7,blanco,0x0,"scroll_left",170);
			if slideRep > 257 then
				slideRep = slideRep - 1 
			end
			if slideRep <= 0 then
			end
		end
	elseif in_explorer == false and valorMiniMusic == 1 then     
		draw.gradrect(0,slideRep-10,sizeTitle,25,colorTXT[valorFondo],colorTXT[valorFondo],negro,negro)
		draw.rect(0,slideRep-10,sizeTitle,25,negro)
		if slideRep < 282 then 
			slideRep = slideRep + 1
		end
   end
	reproductorAPP();
	slideY(configuration,colorAlpha[valorFondo],colorAlpha[valorFondo])
	if configuration == true and y.conf <= 0 then
		if pspGO then
			VM = navegador(true,true,false,false,VM,31,1)
		else
			VM = navegador(true,true,false,false,VM,30,1)
		end
	end
	visorDeImagenesAPP();
	visorDeImagenesGifAPP();
	puto_for()
	screen.print(100,100,files.sizeformat(os.getfreememory()))
	if controls.l() and controls.r() and capturas_bool then
		dofile("config.ini")
		captura = screen.toimage()
		loading("Tomando Captura...")
		image.save(captura,memoSelect.."PICTURE/captura "..os.nick().."_"..capturas..".png")
		captura:free()
		configuracion = io.open("config.ini","w")
		configuracion:write("valorFondo = "..valorFondo.."\nvalorIdioma = "..valorIdioma.." \nvalorOlas= "..valorOlas.."\ntipOla = "..tipOla.."\ncapturas = "..(capturas+1).."\ncap = "..valorCap)
		configuracion:write("\nnumParticula = "..numParticula.."\nsizeParticula = "..sizeParticula.." \nvelParticulas= "..velParticulas.."\nvalorColorPar = "..valorColorPar.."\nvalorParti = "..valorParti) 
		configuracion:write("\nvalorMini = "..valorMini.."\nvalorCola = "..valorCola.."\nvalorTeclado = "..valorTeclado.."\nvalorPP = "..valorPP.."\nminutosPP = "..minutosPP.."\nvalorWall = "..valorWall)
		configuracion:write("\nopacidad = "..opacidad.."\nvalorWallTint = "..valorWallTint.."\nrutaFondo = \""..rutaFondo.."\"")
		configuracion:write("\nvalorMiniMusic = "..valorMiniMusic.."\nvalorWallTint = "..valorWallTint.."\nrutaFondo = \""..rutaFondo.."\"") 
		configuracion:write("\nbrillo = "..brillo.."\nvalorFonte = "..valorFonte.."\nvalorColorFile = "..valorColorFile.."\nvalorTintFile = "..valorTintFile.."\ncolorScrollBar = "..colorScrollBar.."\nvalorColorFondo = "..valorColorFondo)
		configuracion:write("\ncanalR = "..canalR.."\ncanalG = "..canalG.."\ncanalB = "..canalB.."\nconexion = "..conexion)
		io.close(configuracion)
		os.message("Tu captura: \"captura "..os.nick().."_"..capturas..".png\" \n fue guardada en el directorio:\n \" "..memoSelect.."PICTURE/ \" ")
	end
--   for i = 1,#marcados do
--      screen.print(10,i*15,marcados[i])
--   end
	screen.print(400,25,"fps: "..screen.fps())
	--screen.print(100,25,math.floor(PP:time()/1000).." "..math.floor(PP_rep:time()/1000))
	paleton()
	screen.flip()
	if in_slideTrans == true then
		VM = navegador(true,true,false,false,VM,numOpci,1,1)
	end
	if controls.r() and controls.l() then 
		error_wlan() 
	end
   if controls.press("up") and shell == false then 
      arriba()
   end
   if controls.press("down") and shell == false then 
      abajo()
   end
   if controls.press("square") then
      if in_ecual == false and menuRep == false then
         in_ecual = true
      else
         in_ecual = false
      end
   end
    if controls.press("triangle") and shell == false then
		if in_slideTrans == false and bool_fondoTrans == false and rep_now == false and readText == false and configuration == false and imagenV == false and  imagenGif == false then
			VM = 1
			in_slideTrans = true
			in_explorer = false
			opMenuSlide = 1
		elseif in_slideTrans == true and bool_fondoTrans == false and rep_now == false and readText == false and configuration == false and imagenV == false and imagenGif == false then
			VM = 1
			in_slideTrans = false
			in_explorer = true
			opMenuSlide = 1
		end
    end
   if controls.press("start") and readText == false and rep_now == false and in_slideTrans == false and bool_fondoTrans == false  then
		if configuration == true then
			configuration = false
			in_explorer = true
		else
			in_slideTrans = false
			bool_fondoTrans = false 
			in_explorer = false
			rep_now    = false
			configuration = true
			VM = 1
			if pspGO then
				numOpci = 17
			else
				numOpci = 18
			end
		end
   end
   if controls.press("select") then
		if rep_now == true then
			rep_now = false
			in_explorer = true
			desvanecer()
		elseif slideRep == 257 and rep_now == false then
			in_slideTrans = false
			bool_fondoTrans = false 
			in_explorer = false
			in_ecual = false
			rep_now    = true
			numOpci = 3
			rep_nowNum = 1
			--aparecer()
		end     
   end
	if controls.press("square") and in_explorer == true and #curDicT >= 1 and shell == false then
		for i = 1,#marcados do
			if marcados[i] == curDicT[indice].name then
				table.remove(marcados,i)
				num_marck = num_marck - 1
			end 
		end
		marcados[num_marck] = curDicT[indice].name
		num_marck = num_marck + 1
		abajo()
   end
   if controls.press("r") and rep_now == false and #curDicT >= 1 and shell == false then
      for i = 1,#marcados do
         if marcados[i] == curDicT[indice].name then
            table.remove(marcados,i)
            num_marck = num_marck - 1
         abajo()
         end 
      end
      if #marcados == 0 then marcados={""} end 
   end 
	if controls.press("right") and shell == false then
		for p=1,5 do
			abajo()
			if indice == indice2 and dismi == false then
				limInf = limInf + 1
			   indice2 = indice2 + 1
			elseif indice > #curDicT and dismi == false then
				limInf = 1         
				indice2 = 11
			elseif indice == limInf and dismi == true and indice ~= 1 and indice ~= 0  then
			   limInf = limInf - 1
			   indice2 = indice2 - 1
			end
		end
	end
	if controls.press("left") and shell == false then
		for p=1,5 do
			arriba()
			if indice == indice2 and dismi == false then
				limInf = limInf + 1
			   indice2 = indice2 + 1
			elseif indice > #curDicT and dismi == false then
				limInf = 1         
				indice2 = 11
			elseif indice == limInf and dismi == true and indice ~= 1 and indice ~= 0  then
			   limInf = limInf - 1
			   indice2 = indice2 - 1
			end
		end
	end
	if controls.press("l") then
		--
	end
   --if controls.press("down") then
   --   sound.play(click,2)
   --end
   --if controls.press("right") then
   --   sound.play(click,2)
   --end
   --if controls.press("left") then
   --   sound.play(click,2)
   --end
end