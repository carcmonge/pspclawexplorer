xkey = {time = timer.new(),x=1,y=1,current = minus,pos = 1,texto = "",commentario = "",seleccion = image.load("imgXkey/cuadrado.png"),dot = false}
xkey.time:start()


function xkey.añadirletra(string,pos,letra)
if pos < #string then return string.sub(string,1,pos)..letra..string.sub(string,pos+1,#string)
elseif pos == #string then return string..letra end
end

xkey.minus = {
{"q","w","e","r","t","y","u","i","o","p"},
{"a","s","d","f","g","h","j","k","l","ñ"},
{"mayus","z","x","c","v","b","n","m","esp","OK"},
img  = image.load("imgXkey/tecladominus.png")
}
xkey.mayus= {
{"Q","W","E","R","T","y","U","I","O","P"},
{"A","S","D","F","G","H","J","K","L","Ñ"},
{"num","Z","x","C","V","B","N","M","esp","OK"},
img = image.load("imgXkey/tecladomayus.png")
}
xkey.num= {
{"0","1","2","3","4","5","6","7","8","9"},
{".",",","-","_","(",")","[","]","!","?"},
{"minus","á","é","í","ó","ú","`","´","esp","OK"},
img = image.load("imgXkey/tecladosimb.png")
}
xkey.peke= {
{"7","8","9"},
{"4","5","6"},
{"1","2","3"},
{"-","0","."},
img = image.load("imgXkey/tecladopeke.png")
}

function xkeyboard(Xteclado,Yteclado,Xtexto,Ytexto,texto,comentario,tipo,mover)
--Pasamos el texto inicial a string por si a caso
	xkey.texto = tostring((texto or ""))
--Si ya había una captura, primero liberarla
	if xkey.tmp then xkey.tmp:free() end
--Hacer una captura xkey.y almacenarla
	xkey.tmp = screen.toimage()
-- Teclado numérico o normal
	if tipo == 1 then xkey.current = xkey.peke else xkey.current = xkey.minus end
--Comentario o no
	xkey.comentario = comentario or ""
--Ponemos el "puntero" al final del texto
	xkey.pos = #texto
--Reiniciamos el xkey.time
	xkey.time:reset()
while true do
	controls.read()
	xkey.tmp:blit(0,0)
	draw.gradrect(0,0,480,272,colorAlpha[1],colorAlpha[1],negro,negro)
	draw.rect(50,45,360,20,blanco)
	if controls.press("right") then xkey.x=xkey.x+1 end
	if controls.press("left") then xkey.x=xkey.x-1 end
	if controls.press("up") then xkey.y=xkey.y-1 end
	if controls.press("down") then xkey.y=xkey.y+1 end
	if controls.press("r") and xkey.pos < #xkey.texto then xkey.pos = xkey.pos + 1 end
	if controls.press("l") and xkey.pos >0 and #xkey.texto >0 then xkey.pos = xkey.pos - 1 end
	if tipo == nil then
		if xkey.y>=4 then xkey.y=1 end
		if xkey.y<=0 then xkey.y=3 end
		if xkey.x>=11 then xkey.x=1 end
		if xkey.x<=0 then xkey.x=10 end
	elseif tipo == 1 then
		if xkey.y>=5 then xkey.y=1 end
		if xkey.y<=0 then xkey.y=3 end
		if xkey.x>=4 then xkey.x=1 end
		if xkey.x<=0 then xkey.x=1 end
	end

	if controls.press("cross") then
		if xkey.current[xkey.y][xkey.x] != "mayus" and xkey.current[xkey.y][xkey.x] != "minus" and xkey.current[xkey.y][xkey.x] != "num" and 
		xkey.current[xkey.y][xkey.x] != "esp" and xkey.current[xkey.y][xkey.x] != "OK" then 
			if tipo == nil then 
				xkey.texto = xkey.añadirletra(xkey.texto,xkey.pos,xkey.current[xkey.y][xkey.x]); xkey.pos = xkey.pos+1; 
			end
			if tipo == 1 and xkey.current[xkey.y][xkey.x] == "-" and string.sub(xkey.texto,1,1) != "-" then 
				xkey.texto = xkey.añadirletra(xkey.texto,xkey.pos,"-"); xkey.pos = xkey.pos+1; 
			elseif tipo == 1 and xkey.current[xkey.y][xkey.x] != "-" and xkey.current[xkey.y][xkey.x] != "." then 
				xkey.texto = xkey.añadirletra(xkey.texto,xkey.pos,xkey.current[xkey.y][xkey.x]); xkey.pos = xkey.pos+1; 
			elseif tipo == 1 and xkey.current[xkey.y][xkey.x] == "." and xkey.pos >0 and string.find(xkey.texto,".",1,true) == nil then 
				xkey.texto = xkey.añadirletra(xkey.texto,xkey.pos,".") ; xkey.pos = xkey.pos+1; end end
		if xkey.current[xkey.y][xkey.x] == "mayus" then xkey.current = xkey.num
		elseif xkey.current[xkey.y][xkey.x] == "num" then xkey.current = xkey.minus
		elseif xkey.current[xkey.y][xkey.x] == "minus" then xkey.current = xkey.mayus
		elseif xkey.current[xkey.y][xkey.x] == "OK" then break
		elseif xkey.current[xkey.y][xkey.x] == "esp" then xkey.texto = xkey.añadirletra(xkey.texto,xkey.pos," "); xkey.pos = xkey.pos +1 end
	end

	if controls.cross() then screen.print(Xtexto+screen.textwidth(xkey.comentario..string.sub(xkey.texto,1,xkey.pos)),Ytexto-1,"|") end
	if controls.press("square") and #xkey.texto > 0 and xkey.pos >0 then xkey.texto = string.sub(xkey.texto,1,xkey.pos-1)..string.sub(xkey.texto,xkey.pos+1,#xkey.texto); xkey.pos = xkey.pos -1; end
	if controls.press("triangle") and tipo == nil then xkey.texto = xkey.añadirletra(xkey.texto,xkey.pos," "); xkey.pos = xkey.pos +1 end
	if controls.press("circle") then xkey.texto = "" xkey.pos = 0 end
	if controls.press("select") then
		if xkey.current ==  mayus then current = xkey.num 
		elseif xkey.current == num then current = xkey.minus
		elseif xkey.current == minus then current = xkey.mayus end	
	end

	if mover then
		if math.abs(controls.analogx())>50 then Xteclado = Xteclado + controls.analogx()/15 end
		if math.abs(controls.analogy())>50 then Yteclado = Yteclado + controls.analogy()/15 end
	end

	xkey.current.img:blit(Xteclado,Yteclado)
	xkey.seleccion:blit(Xteclado+(21*xkey.x)-10,Yteclado+(21*xkey.y)-(9+xkey.y))
	screen.print(Xtexto,Ytexto,xkey.comentario..xkey.texto)

	if controls.press("start") then
			 xkey.tmp:free()
			 break		 
	end

	if not controls.cross() and xkey.time:time() >= 0 and xkey.time:time() < 500 then
		screen.print(Xtexto+screen.textwidth(xkey.comentario..string.sub(xkey.texto,1,xkey.pos)),Ytexto-1,"|") 
	elseif xkey.time:time() >= 1000 then xkey.time:reset()
	end

	screen.flip()
end
	xkey.time:stop()
	if tipo == nil then
		controls.read()
		return xkey.texto
	elseif tipo == 1 then 
		if #xkey.texto >0 then
			controls.read()
			return tonumber(xkey.texto); 
		else
			controls.read()
			return 0 
		end
	end
end