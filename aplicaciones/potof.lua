function slideY10(bool,color1,color2)
   if bool == true then
      draw.gradrect(Xmenu,0,140,272,color1,color1,color2,color2) 
      if Xmenu > 340 then 
         Xmenu = Xmenu - 10 
      end
      if Xmenu <= 340 then
         menus()
      end
   else 
      draw.gradrect(Xmenu,0,140,272,color1,color1,color2,color2)
      if Xmenu < 480 then Xmenu = Xmenu + 10    end
   end
end
function navegador10()
   if controls.press("down") and VM > 0 and VM ~= numOpci then
      VM = VM + 1
   elseif  controls.press("down") and VM >= numOpci then 
      VM = 1
   end
   
   if controls.press("up") and (VM ~= 1 or VM > 1) and VM <= numOpci then   
      VM = VM - 1
   elseif  controls.press("up") and VM == 1 then 
      VM = numOpci
   end
end
function menus()
	function save_foto()
		if controls.press("cross") then
			menu10 = false
			guardar = true
			guardar_time_foto:reset()
			guardar_time_foto:start()
		end
	end
	if menu10 == true then
		if slideAlpha == 60 then
			slideAlphaPlus = -1 
		elseif slideAlpha == 0 then
			slideAlphaPlus = 1
		end
		slideAlpha = slideAlpha + slideAlphaPlus
		blancoAlpha = color.new(255,255,255,slideAlpha)
			  screen.print(350,105,ini_guardar_foto)--1 
				screen.print(350,125,"")--2
				screen.print(350,145,"")--3
			  screen.print(350,165,"")--4
			  screen.print(350,185,"")--5
			  if VM == 1 then
					image.blit(340,95,slide_select)
					draw.gradrect(340,95,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
					save_foto()
				 elseif VM == 2 then
					image.blit(340,115,slide_select)
					draw.gradrect(340,115,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
				 elseif VM == 3 then
					image.blit(340,135,slide_select)
					draw.gradrect(340,135,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
				elseif VM == 4 then
					image.blit(340,155,slide_select)
					draw.gradrect(340,155,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
				elseif VM == 5 then
					image.blit(340,175,slide_select)
					draw.gradrect(340,175,140,25,blancoAlpha,blancoAlpha,blancoAlpha,blancoAlpha)
				end
		collectgarbage(restart)
	end
end
brillo10 = image.load("./recursos/brillo.png")
imagen = image.load("./recursos/imagen.png")
sombra = image.load("./recursos/sombra.png")
sombraBase = image.load("./recursos/sombraBase.png")
base = image.load("./recursos/base.png")
base2 = image.load("./recursos/base2.png")
local foto = image.load(curDicT[indice].name)
menu10 = false
Xmenu = 480
slideAlpha      = 0
VM = 1
numOpci = 1
guardar = false
guardar_time_foto = timer.new()
in_slideTrans = false
bool_fondoTrans = false 
in_explorer = false
ancho = {}
	ancho.brillo = image.width(brillo10)
	ancho.imagen = image.width(imagen)
	ancho.sombra = image.width(sombra)
	ancho.sombraBase = image.width(sombraBase)
	--ancho.base = image.width(base)
	ancho.base2 = image.width(base2)
	ancho.foto = 217
alto = {}
	alto.brillo = image.height(brillo10)
	alto.imagen = image.height(imagen)
	alto.sombra = image.height(sombra)
	alto.sombraBase = image.height(sombraBase)
	--alto.base = image.height(base)
	alto.base2 = image.height(base2)
	alto.foto = 169
x10 = {}
	x10.brillo = 136
	x10.imagen = 142
	x10.sombra = 135
	x10.sombraBase = 108
	x10.base = 0
	x10.base2 = 135
y10 = {}
	y10.brillo = 44
	y10.imagen = 49
	y10.sombra = 43
	y10.sombraBase = 22
	y10.base = 0
	y10.base2 = 43
image.resize(foto,217,169)
function redimensionar(valor)
	ancho.brillo = ancho.brillo + valor
	ancho.imagen = ancho.imagen + valor
	ancho.sombra = ancho.sombra + valor
	ancho.sombraBase = ancho.sombraBase + valor
	--ancho.base = ancho.base + valor
	ancho.base2 = ancho.base2 + valor
	ancho.foto = ancho.foto + valor
	alto.brillo = alto.brillo + valor
	alto.imagen = alto.imagen + valor
	alto.sombra = alto.sombra + valor
	alto.sombraBase = alto.sombraBase + valor
	--alto.base = alto.base + valor
	alto.base2 = alto.base2 + valor
	alto.foto = alto.foto + valor
	image.resize(brillo10,ancho.brillo,alto.brillo)
	image.resize(imagen,ancho.imagen,alto.imagen)
	image.resize(sombra,ancho.sombra,alto.sombra)
	image.resize(sombraBase,ancho.sombraBase,alto.sombraBase)
	--image.resize(base,ancho.base,alto.base)
	image.resize(base2,ancho.base2,alto.base2)
	image.resize(foto,ancho.foto,alto.foto)
end
function moverX(valor)
	x10.brillo = x10.brillo + valor
	x10.imagen = x10.imagen + valor
	x10.sombra = x10.sombra + valor
	x10.sombraBase = x10.sombraBase + valor
	x10.base = x10.base + valor
	x10.base2 = x10.base2 + valor
end
function moverY(valor)
	y10.brillo = y10.brillo + valor
	y10.imagen = y10.imagen + valor
	y10.sombra = y10.sombra + valor
	y10.sombraBase = y10.sombraBase + valor
	y10.base = y10.base + valor
	y10.base2 = y10.base2 + valor
end
while true do
	controls.read()
	navegador10()
	image.blit(0,0,base)
	image.blit(x10.sombraBase,y10.sombraBase,sombraBase)
	image.blit(x10.base2,y10.base2,base2)
	image.blit(x10.imagen,y10.imagen,foto)
	image.blit(x10.brillo,y10.brillo,brillo10)
	image.blit(x10.sombra,y10.sombra,sombra)
	slideY10(menu10,colorAlpha[valorFondo],colorAlpha[valorFondo])
	if math.floor(guardar_time_foto:time()/1000) >= 1 and guardar == true then
		--guardar_time_foto:pause()
		os.message(ini_newName_foto)
		newName = os.osk(ini_ingresarNombre_foto,"",40,6,0)
		if newName != "" and newName != nil then
			image.save(memoSelect.."PICTURE/"..newName..".png")
			os.message(":D")
			guardar_time_foto:stop()
			guardar = false
		else
			os.message("Ingresa un nombre para la captura")
			guardar_time_foto:stop()
			guardar = false
		end
	end
	screen.flip()
	if menu10 == false then
		if controls.l() then
			redimensionar(1)
		end
		if controls.r() then
			redimensionar(-1)
		end
		if controls.up() then
			moverY(-1)
		end
		if controls.down() then
			moverY(1)
		end
		if controls.right() then
			moverX(1)
		end
		if controls.left() then
			moverX(-1)
		end
	end
	if controls.press("triangle") then
		menu10 = not menu10
	end
	if controls.press("circle") then
		in_explorer = true
		brillo10:free()
		imagen:free()
		sombra:free()
		sombraBase:free()
		base:free()
		base2:free()
		foto:free()
		break
	end
end