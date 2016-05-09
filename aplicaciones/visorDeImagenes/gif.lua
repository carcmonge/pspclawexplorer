--[[
 * PSP Claw Explorer
 * Copyright 2016 Carlos Monge.
 * Licensed under MIT (https://github.com/carcmonge/pspclawexplorer/blob/master/LICENSE)
]]--
if imagenGif == true then
	draw.fillrect(0,0,480,272,blanco2)
	if menuIMG == false then
		if controls.square() and controls.up() and foto.escala < 200 then foto.escala = foto.escala + 1 end
		if controls.square() and controls.down() and foto.escala > 15 then foto.escala = foto.escala - 1 end
		if controls.square() and controls.press("l") then
			foto.angulo = foto.angulo - 90
		end
		if controls.square() and controls.press("r") then  
			foto.angulo = foto.angulo + 90
		end
		if controls.down() and controls.square() == false then foto.y = foto.y + 5 end
		if controls.up() and controls.square() == false then foto.y = foto.y - 5 end
		if controls.right() and controls.square() == false then foto.x = foto.x + 5 end
		if controls.left() and controls.square() == false then foto.x = foto.x - 5 end
	end
	anim.rotate(migif,foto.angulo)
	--anim.factorscale(obj,escala)
	migif:blit(foto.x,foto.y,foto.escala)
	if menuIMG == false then
		if controls.square() and controls.up() and foto.escala <= 200 then 
			draw.fillrect(25,220,75,25,lavenderAlpha)
			image.blit(30,223,visorDeImagenes.zoomMas)		
			screen.print(50,230,foto.escala.."%")
		end
		if controls.square() and controls.down() and foto.escala >= 15 then 
			draw.fillrect(25,220,75,25,lavenderAlpha)
			image.blit(30,223,visorDeImagenes.zoomMenos)		
			screen.print(50,230,foto.escala.."%") 
		end
	end
	if menuIMG == true then
		draw.fillrect(0,0,480,272,color.new(0,0,0,150))
		if slideAlpha4 == 225 then
			slideAlphaPlus4 = -5 
		elseif slideAlpha4 == 100 then
			slideAlphaPlus4 = 5
		end
		slideAlpha4 = slideAlpha4 + slideAlphaPlus4
		if V == 1 then
			image.blit(16,100,visorDeImagenes.zoomCancel)
			image.blend(16-24,100-23,selek,slideAlpha4)
			screen.print(66,140,cancelZoom,0.9,blanco,negro)
		else
			image.blit(16,100,visorDeImagenes.zoomCancel)
		end   
      
      if V == 2 then
        image.blit(48,100,visorDeImagenes.zoomMenos)
		image.blend(48-24,100-23,selek,slideAlpha4)
        screen.print(66,140,alejZoom,0.9,blanco,negro)
      else
        image.blit(48,100,visorDeImagenes.zoomMenos)
      end
		if V == 3 then
			image.blit(79,100,visorDeImagenes.zoomMas)
			image.blend(79-24,100-23,selek,slideAlpha4)
			screen.print(66,140,acercar,0.9,blanco,negro)
		else
			image.blit(79,100,visorDeImagenes.zoomMas)
		end
		if V == 4 then
			image.blit(113,100,visorDeImagenes.rotateLeft)
			image.blend(113-24,100-23,selek,slideAlpha4)
			screen.print(66,140,rotarI,0.9,blanco,negro)
		else
			image.blit(113,100,visorDeImagenes.rotateLeft)
		end
		if V == 5 then
			image.blit(144,100,visorDeImagenes.rotateRight)
			image.blend(144-24,100-23,selek,slideAlpha4)
			screen.print(66,140,rotarD,0.9,blanco,negro)
		else
			image.blit(144,100,visorDeImagenes.rotateRight)
		end
		if V == 6 then
			image.blit(177,100,visorDeImagenes.direccionUp)
			image.blend(177-24,100-23,selek,slideAlpha4)
			screen.print(66,140,Desplaza,0.9,blanco,negro)
		else
			image.blit(177,100,visorDeImagenes.direccionUp)
		end
		if V == 7 then
			image.blit(208,100,visorDeImagenes.direccionDown)
			image.blend(208-24,100-23,selek,slideAlpha4)
			screen.print(66,140,Desplaza,0.9,blanco,negro)
		else
			image.blit(208,100,visorDeImagenes.direccionDown)
		end
		if V == 8 then
			image.blit(236,103,visorDeImagenes.direccionLeft)
			image.blend(236-24,100-23,selek,slideAlpha4)
			screen.print(66,140,Desplaza,0.9,blanco,negro)
		else
			image.blit(236,103,visorDeImagenes.direccionLeft)
		end
		if V == 9 then
			image.blit(267,103,visorDeImagenes.direccionRight)
			image.blend(267-24,100-20,selek,slideAlpha4)
			screen.print(66,140,Desplaza,0.9,blanco,negro)
		else
			image.blit(267,103,visorDeImagenes.direccionRight)
		end
		if V == 10 then
			image.blit(136,60,visorDeImagenes.InformacionDeImagen)
			image.blend(136-20,60-23,selek,slideAlpha4)
			screen.print(66,140,fotoInfo,0.9,blanco,negro)
		else
			image.blit(136,60,visorDeImagenes.InformacionDeImagen)
		end
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
    if controls.press("triangle") then
      if menuIMG == false then
         menuIMG = true
         V = 1
      else
         menuIMG = false
      end
   end
   if controls.press("cross") and menuIMG == true then
         if V == 1 and foto.escala != 100 then
			foto.escala = 100
         elseif V == 2 then
		 elseif V == 3 then
		 elseif V == 4 then
			foto.angulo = foto.angulo - 90
		 elseif V == 5 then
			foto.angulo = foto.angulo + 90
		  elseif V == 10 then
		       seeInfoIMG = not seeInfoIMG
		 end
	end
	if controls.cross() and menuIMG == true then
         if V == 2 and foto.escala  > 15  then
			foto.escala = foto.escala - 1
		 elseif V == 3 and foto.escala < 200 then
			foto.escala = foto.escala + 1
		 elseif V == 6 then
			foto.y = foto.y - 1
		 elseif V == 7 then
			foto.y = foto.y + 1
		 elseif V == 8 then
			foto.x = foto.x + 1
		 elseif V == 9 then
			foto.x = foto.x - 1
		 end
		 if V == 2 then
			draw.fillrect(25,220,75,25,lavenderAlpha)
			image.blit(30,223,visorDeImagenes.zoomMas)		
			screen.print(50,230,foto.escala.."%")
		elseif V == 3 then
			draw.fillrect(25,220,75,25,lavenderAlpha)
			image.blit(30,223,visorDeImagenes.zoomMenos)		
			screen.print(50,230,foto.escala.."%") 
		 end
	end
	if seeInfoIMG == true then
		draw.fillrect(0,0,480,23,colorAlpha[valorFondo])
		screen.print(25,6,files.nopath(curDicT[indice].name))
	end
end