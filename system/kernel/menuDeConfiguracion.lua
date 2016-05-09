function slideY(bool,color1,color2)
	if bool == true  then
		if y.conf > 0 then
				draw.gradrect(0,y.conf,480,272,color1,color1,color2,color2)
				y.conf = y.conf - 17 
		end
		if y.conf <= 0 then
			draw.gradrect(0,y.conf,480,272,color1,color1,color2,color2)
			draw.gradline(0,20,480,20,blanco)
			screen.print(160,5,"Configuracion")
--**************************************Color de tema****************************************************
			if VM == 1 and y.conf == 0 then
				screen.print(10,25,colorTema..colorConf[valorFondo],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorFondo = navegador(false,false,true,true,valorFondo,15,1)
					valorColorPar = valorFondo
					valorCola = valorFondo
					valorFonte = valorFondo
					valorColorFile = valorFondo
					colorScrollBar = valorFondo
					valorColorFondo = valorFondo
					configurar()
				end
			elseif y.conf == 0 then
				screen.print(10,25,colorTema..colorConf[valorFondo],0.6,blanco,negro)
			end
--**************************************Olas****************************************************
			if VM == 2 and y.conf == 0 then
				screen.print(10,40,olasXMB..olasC[valorOlas],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorOlas = navegador(false,false,true,true,valorOlas,2,1)
					configurar()
					dofile("idiomas.ini")
					olasC = {conUSBactivado,conUSBdesactivado}
				end
			elseif y.conf == 0 then 
				screen.print(10,40,olasXMB..olasC[valorOlas],0.6,blanco,negro)
			end
--**************************************Tipo de ola****************************************************
			if VM == 3 and y.conf == 0 then
				screen.print(10,55,TolasXMB..tipOla,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					tipOla = navegador(false,false,true,true,tipOla,2,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,55,TolasXMB..tipOla,0.6,blanco,negro)
			end
--**************************************Color de ola****************************************************	
			if VM == 4 and y.conf == 0 then
				screen.print(10,70,"Color de ola: "..colorConf[valorCola],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorCola = navegador(false,false,true,true,valorCola,15,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,70,"Color de ola: "..colorConf[valorCola],0.6,blanco,negro)
			end
--**************************************Activar particulas****************************************************	
			if VM == 5 and y.conf == 0 then
				screen.print(10,85,"Activar particulas: "..partiC[valorParti],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorParti = navegador(false,false,true,true,valorParti,2,1)
					configurar()
					dofile("idiomas.ini")
					partiC = {conUSBactivado,conUSBdesactivado}
				end
			elseif y.conf == 0 then 
				screen.print(10,85,"Activar particulas: "..partiC[valorParti],0.6,blanco,negro)
			end
--**************************************Color de particulas****************************************************	
			if VM == 6 and y.conf == 0 then
				screen.print(10,100,"Color de particulas: "..colorConf[valorColorPar],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorColorPar = navegador(false,false,true,true,valorColorPar,15,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,100,"Color de particulas: "..colorConf[valorColorPar],0.6,blanco,negro)
			end
--**************************************Numero de particulas****************************************************
			if VM == 7 and y.conf == 0 then
				screen.print(10,115,"Numero de particulas: "..numParticula,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					numParticula = navegador(false,false,true,true,numParticula,50,1)
					crearParticulas(numParticula,sizeParticula)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,115,"Numero de particulas: "..numParticula,0.6,blanco,negro)
			end
--**************************************Tamaño de particulas****************************************************
			if VM == 8 and y.conf == 0 then
				screen.print(10,130,"Tamaño de particulas: "..sizeParticula,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					sizeParticula = navegador(false,false,true,true,sizeParticula,75,5)
					if sizeParticula < 15 then sizeParticula = 70 end
					if sizeParticula > 70 then sizeParticula = 15 end
					crearParticulas(numParticula,sizeParticula)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,130,"Tamaño de particulas: "..sizeParticula,0.6,blanco,negro)
			end
--**************************************Velocidad de particulas****************************************************	
			if VM == 9 and y.conf == 0 then
				screen.print(10,145,"Velocidad de particulas: "..velParticulas,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					velParticulas = navegador(false,false,true,true,velParticulas,5,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,145,"Velocidad de particulas: "..velParticulas,0.6,blanco,negro)
			end
--**************************************Etiqueta de reproduccion********************************************
			if VM == 10 and y.conf == 0 then
				screen.print(10,160,"Etiqueta de reproduccion: "..etiqueC[valorMiniMusic],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorMiniMusic = navegador(false,false,true,true,valorMiniMusic,2,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,160,"Etiqueta de reproduccion: "..etiqueC[valorMiniMusic],0.6,blanco,negro)
			end
--**************************************Tipo de etiqueta de reproduccion****************************************************		
			if VM == 11 and y.conf == 0 then
				screen.print(10,175,"Tipo de etiqueta de reproduccion: "..miniMusic[valorMini],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorMini = navegador(false,false,true,true,valorMini,2,1)
					configurar()
					dofile("idiomas.ini")
					miniMusic = {"Ecual","Nota"}
				end
			elseif y.conf == 0 then 
				screen.print(10,175,"Tipo de etiqueta de reproduccion: "..miniMusic[valorMini],0.6,blanco,negro)
			end
--**************************************Imagen de fondo********************************************
			if VM == 12 and y.conf == 0 then
				screen.print(10,190,"Imagen de fondo: "..fondoC[valorWall],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorWall = navegador(false,false,true,true,valorWall,2,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,190,"Imagen de fondo: "..fondoC[valorWall],0.6,blanco,negro)
			end
--**************************************Opacidad de fondo********************************************
			if VM == 13 and y.conf == 0 then
				screen.print(10,205,"Opacidad de fondo: "..opacidad,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					opacidad = navegador(false,false,true,true,opacidad,260,10)
					if opacidad < 10 then opacidad = 250 end
					if opacidad > 250 then opacidad = 10 end
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,205,"Opacidad de fondo: "..opacidad,0.6,blanco,negro)
			end
--**************************************Tintado de fondo********************************************
			if VM == 14 and y.conf == 0 then
				screen.print(10,220,"Tintado de fondo: "..WallTintC[valorWallTint],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorWallTint = navegador(false,false,true,true,valorWallTint,2,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,220,"Tintado de fondo: "..WallTintC[valorWallTint],0.6,blanco,negro)
			end
--**************************************Color de tintado de fondo********************************************	
			if VM == 15 and y.conf == 0 then
				screen.print(10,235,"Color de tintado de fondo: "..colorConf[valorColorFondo],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorColorFondo = navegador(false,false,true,true,valorColorFondo,15,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,235,"Color de tintado de fondo: "..colorConf[valorColorFondo],0.6,blanco,negro)
			end
--**************************************Activar Protector de Pantalla****************************************************
			if VM == 16 and y.conf == 0 then
				screen.print(10,250,"Activar Protector de Pantalla: "..PPC[valorPP],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorPP = navegador(false,false,true,true,valorPP,2,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(10,250,"Activar Protector de Pantalla: "..PPC[valorPP],0.6,blanco,negro)
			end
--**************************************Tiempo del Protector de Pantalla***********************************************
			if VM == 17 and y.conf == 0 then
				screen.print(275,25,"Tiempo del Protector: "..minutosPP,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					minutosPP = navegador(false,false,true,true,minutosPP,10,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(275,25,"Tiempo del Protector: "..minutosPP,0.6,blanco,negro)
			end
--**************************************Tintado de carpeta********************************************
			if VM == 18 and y.conf == 0 then
				screen.print(275,40,"Tintado de carpeta: "..tintFileC[valorTintFile],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorTintFile = navegador(false,false,true,true,valorTintFile,2,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(275,40,"Tintado de carpeta: "..tintFileC[valorTintFile],0.6,blanco,negro)
			end
--**************************************Color de carpeta********************************************
			if VM == 19 and y.conf == 0 then
				screen.print(275,55,"Color de carpeta: "..colorConf[valorColorFile],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorColorFile = navegador(false,false,true,true,valorColorFile,15,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(275,55,"Color de carpeta: "..colorConf[valorColorFile],0.6,blanco,negro)
			end
--**************************************Color de fuente********************************************
			if VM == 20 and y.conf == 0 then
				screen.print(275,70,"Color de fuente: "..colorConf[valorFonte],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorFonte = navegador(false,false,true,true,valorFonte,15,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(275,70,"Color de fuente: "..colorConf[valorFonte],0.6,blanco,negro)
			end

--**************************************Color de Scrollbar********************************************
			if VM == 21 and y.conf == 0 then
				screen.print(275,85,"Color de Scrollbar: "..colorConf[colorScrollBar],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					colorScrollBar = navegador(false,false,true,true,colorScrollBar,15,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(275,85,"Color de Scrollbar: "..colorConf[colorScrollBar],0.6,blanco,negro)
			end
--**************************************Colores Aleatoreos********************************************
			if VM == 22 and y.conf == 0 then
				screen.print(275,100,"Colores Aleatoreos",0.6,blanco,AliceBlue)
				if controls.press("cross") then
					valorFondo = math.random(1,15)
					valorColorPar = math.random(1,15)
					valorCola = math.random(1,15)
					valorFonte = math.random(1,15)
					valorColorFile = math.random(1,15)
					colorScrollBar = math.random(1,15)
					valorColorFondo = math.random(1,15)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(275,100,"Colores Aleatoreos",0.6,blanco,negro)
			end
--**************************************Brillo de pantalla********************************************
			if VM == 23 and y.conf == 0 then
				screen.print(275,115,"Brillo de pantalla: "..brillo,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					brillo = navegador(false,false,true,true,brillo,100,10)
					if brillo < 30 then brillo = 90 end
					if brillo > 90 then brillo = 30 end
					configurar()
					screen.brightness(brillo)
				end
			elseif y.conf == 0 then 
				screen.print(275,115,"Brillo de pantalla: "..brillo,0.6,blanco,negro)
			end
--**************************************Tipo de teclado****************************************************
			if VM == 24 and y.conf == 0 then
				screen.print(275,130,"Tipo de teclado: "..tipoTeclado[valorTeclado],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorTeclado = navegador(false,false,true,true,valorTeclado,4,1)
					configurar()
				end
			elseif y.conf == 0 then 
				screen.print(275,130,"Tipo de teclado: "..tipoTeclado[valorTeclado],0.6,blanco,negro)
			end
--**************************************Capturas****************************************************
			if VM == 25 and y.conf == 0 then
				screen.print(275,145,"Capturas: "..capC[valorCap],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorCap = navegador(false,false,true,true,valorCap,2,1)
					configurar()
					dofile("idiomas.ini")
					capC = {conUSBactivado,conUSBdesactivado}
				end
			elseif y.conf == 0 then 
				screen.print(275,145,"Capturas: "..capC[valorCap],0.6,blanco,negro)
			end
--**************************************Idioma****************************************************
			if VM == 26 and y.conf == 0 then
				screen.print(275,160,idiom..idiomas[valorIdioma],0.6,color.new(100,100,100),negro)
				if controls.press("right") or controls.press("left") then
					--valorIdioma = navegador(false,false,true,true,valorIdioma,5,1)
					--configurar()
					--dofile("idiomas.ini")
					--cUSB = {conUSBdesactivado,conUSBactivado}
					--colorConf = {red,black,blue,verde,morado,yellow}
					--olasC = {conUSBactivado,conUSBdesactivado}
				end
			elseif y.conf == 0 then 
				screen.print(275,160,idiom..idiomas[valorIdioma],0.6,blanco,negro)
			end
--**************************************Conexion USB****************************************************			
			if VM == 27 and y.conf == 0 then
				screen.print(275,175,conUSB..cUSB[valorUSB],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorUSB = navegador(false,false,true,true,valorUSB,2,1)
					dofile("idiomas.ini")
					cUSB = {conUSBdesactivado,conUSBactivado}
				end
			elseif y.conf == 0 then 
				screen.print(275,175,conUSB..cUSB[valorUSB],0.6,blanco,negro)
			end				

--**************************************Suspender********************************************
			if VM == 28 and y.conf == 0 then
				screen.print(275,190,suspen,0.6,blanco,AliceBlue)
				if controls.press("cross") then
					if os.message(Qsupen,1) == 1 then
						power.suspend()
					end
				end
			elseif y.conf == 0 then 
				screen.print(275,190,suspen,0.6,blanco,negro)
			end
--**************************************Creditos********************************************
			if VM == 29 and y.conf == 0 then
				screen.print(275,205,creditos,0.6,blanco,AliceBlue)
				if controls.press("cross") then
					credits = not credits
				end
			elseif y.conf == 0 then 
				screen.print(275,205,creditos,0.6,blanco,negro)
			end
--**************************************Salir********************************************
			if VM == 30 and y.conf == 0 then
				screen.print(275,220,salirXMB,0.6,blanco,AliceBlue)
				if controls.press("cross") then
					if os.message(QsalirXMB,1) == 1 then
						os.quit()
					end
				end
			elseif y.conf == 0 then 
				screen.print(275,220,salirXMB,0.6,blanco,negro)
			end
--*************************************Cambio de Memoria********************************************
			if VM == 31 and y.conf == 0 and pspGO == true then
				screen.print(275,235,cambioMemoria..memos[valorMemo],0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorMemo = navegador(false,false,true,true,valorMemo,2,1)
					indice = 1
					limInf = 1
					cambioDir = true
				end
			elseif y.conf == 0 and pspGO == true then 
				screen.print(275,235,cambioMemoria..memos[valorMemo],0.6,blanco,negro)
			end
		end
		else 
		draw.gradrect(0,y.conf,480,272,color1,color1,color2,color2)
		if y.conf < 272 then 
			y.conf = y.conf + 17
		end
	end
end
function slideY2(bool,color1,color2)
	if bool == true  then
		if y.info > 0 then
			draw.gradrect(0,y.info,480,272,color1,color1,color2,color2)
			y.info = y.info - 15 
		end
		if y.info <= 0 then
			draw.gradrect(0,0,480,272,color1,color1,color2,color2)
		end
	else 
		draw.gradrect(0,y.info,480,272,color1,color1,color2,color2)

		if y.info < 272 then 
			y.info = y.info + 15
		end
	end
end
