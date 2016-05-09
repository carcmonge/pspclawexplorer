fallballs = 3
probBalls = 3
function pausa()
	tmp = screen.toimage ()
	VM = 1
	while true do
        collectgarbage(restart)
        controls.read()
		VM = navegador(true,true,false,false,VM,2,1)
		tmp:blit(0,0)
		draw.gradrect(0,0,480,272,colorAlpha[1],colorAlpha[1],negro,negro)
		screen.print(240,15,"PAUSA",0.8,blanco,negro,"center",480)
		if VM == 1 then
			screen.print(40,50,"Esferas: "..fallballs,0.7,blanco,AliceBlue)
			if controls.press("right") or controls.press("left") then
				fallballs = navegador(false,false,true,true,fallballs,100,1)
			end
		else
			screen.print(40,50,"Esferas: "..fallballs,0.7,blanco,negro)
		end
		if VM == 2 then
			screen.print(40,70,"Probabilidad: "..((1/probBalls)*100).." % ("..probBalls..")",0.7,blanco,AliceBlue)
			if controls.press("right") or controls.press("left") then
				probBalls = navegador(false,false,true,true,probBalls,100,1)
			end
		else
			screen.print(40,70,"Probabilidad: "..((1/probBalls)*100).." % ("..probBalls..")",0.7,blanco,negro)
		end
		if controls.press("cross") then

		end
		if controls.press("circle") or controls.press("start") then
			tmp:free()
			controls.read()
			for i = 1, fallballs do
				bola[i] = {
					x = math.random (0,430),
					y = 0,
					w = 37,
					h = 36,
					number = math.random (2,14),
					velocidad = math.random (1,5),
					tipo = 1
				}
			end
			break
		end
		screen.flip()
	end
end

function colision(Obj1,Obj2)
	if Obj1.x + Obj1.w >= Obj2.x and
		Obj1.x <= Obj2.x + Obj2.w and
		Obj1.y + Obj1.h >= Obj2.y and
		Obj1.y <= Obj2.y + Obj2.h then
		return true else return false
	end
end

canasta = {
	x = 240,
	y = 230,
	w = 32,
	h = 32,
	color = color.new(255,255,255),
	controls = function (yomismo) 
		if controls.right() and yomismo.x < 449 then
			yomismo.x = yomismo.x + 6
		end
		if controls.left() and yomismo.x > 1 then
			yomismo.x = yomismo.x - 6
		end
	end,
	blit = function (yomismo)
		yomismo:controls()
		draw.gradrect(yomismo.x,230,32,32,yomismo.color,yomismo.color,color.new(0,0,0),color.new(0,0,0))
		draw.rect(yomismo.x,230,32,32,color.new(0,0,0))
	end
}

imgbola = image.load("./recursos/bola.png")
take 	= sound.load("sonido2.wav")
lose 	= sound.load("sonido1.wav")
bola = {}
for i = 1, fallballs do
	bola[i] = {
		x = math.random (0,430),
		y = 0,
		w = 37,
		h = 36,
		number = math.random (2,14),
		velocidad = math.random (1,5),
		tipo = 1
	}
end
function reasignacion(numero)
	bola[numero] = {
		x = math.random (0,430),
		y = 0,
		w = 37,
		h = 36,
		number = math.random (2,14),
		velocidad = math.random (3,6),
		tipo = math.random(1,probBalls)
	}
end
local puntaje = 0
local colorB = 1
image.resize(selek,75,75)

while true do
	elementosBases()
	canasta:blit()
	screen.print(10,10,"Puntaje: "..puntaje,1,negro,AliceBlue)
	for i = 1, fallballs do
		bola[i].y = bola[i].y + bola[i].velocidad
		if bola[i].tipo == 1 then
			colorB = bola[i].number
			image.fxtint(bola[i].x-20,bola[i].y-17,selek,colorTXT[colorB])
			image.fxtint(bola[i].x,bola[i].y,imgbola,colorTXT[colorB])
		else
			colorB = 1
			image.fxtint(bola[i].x-20,bola[i].y-17,selek,colorTXT[colorB])
			image.fxtint(bola[i].x,bola[i].y,imgbola,color.new(0,0,0))
		end
		if colision(bola[i],canasta) and bola[i].tipo == 1 then
			puntaje = puntaje + 3
			valorFondo,valorColorPar,valorCola,valorFonte,valorColorFile,colorScrollBar,valorColorFondo,canasta.color = bola[i].number,bola[i].number,bola[i].number,bola[i].number,bola[i].number,bola[i].number,bola[i].number,colorTXT[bola[i].number]
			sound.play(take,2)
			reasignacion(i)	
		elseif colision(bola[i],canasta) and bola[i].tipo > 1 then
			puntaje = puntaje - 5
			valorFondo,valorColorPar,valorCola,valorFonte,valorColorFile,colorScrollBar,valorColorFondo,canasta.color = 1,1,1,1,1,1,1,colorTXT[1]
			sound.play(lose,2)
			reasignacion(i)	
		end
		if bola[i].y >= 280 then
			reasignacion(i)			
		end
	end
	if controls.press("circle") then
		dofile("config.ini")
		break
	end
	if controls.press("start") then
		pausa()
	end
	screen.flip()
end