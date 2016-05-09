--[[
 * PSP Claw Explorer
 * Copyright 2016 Carlos Monge.
 * Licensed under MIT (https://github.com/carcmonge/pspclawexplorer/blob/master/LICENSE)
]]--
os.cpu(333)
	world.lighttype(1,2)
	world.lightcomponent(1,1)
	world.lightambient(1,color.new(255,255,255))
	world.lightposition(1,0,0,-150)
	world.lightenabled(1,true)
	world.lightattenuation(1,0,0,0.0000005)
	world.lights(true)
	world.ambient(color.new(0,0,0))
	world.specular(4.04)
	world.update()
	white = color.new(255,255,255)
	black = color.new(0,0,0)
	red = color.new(255,0,0)
	green = color.new(0,255,0)
	blue = color.new(0,0,255)
	fondo = image.load("recursos/background.png")
	controlsobj = image.load("recursos/controls.png")
	coordenadas = model.load("recursos/coordenadas.obj",0.008,black)
	ejeX = 0
	ejeY = 0
	ejeZ = -12
while (true) do
	objeto:position(0,0,ejeZ)
	objeto:rotation(ejeY,ejeX,0)
	coordenadas:position(20,-10,-20)
	coordenadas:rotation(ejeY,ejeX,0)
controls.read()
	if controls.triangle() then ejeY = ejeY + 0.05 end
	if controls.cross() then ejeY = ejeY - 0.05 end
	if controls.circle() then ejeX = ejeX + 0.05 end
	if controls.square() then ejeX = ejeX - 0.05 end
	if controls.r() then ejeZ = ejeZ + 0.05 end
	if controls.l() then ejeZ = ejeZ - 0.05 end
	if controls.press("start") then 
		fondo:free()
		controlsobj:free()
		coordenadas:free()
		objeto:free()
		in_slideTrans = false
		in_explorer = true
		controls.read()
		break 
	end
fondo:blit(0,0)
objeto:blit()
controlsobj:blit(0,0)
coordenadas:blit()
screen.print(400,255,"FPS:"..screen.fps(),0.77,white,black)
screen.print(5,211,"X:"..ejeX,0,77,red,black)
screen.print(5,233,"Y:"..ejeY,0,77,green,black)
screen.print(5,255,"Z:"..ejeZ,0,77,blue,black)
screen.flip()
end







