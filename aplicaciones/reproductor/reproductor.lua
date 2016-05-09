--[[
 * PSP Claw Explorer
 * Copyright 2016 Carlos Monge.
 * Licensed under MIT (https://github.com/carcmonge/pspclawexplorer/blob/master/LICENSE)
]]--
if rep_now and in_explorer == false then
	if olas == true then
		if tipOla == 1 then   
			pintarola(2)
		else
			pintarola2(2)
		end
	end   
	bateria()
	if VMR > 1 and VMR < 5 then
		fondos(rep_now)
		draw.gradrect(0,0,480,272,colorAlpha[1],colorAlpha[1],colorAlpha[1],colorAlpha[1])
		onParti()
	elseif VMR == 5 then
		draw.gradrect(0,0,480,272,colorAlpha[1],colorAlpha[1],colorAlpha[1],colorAlpha[1])
		onParti()
	else
		fondos(rep_now)
		draw.gradrect(0,0,480,272,colorAlpha[1],colorAlpha[1],colorAlpha[1],colorAlpha[1])
		onParti()
		if tipOla == 1 then   
			pintarola(2)
		else
			pintarola2(2)
		end
	end
    if VMR == 1 then 
    elseif VMR == 2 then
		sound.blit(sonido,"spectrum_gradlines",0,y.ecual-200,510,160,blanco,colorTXT[valorFondo],blanco)
    elseif VMR == 3 then
		sound.blit(sonido,"wave",0,60,480,160,colorTXT[valorFondo])
	elseif VMR == 4 then
		sound.blit(sonido,"waveline",0,60,480,160,colorTXT[valorFondo])
	elseif VMR == 5 then
		sound.blit(sonido,"spectrum_bars",0,20,527,245,negro,colorTXT[valorFondo],colorTXT[valorFondo],color.new(255,255,255,200),colorTXT[valorFondo],5)
	end
	draw.fillrect(0,0,480,27,colorAlpha2[valorFondo])
	image.blit(5,6,reproductor.notaICO)
	namemusic_x = screen.print(namemusic_x,11,id3MP3.album,0.8,blanco,0x0,"scroll_left",350)
	draw.fillrect(275,y.ecual-17,200,7,blanco)
	draw.gradrect(275,y.ecual-17,(sound.percent(sonido)*2)+1,7,colorAlpha[valorFondo],negro,colorAlpha[valorFondo],blanco)
	draw.rect(275,y.ecual-17,(sound.percent(sonido)*2)+1,7,negro)
	draw.rect(275,y.ecual-17,200,7,negro)
    if numPistaRep >= 10 then 
		screen.print(24,54,numPistaRep,0.9,blanco,0x0)
    else
		screen.print(32,54,numPistaRep,0.9,blanco,0x0)
    end
    screen.print(390,10,"("..numPistaRep.."/"..contadorMp3..")",1,blanco,0x0)
	if cover_bool  then 
		image.blit(7,26,cover)
		draw.rect(7,26,60,60,color.new(0,0,0))
	else 
		image.blit(22,41,reproductor.numeroDePistaICO)
	end
    songtime()
     screen.print(320,y.ecual-30,songtime())
    if sound.playing(sonido) == true then
        image.blit(15,y.ecual-25,reproductor.icoPlay)
	end
	draw.line(75,55,480,55,blanco)
	screen.print(75,40,id3MP3.title)
	screen.print(80,60,id3MP3.artist)
	if in_ecual == true then
		miniEcual() 
		if y.ecual > 200 then
			y.ecual = y.ecual - 15 
		end
		if y.ecual <= 0 then
			miniEcual() 
		end
	else 
		miniEcual() 
		if y.ecual < 272 then 
			y.ecual = y.ecual + 15
		end
	end
	if in_ecual == true then
			numOpci = 5
		if controls.press("right") and VMR > 0 and VMR ~= numOpci then
			VMR = VMR + 1
		elseif  controls.press("right") and VMR >= numOpci then 
			VMR = 1
		end
		if controls.press("left") and (VMR ~= 1 or VMR > 1) and VMR <= numOpci then
			VMR = VMR - 1
		elseif  controls.press("left") and VMR == 1 then 
			VMR = numOpci
		end   
		if VMR <= 1 and y.ecual == 197  then
			draw.rect(100-(VMR*80),y.ecual-5,126,75,blanco)
		elseif VMR <= 2 and y.ecual == 197 then
			draw.rect(250-(VMR*80),y.ecual-5,126,75,blanco)   
		elseif VMR == 3 and y.ecual == 197 then
			draw.rect(400-(VMR*80),y.ecual-5,126,75,blanco)
		elseif VMR == 4 and y.ecual == 197 then
			draw.rect(550-(VMR*80),y.ecual-5,126,75,blanco)
		elseif VMR == 5 and y.ecual == 197 then
			draw.rect(700-(VMR*80),y.ecual-5,135,70,blanco)
		end 
	end
	if controls.press("l") and capturas_bool == false then
		retroMP3()
	end
	if controls.press("r") and capturas_bool == false then
		adelMP3()
	end
	hprm.read()
	if controls.press("back") then
		retroMP3()
	end
	if controls.press("forward") then
		adelMP3()
	end
    if controls.press("playpause") then
      pausa()
    end
	if menuRep == true then
		if slideAlpha4 == 225 then
			slideAlphaPlus4 = -5 
		elseif slideAlpha4 == 100 then
			slideAlphaPlus4 = 5
		end
		slideAlpha4 = slideAlpha4 + slideAlphaPlus4
		if V == 1 then
			image.blit(250,100,reproductor.playICO)
			image.blend(240-15,90-15,selek,slideAlpha4)
			screen.print(300,132,repIni,0.9,blanco,0x0)
		else
			image.blit(250,100,reproductor.playICO)
		end   
      
		if V == 2 then
			image.blit(290,100,reproductor.pauseICO)
			image.blend(290-25,100-25,selek,slideAlpha4)
			screen.print(300,132,pauseIni,0.9,blanco,0x0)
		else
			image.blit(290,100,reproductor.pauseICO)
		end
		if V == 3 then
			image.blit(330,100,reproductor.stopICO)
			image.blend(330-25,100-25,selek,slideAlpha4)
			screen.print(300,132,stopIni,0.9,blanco,0x0)
		else
			image.blit(330,100,reproductor.stopICO)
		end
		if V == 4 then
			image.blit(370,100,reproductor.adelanteICO)
			image.blend(370-20,100-25,selek,slideAlpha4)
			screen.print(300,132,antIni,0.9,blanco,0x0)
		else
			image.blit(370,100,reproductor.adelanteICO)
		end
		if V == 5 then
			image.blit(410,100,reproductor.atrasICO)
			image.blend(410-20,100-25,selek,slideAlpha4)
			screen.print(300,132,sigIni,0.9,blanco,0x0)
		else
			image.blit(410,100,reproductor.atrasICO)
		end
		--[[if V == 6 then
			image.blit(450,100,colorICO)
			image.blend(450-25,100-25,selek,slideAlpha4)
			screen.print(300,132,"Descargar",0.9,blanco,0x0)
		else
			image.blit(450,100,colorICO)
		end--]]
		if controls.press("right") and V > 0 and V ~= numOpcion2 then
			V = V + 1
		elseif  controls.press("right") and V >= numOpcion2 then 
			V = 1
		end
		if controls.press("left") and (V ~= 1 or V > 1) and V <= numOpcion2 then  
			V = V - 1
		elseif  controls.press("left") and V == 1 then 
			V = numOpcion2
		end
   end
   porcentaje = sound.percent(sonido)
   if controls.right() and porcentaje <99 and in_ecual == false and menuRep == false then 
      porcentaje = porcentaje + 0.7 
      sonido:percent(porcentaje) 
   end 
   if controls.left() and porcentaje > 1 and in_ecual == false and menuRep == false then 
      porcentaje = porcentaje - 0.7 
      sonido:percent(porcentaje)
   end
   if sound.percent(sonido) >= 99 then
      adelMP3()
   end   
	if controls.press("triangle") then
		if menuRep == false and in_ecual == false then
			menuRep = true
			V = 1
			image.resize(selek,64,64)
		else
			menuRep = false
		end
	end
    if controls.press("start") then
      pausa()
    end
    if controls.press("cross") and menuRep == true then
		if V == 1 then
			pausa()
		elseif V == 2 then
			pausa()
		elseif V == 3 then
			if readText == true then
			readText = false     
			in_explorer = true
		end
		if rep_now == true then
			rep_now = false
            sound.stop(sonido)
            sound.free(sonido)
			in_explorer = true
			rep_nowNum = 0
        end
		if #curDicT > 0 then contarMP3() end
			menuRep = false
			V = 1
		elseif V == 4 then
			retroMP3()
		elseif V == 5 then
			adelMP3()
		elseif V == 6 then
			buscarMP3()
		end
	end
end
	