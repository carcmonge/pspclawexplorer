--[[
 * PSP Claw Explorer
 * Copyright 2016 Carlos Monge.
 * Licensed under MIT (https://github.com/carcmonge/pspclawexplorer/blob/master/LICENSE)
]]--
collectgarbage("collect")
-- Cargamos los colores necesarios para el menu de carga
negro       = color.new(0,0,0)
blanco      = color.new(255,255,255)
AliceBlue   = color.new(240,248,255)
-- Combrabando si el psp es GO! o NO! xD ba dum tss...
curDicT = files.list("ef0:/")
if curDicT == nil then
   pspGO = false 
   memoSelect = "ms0:/"
else
   pspGO = true
   memoSelect = "ef0:/"
end
-- Brillo de pantalla a 90%
screen.brightness(90)
-- Funciones de LuaDEV para los splash
--[[
os.luasplash()
os.luadevsplash()
--]]
-- La imagen del coder cammaker :D
coder = image.load("./recursos/cositas/coder.png")
-- funcion del loadcallback
function loadcallback()
   image.blit(0,0,coder)
   screen.flip();
end
--------------------------------------------
--scripts
--------------------------------------------
	--------------------------------------------
	--Sistema
	--------------------------------------------
		menuSlide 	= loadfile("./system/kernel/menuContextual.lua")
		slides 		= loadfile("./system/kernel/menuDeConfiguracion.lua")
		dofile("./system/kernel/funcionesDeCarga.lua")
	--------------------------------------------
	--Configuracion
	--------------------------------------------
		dofile("./system/configuracion/configuracion.ini")
	--------------------------------------------
	--Idiomas
	--------------------------------------------
		dofile("./system/idiomas/idiomas.ini")
	--------------------------------------------
	--Aplicaciones del Sistema
	--------------------------------------------
		visorDeImagenesAPP  	= loadfile("./aplicaciones/visorDeImagenes/imagenes.lua");
		visorDeImagenesGifAPP	= loadfile("./aplicaciones/visorDeImagenes/gif.lua");
		reproductorAPP			= loadfile("./aplicaciones/reproductor/reproductor.lua");
		dofile("./aplicaciones/reproductor/id3lib.lua");

--[[readTXT     = loadfile("./readTXT.lua")


CCleaner   	= loadfile("./CCleaner.lua")
buscarMP3   = loadfile("./BuscaMp3.lua")
plug    	= loadfile("./plug.lua")
traductor   = loadfile("./traductor.lua")
Buscaimg    = loadfile("./Buscaimg.lua")
infoPSP    	= loadfile("./informacion.lua")
buscador    = loadfile("./buscador.lua")
potof 		= loadfile("./potof.lua")
rooms		= loadfile("./BuscaRooms.lua")
objvis		= loadfile("./objvis.lua")
playlist	= loadfile("./Cplaylist.lua")
playlist1	= loadfile("./Cplaylist1.lua")
cotch		= loadfile("./cotch.lua")
dofile("animlib.lua")

dofile("conexion.ini")

--]]


-- esto es solo para prueba carlos recorda limpairlo 
tema = 1 
RutaDelTema = {}
RutaDelTemaIconos = {"/recursos/Temas/default/iconos/"}
RutaDelTemaArena = {"/recursos/Temas/default/LiveArena/"}
RutaDelTemaSistema = {"/recursos/Temas/default/sistema/"}
-- recordalo D:!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



---------------------------------------------
--Imagenes
--------------------------------------------
	---------------------------------------------
	--Imagenes/Explorador
	--------------------------------------------
		LiveArenaIconos("cargar")
    ---------------------------------------------
    --Imagenes/Explorador/Menu Despegable(slide)
    --------------------------------------------
		slide_select   = image.load("./recursos/cositas/slide_select.png")
    ---------------------------------------------
    --Imagenes/Olas
    --------------------------------------------
		ola				= {}
		ola2			= {}
		ola[2] 			= image.load(RutaDelTemaSistema[tema].."olaNegra.png")
		ola2[2] 		= image.load(RutaDelTemaSistema[tema].."olaNegra2.png")
    ---------------------------------------------
    --Imagenes/Explorador/Otros
    --------------------------------------------
		fondoUP     = image.load(RutaDelTemaSistema[tema].."up.png")
		fondoDOWN   = image.load(RutaDelTemaSistema[tema].."down.png")
		star			= image.load(RutaDelTemaSistema[tema].."estrella.png")
		selek			= image.load(RutaDelTemaSistema[tema].."selec.png")
		paletaC			= image.load("./recursos/cositas/paleta_color.png")
		paletaG			= image.load("./recursos/cositas/paleta_gris.png")
---------------------------------------------
--variables 
--------------------------------------------
y             = {}
y.dir         = 45 
y.ico         = 40
y.info         = 272
y.ecual         = 272
y.demo         = 10
y.confTXT = 272
y.conf = 272

indice         = 1
indice2         = 11
numOp         = 6
VM            = 3
VMR = 3
numOpci         = 3
limInf         = 1  
Xmenu          = 480
Xslide_select   = 115
slideAlpha      = 0
slideAlpha4 = 100
slideAlphaPlus   = 1
contadorMp3      = 0
difPlay         = 0
slideRep      = 272
rep_nowNum      = 0
sizeDic = 0
numCarpetas = 0
numFiles = 0
k            = 1
vaDez = 0
inferior = 1
tope = 16
tamañoTXT = 0.5
historial = 1
curdir_x = 10
namedir_x = 20
namemusic_x = 25
cpu_x = 410
batt_x = 387
mini_x = 25
PP_repx = 0
xs = 1
ys = 1
sizeTitle = 200
sumaprueba = 0
alfaPaleta = 255
opMenuSlide = 1
slideShell = 0
function sp(a,b)
   if a.directory == b.directory then
      return a.name < b.name
   end
return a.directory
end

if pspGO == true then
   curDicT = files.list("ef0:/")
else
   curDicT = files.list("ms0:/")
end
curAux = ""
table.sort(curDicT, sp)
portapapeles   = ""
vol = 199

numOpcion2 = 5
valorUSB = 1
valorMemo = 1
valorCap = cap
posIconsConta = 0
posIcons = {}
seleck = {}

for i = 1,3 do
	for j=1,5 do
		posIconsConta = posIconsConta + 1
		posIcons[posIconsConta] = {x=(90*j)-60,y=(70*i)-30}
		seleck[i..j] = {x=((90*j)-60)-12,y=((70*i)-30)-12}	end
end

teclas = {"up","down","left","right","l","r","triangle","cross","circle","square","start","select","hold","home"}
idiomas = {"Español","English","Français","Italiano","Deutsch"}

if files.exists(rutaFondo) then
   fondoI = image.load(rutaFondo)
else
   fondoI = image.load("./recursos/coder.png")
end
colorConf = {"Negro","Rojo","Azul","Celeste #1","Celeste #2","Verde #1","Verde #2","Amarillo","Naranja","Cafe","Morado #1","Morado #2","Rosado #1","Rosado #2","Personalizado"}
cUSB = {conUSBdesactivado,conUSBactivado}
olasC = {"Activado","Desactivado"}
memos = {"ef0:/","ms0:/"}
capC = {"Activado","Desactivado"}
partiC = {"Activado","Desactivado"}
miniMusic = {"Ecual","Nota"}
tipoTeclado = {"osk","xerpi","danzeff digital","danzeff analogo"}
PPC = {"Activado","Desactivado"}
fondoC = {"Activado","Desactivado"}
WallTintC = {"Activado","Desactivado"}
etiqueC = {"Activado","Desactivado"}
tintFileC = {"Activado","Desactivado"}
TnamePlugins = {"vsh","game","pops"}
Tnameplaylist = {"MUSIC","PICTURE","VIDEO"}
porcentajeGraf = {}
infoDicT = {}
instalPlug = ""
typeList={"MUSIC","PICTURE","VIDEO"}
valortypeList = 1
palabra = ""
---------------------------------------------
--variables/colores 
--------------------------------------------
rojo      = color.new(255,0,0)
rojoAlpha   = color.new(255,0,0,100)
rojoAlhpa2   = color.new(178,34,34)
verd      = color.new(0,255,0)
azul      = color.new(0,0,255)
amarillo   = color.new(255,255,0)
negro      = color.new(0,0,0)
negroAlpha      = color.new(0,0,0,200)
blanco      = color.new(255,255,255)
blancoAlpha   = color.new(255,255,255,slideAlpha)
blanco2 = color.new(200,200,200)
lavender = color.new(125,125,125)
AliceBlue = color.new(240,248,255)
GhostWhite = color.new(176,196,222)
GhostWhiteAlpha = color.new(176,196,222,200)
DarkGray = color.new(169,169,169,200)
LightGrey= color.new(211,211,211,100)
Gray= color.new(128,128,128)
DimGray= color.new(105,105,105)
LightSkyBlue = color.new(105,105,105)

Pink= color.new(255,192,203)
LightPink= color.new(255,182,193)
HotPink= color.new(255,105,180)
DeepPink= color.new(255,20,147)

colorTXT = {}
colorTXT[1] = color.new(119,136,153)--Negro
colorTXT[2] = color.new(255,0,0)--Rojo
colorTXT[3] = color.new(0,0,255)--Azul
colorTXT[4] = color.new(173,216,230)--Celeste 1
colorTXT[5] = color.new(0,191,255)--Celeste 2
colorTXT[6] = color.new(144,238,144)--Verde
colorTXT[7] = color.new(0,255,0)--Verde 2
colorTXT[8] = color.new(255,215,0)--Amarillo
colorTXT[9] = color.new(255,145,0)--Naranja
colorTXT[10] = color.new(139,69,19)--Cafe
colorTXT[11] = color.new(255,0,255)-- Morado 2
colorTXT[12] = color.new(147,112,219)--Morado
colorTXT[13] = color.new(255,182,193)--Rosado
colorTXT[14] = color.new(255,105,180)--
colorTXT[15] = color.new(canalR,canalG,canalB)--Amarillo 2
colorAlpha = {}
colorAlpha[1] = color.new(0,0,0,100)
colorAlpha[2] = color.new(255,0,0,100)
colorAlpha[3] = color.new(65,105,225,100)
colorAlpha[4] = color.new(173,216,230,100)
colorAlpha[5] = color.new(0,191,255,100) 
colorAlpha[6] = color.new(34,139,34,100)
colorAlpha[7] = color.new(0,255,0,100)
colorAlpha[8] = color.new(255,215,0,100)
colorAlpha[9] = color.new(255,145,0,100)
colorAlpha[10] = color.new(139,69,19,100)
colorAlpha[11] = color.new(255,0,255,100)
colorAlpha[12] = color.new(147,112,219,100)
colorAlpha[13] = color.new(255,182,193,100)
colorAlpha[14] = color.new(255,105,180,100)
colorAlpha[15] = color.new(canalR,canalG,canalB,100)
colorAlpha2 = {}
colorAlpha2[1] = color.new(100,100,100,100)
colorAlpha2[2] = color.new(255,0,0,100)
colorAlpha2[3] = color.new(65,105,225,100)
colorAlpha2[4] = color.new(34,139,34,100)
colorAlpha2[5] = color.new(0,191,255,100) 
colorAlpha2[6] = color.new(173,216,230,100)
colorAlpha2[7] = color.new(0,255,0,100)
colorAlpha2[8] = color.new(255,215,0,100)
colorAlpha2[9] = color.new(255,145,0,100)
colorAlpha2[10] = color.new(139,69,19,100)
colorAlpha2[11] = color.new(255,0,255,100)
colorAlpha2[12] = color.new(147,112,219,100)
colorAlpha2[13] = color.new(255,182,193,100)
colorAlpha2[14] = color.new(255,105,180,100)
colorAlpha[15] = color.new(canalR,canalG,canalB,100)
---------------------------------------------
--variables/Booleanos
--------------------------------------------
dismi            = false
rep_now          = false
in_slideTrans      = false
in_explorer         = true
bool_fondoTrans      = false
cargaTemp         = false
in_ecual         = false
in_configurationTXT = false
configuration = false
readText = false  
menuRep = false
cargaTempPBP = true
olas = true
imagenV = false
imagenGif = false
menuIMG = false
seeInfoIMG = false
credits = false
cambioDir = false
busqueda = false
capturas_bool = true
shell = false
pintarExplorador = true 
paletaton = false
cover_bool = false
--click = sound.load("./recursos/click.wav")

ebootTime = timer.new()
PP = timer.new()
PP_rep = timer.new()
iconShell = timer.new()
function songtime()
local total=""
   if math.floor((sonido:position()/1000)/3600) <10 then
      total="0"..math.floor((sonido:position()/1000)/3600)..":"
   else total=math.floor((sonido:position()/1000)/3600)..":"
   end

   if math.floor((sonido:position()/1000)/60)-(math.floor((sonido:position()/1000)/3600)*60) <10 then
      total=total.."0"..math.floor((sonido:position()/1000)/60)-(math.floor((sonido:position()/1000)/3600)*60)..":"
   else total=total..math.floor((sonido:position()/1000)/60)-(math.floor((sonido:position()/1000)/3600)*60)..":"
   end

   if math.floor(sonido:position()/1000)-(math.floor((sonido:position()/1000)/60)-math.floor((sonido:position()/1000)/3600))*60  <10 then
   total=total.."0"..math.floor(sonido:position()/1000)-(math.floor((sonido:position()/1000)/60)-math.floor((sonido:position()/1000)/3600))*60
   else total=total..math.floor(sonido:position()/1000)-(math.floor((sonido:position()/1000)/60)-math.floor((sonido:position()/1000)/3600))*60
   end
   if sonido:duration() then
   if math.floor((sonido:duration()/1000)/3600) <10 then
      total=total.."/0"..math.floor((sonido:duration()/1000)/3600)..":"
   else total=total.."/"..math.floor((sonido:duration()/1000)/3600)..":"
   end

   if math.floor((sonido:duration()/1000)/60)-(math.floor((sonido:duration()/1000)/3600)*60) <10 then
      total=total.."0"..math.floor((sonido:duration()/1000)/60)-(math.floor((sonido:duration()/1000)/3600)*60)..":"
   else total=total..math.floor((sonido:duration()/1000)/60)-(math.floor((sonido:duration()/1000)/3600)*60)..":"
   end

   if math.floor(sonido:duration()/1000)-(math.floor((sonido:duration()/1000)/60)-math.floor((sonido:duration()/1000)/3600))*60  <10 then
   total=total.."0"..math.floor(sonido:duration()/1000)-(math.floor((sonido:duration()/1000)/60)-math.floor((sonido:duration()/1000)/3600))*60
   else total=total..math.floor(sonido:duration()/1000)-(math.floor((sonido:duration()/1000)/60)-math.floor((sonido:duration()/1000)/3600))*60
   end

   end
   return total
end

function contarMP3()
      contadorMp3   = 0
      capMP3      = {}
      for j = 1, #curDicT do
        if files.ext(curDicT[j].name) == "mp3" then
          contadorMp3   = contadorMp3 + 1
         capMP3[contadorMp3] = {ubicacion = curDicT[j].name,numero = contadorMp3}
        end
      end
      for k = 1,#capMP3 do
        if curDicT[indice].name == capMP3[k].ubicacion then
          numPistaExp = k
          break
        end
      end
end

function miniEcual()
   if y.ecual >= 197 and y.ecual < 272 then
      draw.fillrect(100-(VMR*80),y.ecual-5,126,75,negro)
      draw.fillrect(250-(VMR*80),y.ecual-5,126,75,negro)
      draw.fillrect(400-(VMR*80),y.ecual-5,126,75,negro) 
      draw.fillrect(550-(VMR*80),y.ecual-5,126,75,negro)
      draw.fillrect(700-(VMR*80),y.ecual-5,135,70,negro)
      screen.print(140-(VMR*80),y.ecual+35,"OFF",1,negro,blanco)
      sound.blit(sonido,"spectrum_gradlines",250-(VMR*80),y.ecual-1,126,70,negro,colorTXT[valorFondo],blanco)
      sound.blit(sonido,"wave",400-(VMR*80),y.ecual+13,125,50,colorTXT[valorFondo])
      sound.blit(sonido,"waveline",550-(VMR*80),y.ecual+10,125,50,colorTXT[valorFondo])
      sound.blit(sonido,"spectrum_bars",700-(VMR*80),y.ecual+15,160,50,negro,colorAlpha[valorFondo],colorTXT[valorFondo],color.new(255,255,255,150),colorTXT[valorFondo],5)
      draw.rect(100-(VMR*80),y.ecual-5,126,75,lavender)
      draw.rect(250-(VMR*80),y.ecual-5,126,75,lavender)
      draw.rect(400-(VMR*80),y.ecual-5,126,75,lavender)
      draw.rect(550-(VMR*80),y.ecual-5,126,75,lavender)
      draw.rect(700-(VMR*80),y.ecual-5,135,70,lavender)
   end
end
function openMP3()
	loading("Cargando...")
	in_slideTrans 	= false
	bool_fondoTrans = false 
    in_explorer 	= false 
	numPistaRep 	= numPistaExp
    sonido    		= sound.load(curDicT[indice].name)
    id3MP3    		= sound.id3(curDicT[indice].name)

	done,cover       = pcall(id3.getArt,curDicT[indice].name)
	if done then
		if cover != "none found" then
			cover_bool  = true
			image.resize(cover,60,60)
		else 
			cover_bool  = false
		end
	end
    rep_now    		= true
    cargaTemp    	= true
    sound.play(sonido,1)
    numOpci 		= 4
    rep_nowNum 		= 1
end
function openIMG()
	loading("Cargando...")
	foto          = {}
	done,foto.pic       = pcall(image.load,curDicT[indice].name)
	if done then
		foto.peso       = files.sizeformat(curDicT[indice].size)
		foto.ancho       = image.width(foto.pic) 
		foto.alto        = image.height(foto.pic)
		if foto.ancho <= 512 or foto.alto <= 512 then
			in_slideTrans = false
			bool_fondoTrans = false 
			in_explorer = false
			imagenV = true
			foto.x          = 240
			foto.y         = 136
			foto.escala      = 100
			foto.angulo    = 0
			numOpcion2 = 10
			menuIMG = false
			seeInfoIMG = false
			image.resize(selek,64,64)
		else
		  os.message(imgIni)
		  image.free(foto.pic)
	   end
	else
		os.message("La imagen esta corrupta o dañada")
	end
end
function loadGIF()
	loading("Cargando...")
	foto          = {}
	migif = anim.create(curDicT[indice].name)
	migif:start()
    in_slideTrans = false
    bool_fondoTrans = false 
    in_explorer = false
	imagenGif = true
	foto.angulo    = 0
    foto.x          = 240
    foto.y         = 136
	foto.escala      = 100
    numOpcion2 = 10
    menuIMG = false
    seeInfoIMG = false
	image.resize(selek,64,64)
end
function usbCon()
   if valorUSB == 1 then
      usb.off()
   elseif valorUSB == 2 then
      usb.on()
      --image.blit(400,10,usbICO)
   end
end
function protectorPantalla()
   if valorPP == 1 then
      for i=1,#teclas do
         if controls.press(teclas[i]) then
            PP:reset()
         end
      end
      if math.floor(PP:time()/1000) >= minutosPP*60 then
         crearParticulas(numParticula,sizeParticula)
         PP:reset()
         PP:stop()
         if rep_nowNum == 1 then
            PP_rep:start()
            lapsos = 10
            PP_repx = math.random(20,250)
            PP_repy = math.random(10,230)
         end
         while true do
            collectgarbage(restart)
            controls.read()
            pintarParticulas(velParticulas,colorTXT[valorColorPar])
            if rep_nowNum == 1 then
				if sonido:percent() >= 99 then adelMP3() end
				if slideAlpha == 60 then
					slideAlphaPlus = -1 
				elseif slideAlpha == 0 then
					slideAlphaPlus = 1
				end
				slideAlpha = slideAlpha + slideAlphaPlus
				blancoAlpha = color.new(255,255,255,slideAlpha)
				draw.fillrect(PP_repx-35,PP_repy-10,215,25,blancoAlpha)
				if valorMini == 1 then
					fft = sound.fft(sonido)
					divi = 1
					for f = 12,15 do
					if math.ceil(fft[f]) > 20 then divi = 3 else divi = 1 end
						draw.gradrect((PP_repx-27)+7*(f-12),PP_repy+15,-5,(math.ceil(fft[f])*-1)/divi,colorAlpha[valorFondo],negro,colorAlpha[valorFondo],blanco)
					end
				else
					image.blit(PP_repx-25,PP_repy-6,reproductor.notaICO)
				end
				PP_repx = screen.print(PP_repx,PP_repy,"Titulo: "..id3MP3.title.."        Artista: "..id3MP3.artist,0.7,blanco,0x0,"scroll_left",175);
				--draw.rect(PP_repx-35,PP_repy-10,215,25,blanco)
				if math.floor(PP_rep:time()/1000) == lapsos then
					PP_repx = math.random(20,250)
					PP_repy = math.random(10,230)   
					lapsos = lapsos + 10
				end
            end
            screen.flip()
            if controls.press("up") then   break end
            if controls.press("down") then   break end
            if controls.press("right") then   break end
            if controls.press("left") then   break end
            if controls.press("l") then   break end
            if controls.press("r") then   break end
            if controls.press("triangle") then   break end
            if controls.press("cross") then   break end
            if controls.press("circle") then   break end
            if controls.press("square") then   break end
            if controls.press("select") then   break end
            if controls.press("home") then   break end
            if controls.press("start") then   break end
         end
         PP:start()
         if rep_nowNum == 1 then
            PP_rep:reset()
            PP_rep:stop()
         end
         controls.read()
      end
   elseif valorPP == 2 then
      PP:reset()
      PP:stop()
   end
end
function cambioMemo()
   if valorMemo == 1 then
      curDicT = files.list("ef0:/")
      memoSelect = "ef0:/"
   elseif valorMemo == 2 then
      curDicT = files.list("ms0:/")
      memoSelect = "ms0:/"
   end
end
function olasOn()
   if valorOlas == 1 then
      olas = true
   elseif valorOlas == 2 then
      olas = false
   end
end
function snap()
   if valorCap == 1 then
      capturas_bool = true
   elseif valorCap == 2 then
      capturas_bool = false
   end
end
function snap()
   if valorCap == 1 then
      capturas_bool = true
   elseif valorCap == 2 then
      capturas_bool = false
   end
end 
function onParti()
	if valorParti == 1 then
		pintarParticulas(velParticulas,colorTXT[valorColorPar])
	end
end
function retroMP3()
   for l = 199,0,-0.004 do
      vol = l 
      sound.volume(sonido,l)
   end
   if vol <= 0.01 then
   if numPistaRep > 1 then
      numPistaRep = numPistaRep - 1
   elseif numPistaRep == 1 then
      numPistaRep = contadorMp3
   end
   sonido    = sound.load(capMP3[numPistaRep].ubicacion)
   id3MP3    = sound.id3(capMP3[numPistaRep].ubicacion)
   sound.play(sonido,1)
end
end
function adelMP3()
   for l = 199,0,-0.004 do
      vol = l 
      sound.volume(sonido,l)
   end
   if vol <= 0.01 then
      if numPistaRep >= 1 and numPistaRep < contadorMp3 then
            numPistaRep = numPistaRep + 1
      elseif numPistaRep == contadorMp3 then
         numPistaRep = 1
      end
      sonido    = sound.load(capMP3[numPistaRep].ubicacion)
      id3MP3    = sound.id3(capMP3[numPistaRep].ubicacion)
      sound.play(sonido,1)
      vol = 199
   end
end
function pausa()
    if sound.playing(sonido) == true then
        sound.pause(sonido)
        if difPlay == 0 then
            difPlay = difPlay + 1
            reproductor.icoPlay = reproductor.pauseICO
        elseif difPlay == 1 then
            difPlay =difPlay - 1 
            reproductor.icoPlay = reproductor.playICO
        end
      end
end
function mostrarEboot(opcion)
    if files.ext(curDicT[indice].name) == "pbp" and cargaTempPBP == true then
      ebootTime:start()
      if math.floor(ebootTime:time()/1000) >= 1 then
         miniatura = pbp.geticon0(curDicT[indice].name)
         pic1 = pbp.getpic1(curDicT[indice].name)
         cargaTempPBP = false
      end
   end
    if cargaTempPBP == false and (controls.press("up") or controls.press("down")) then 
         ebootTime:reset()
         ebootTime:stop()
        if pic1 == image  then 
          image.free(pic1)
        end
        if miniatura == image then
          image.free(miniatura)
        end
        cargaTempPBP = true
    end
   if opcion == 0 then
     if cargaTempPBP == false and files.ext(curDicT[indice].name) == "pbp" and math.floor(ebootTime:time()/1000) >= 2 then
        
        if pic1 then
          image.blit(0,0,pic1)
        end
        if  miniatura then
         draw.gradrect(150,45,154,90,lavenderAlpha,lavenderAlpha,lavenderAlpha,lavenderAlpha)
          image.blit(155,50,miniatura)
        else
           draw.gradrect(150,45,154,90,lavenderAlpha,lavenderAlpha,lavenderAlpha,lavenderAlpha)
           --image.blit(155,50,default)
        end
     end
    end
   if opcion == 1 then
      if cargaTempPBP == false and files.ext(curDicT[indice].name) == "pbp" and math.floor(ebootTime:time()/1000) >= 2 then
        if  miniatura then
         draw.gradrect(150,45,154,90,lavenderAlpha,lavenderAlpha,lavenderAlpha,lavenderAlpha)
          image.blit(155,50,miniatura)
         else
        draw.gradrect(150,45,154,90,lavenderAlpha,lavenderAlpha,lavenderAlpha,lavenderAlpha)
        --image.blit(155,50,default)
        end
      end
   end
end
contarMP3()
slides()
slideAlpha2 = 100


posicion_ola = 480
 LightBlue= color.new(173,216,230)
 LightSteelBlue = color.new(30,144,255)
function pintarola(velocidad)
   posicion_ola = posicion_ola - velocidad;
   if ( posicion_ola <= 0 ) then posicion_ola = 480; end
      image.fxtint(math.ceil(posicion_ola),0,ola[2],colorTXT[valorCola]);
      image.fxtint(math.ceil(posicion_ola)-480,0,ola[2],colorTXT[valorCola]);
   end
function pintarola2(velocidad)
   posicion_ola = posicion_ola - velocidad;
   if ( posicion_ola <= 0 ) then posicion_ola = 480; end
   image.fxtint(math.ceil(posicion_ola),0,ola2[2],colorTXT[valorCola])
   image.fxtint(math.ceil(posicion_ola)-480,0,ola2[2],colorTXT[valorCola])
end
function extraeRAR()
   if os.message(rarIni,1) == 1 then
      archivo = io.open("rar/LuaHMv2/1.txt","w")
      archivo:write("cur = '"..files.nofile(curDicT[indice].name).."'".." \nfile = '"..curDicT[indice].name.."'".." \ndir= '"..files.cdir().."/".."'".."\nvalorIdioma = \""..valorIdioma.."\"")
      io.close(archivo)
      os.runeboot(files.cdir().."/rar/LuaHMv2/eboot.pbp")
   end
end
function extraerZIP()
   zip.extract(curDicT[indice].name,files.nofile(curDicT[indice].name),1)
   indice = 1
   indice2 = 11 
   limInf = 1
   curDicS = files.nofile(curDicT[indice].name)
   curDicT = files.list(curDicS)
   in_slideTrans = false
   in_explorer = true
   table.sort(curDicT, sp)
   os.message(zipIni)
end
function puto_for()
	if credits == true then
		scenery = image.load("./recursos/scenery.png")
		for i = 270,-550,-0.5 do
			scenery:blit(0,0)
			draw.fillrect(0,0,480,272,color.new(0,0,0,200))
			screen.print(240,0+i,"Code:\n cam-maker\n\n Graphics:\n cam-maker \n ANI-KIBA\n Paola Trigueros\n markef\n Wifly \n\n Betatesters: \n Chimecho \n ANI-KIBA\n Irving\n xerpi\n kenta15\n Tsukki\n\n Translations\n ANI-KIBA\n\n Greetings:\n DeViaNTe\n Chimeco\n xerpi\n speedbitsonico\n markef",0.66,blanco,negro,"center",480)
			screen.flip()
			if i == -550 then credits = false break end
		end
	end
end
function configurar()
   configuracion = io.open("config.ini","w")
   configuracion:write("valorFondo = "..valorFondo.."\nvalorIdioma = "..valorIdioma.." \nvalorOlas= "..valorOlas.."\ntipOla = "..tipOla.."\ncapturas = "..capturas.."\ncap = "..valorCap)
   configuracion:write("\nnumParticula = "..numParticula.."\nsizeParticula = "..sizeParticula.." \nvelParticulas= "..velParticulas.."\nvalorColorPar = "..valorColorPar.."\nvalorParti = "..valorParti) 
   configuracion:write("\nvalorMini = "..valorMini.."\nvalorCola = "..valorCola.."\nvalorTeclado = "..valorTeclado.."\nvalorPP = "..valorPP.."\nminutosPP = "..minutosPP.."\nvalorWall = "..valorWall)
   configuracion:write("\nopacidad = "..opacidad.."\nvalorWallTint = "..valorWallTint.."\nrutaFondo = \""..rutaFondo.."\"")
   configuracion:write("\nvalorMiniMusic = "..valorMiniMusic.."\nvalorWallTint = "..valorWallTint.."\nrutaFondo = \""..rutaFondo.."\"") 
   configuracion:write("\nbrillo = "..brillo.."\nvalorFonte = "..valorFonte.."\nvalorColorFile = "..valorColorFile.."\nvalorTintFile = "..valorTintFile.."\ncolorScrollBar = "..colorScrollBar.."\nvalorColorFondo = "..valorColorFondo)
   configuracion:write("\ncanalR = "..canalR.."\ncanalG = "..canalG.."\ncanalB = "..canalB.."\nconexion = "..conexion)
   io.close(configuracion)
end
function recur(dirc)
   local lugar2 = files.list(dirc)
   for c = 1,#lugar2 do
      demo:write("\n"..lugar2[c].name)
      if lugar2[c].directory then
         recur(lugar2[c].name)
      elseif lugar2[c].name:lower():match(palabra) then
         demo:write("\n"..lugar2[c].name)
         curDicT[indiceCur] = lugar2[c]
         indiceCur = indiceCur + 1
      end
   end
end
function buscarEXT(dirc,ext,tabla)
	local lugar2 = files.list(dirc)
	for c = 1,#lugar2 do
		if lugar2[c].directory and lugar2[c].name != memoSelect.."PSP/GAME" then
			buscarEXT(lugar2[c].name,ext,tabla)
		elseif files.ext(lugar2[c].name) == ext then
			--os.message(lugar2[c].name)
			files.copy(lugar2[c].name,memoSelect.."PSP/"..files.nopath(lugar2[c].name),true,true)
			tabla[#tabla+1] = lugar2[c].name
			totalsize = totalsize + lugar2[c].size
		end
   end
   return tabla
end
function recolector(dirc,tabla)
	local lugar2 = files.list(dirc)
	for c = 1,#lugar2 do
		if lugar2[c].directory and lugar2[c].name != memoSelect.."PSP/GAME" and lugar2[c].name != memoSelect.."MUSIC" and lugar2[c].name != memoSelect.."PICTURE" and lugar2[c].name != memoSelect.."VIDEO" and lugar2[c].name != memoSelect.."PSP/SAVEDATA" then
			recolector(lugar2[c].name,tabla)
		else
			for d=1,#tabla do
				if files.ext(lugar2[c].name) == tabla[d] then
					--files.copy(lugar2[c].name,"ms0:/PSP/basura/"..files.nopath(lugar2[c].name),true,true)
					tmp:write("\n"..lugar2[c].name)
					totalsize = totalsize + lugar2[c].size
				end
			end
			for d=1,#tabla do
				if files.ext(lugar2[c].name) == tabla[d] then
					--files.copy(lugar2[c].name,"ms0:/PSP/basura/"..files.nopath(lugar2[c].name),true,true)
					tmp:write("\n"..lugar2[c].name)
					totalsize = totalsize + lugar2[c].size
				end
			end
		end
   end
end
function pesoDirCC(dirc)
	local lugar2 = files.list(dirc)
	for c = 1,#lugar2 do
		if lugar2[c].directory then
			pesoDirCC(lugar2[c].name)
		else
			size = size + lugar2[c].size
		end
	end
end
function buscar()
	if controls.press("cross") then
		dir_busqueda = files.nofile(curDicT[indice].name)
		in_slideTrans = false
		in_explorer = true
		busqueda = true
		indiceCur = 1
		os.message("Haras una busqueda en el directorio\n \""..dir_busqueda.."\"\ningresa el nombre del archivo que deses buscar")
		teclados()
		palabra = newName
		if palabra != nil and palabra != "" then
			curDicT = {}
			demo = io.open("busqueda.txt","w")
			recur(dir_busqueda)
			io.close(demo)
			indice      = 1
			indice2    = 11
			limInf     = 1 
			os.message("Se encontraron "..#curDicT.." resultados")
			table.sort(curDicT, sp)
		elseif palabra == nil or palabra == "" then
			os.message(errorRenomb)
		end
	end
end
function ir()
   if controls.press("cross") then
      curDicT = files.list(files.nofile(curDicT[indice].name))
      table.sort(curDicT, sp)
      indice      = 1
      indice2    = 11
      limInf     = 1
      in_slideTrans = false
      in_explorer = true
   end
end
function atras()
   if historial > 1 then
      historial = historial - 1
   end
   if busqueda then
      indice = 1
      indice2 = 11
      limInf = 1
   else 
      indice = indices_Lim[historial].indi
      indice2 = indices_Lim[historial].indi2
      limInf = indices_Lim[historial].lim
   end
   if #curDicT > 0 then
      curDicS = files.nofile(files.nofile(curDicT[1].name))
      curAux = files.nofile(curAux)
   else
      if files.exists(curAux) then
         curDicS = files.nofile(curAux)
         curAux = files.nofile(curAux)
      else
         curDicS = files.nofile(files.nofile(curAux))
         curAux = files.nofile(curAux)
      end
   end
   curDicT = files.list(curDicS)
   table.sort(curDicT, sp)
end
function arriba()
      if in_explorer == true then
        dismi = true
      curdir_x = 10
      namedir_x = 20
         indice = indice - 1
        if indice == 0 then
           indice = #curDicT
           indice2 = indice + 1
           if #curDicT > 9 then
            limInf = indice - 8
           else 
            limInf = 1
           end
         end
      end
end
function abajo()
   if in_explorer == true then
      vaDez = 0
      curdir_x = 10
      namedir_x = 20
      indice = indice + 1
      dismi = false
      if indice > #curDicT then
         indice = 1
         indice2 = 11
         limInf = 1
      end
   end
end
function bateria()
	screen.print(425,11,batt.percent().."%",0.8,blanco,negro)
	draw.fillrect(385,5,30,15,blanco)
	draw.fillrect(415,10,3,5,blanco)
	draw.gradrect(387,7,26*(batt.percent()/100),11,colorTXT[valorFondo],colorTXT[valorFondo],negro,negro)
	if batt.charging() then
		batt_x = screen.print(batt_x,7,"Cargando",0.5,blanco,negro,"scroll_through",25);
	end
end
function pesoDir(dirc)
   local lugar2 = files.list(dirc)
   for c = 1,#lugar2 do
      if lugar2[c].directory then
         numCarpetas = numCarpetas + 1
         pesoDir(lugar2[c].name)
      else
         sizeDic = sizeDic + lugar2[c].size
         numFiles = numFiles + 1
         indiceCur = indiceCur + 1
      end
   end
end
function infoGraf(dirc)
	local total = 0
	dircPadre = files.list(dirc)
	table.sort(dircPadre, sp)
	infoDicT = {}
	for i = 1,#dircPadre do
		if dircPadre[i].directory then
			infoDicT[i] = {name =dircPadre[i].name,size=0,porcentaje=0,directory = true}
			pesoDirGraf(dircPadre[i].name,i) 
		else
			infoDicT[i] = {name =dircPadre[i].name,size=0,porcentaje=0,directory = false}
			infoDicT[i].size = dircPadre[i].size
		end
	end
	for i = 1,#infoDicT do
		total = total + infoDicT[i].size
	end
	for i = 1,#infoDicT do
		infoDicT[i].porcentaje = infoDicT[i].size/total
	end
	table.sort(infoDicT, fufu)
	curDicT = infoDicT
end
function fufu(a,b)
		return a.size > b.size
end
function pesoDirGraf(dircT,iteracion)
	local lugar2 = files.list(dircT)
	for c = 1,#lugar2 do
		if lugar2[c].directory then
			pesoDirGraf(lugar2[c].name,iteracion)
		else
			infoDicT[iteracion].size = infoDicT[iteracion].size + lugar2[c].size
		end
	end
end
function moverShell()
   if configuration == false then
      if controls.press("left") then
         xs = xs - 1
         if xs == 0 then
            xs = 5
         end
      end
      if controls.press("right") then
         xs = xs + 1
         if xs == 6 then
            xs = 1
         end
      end
      if controls.press("up") then
         ys = ys - 1
         if ys == 0 then
            ys = 3
         end
      end
      if controls.press("down") then
         ys = ys + 1
         if ys == 4 then
            ys = 1
         end
      end
   end
end
function cuadro(x,y,h,w,color1,color2,color3,color4,colorB)
   draw.gradrect(x,y,h,w,color1,color2,color3,color4)
   draw.rect(x,y,h,w,colorB)
end
function crearParticulas(numero,tamaño)
   xStar = {}
   yStar = {}
   estrellas = {}
   xRandom = {}
   yRandom = {}
   for i=1,numero do
      xStar[i] = math.random(470)
      yStar[i] = math.random(260)
      estrellas[i] = star
      estrellas[i]:factorscale(tamaño)
      xRandom[i]   = math.random(1,2)
      yRandom[i]   = math.random(1,2)
      if xRandom[i] == 1 then xRandom[i] = 1 else xRandom[i] = -1 end
      if yRandom[i] == 1 then yRandom[i] = 1 else yRandom[i] = -1 end
   end
end
function pintarParticulas(velocidad,colorPat)
   for i=1,#estrellas do
       xStar[i] = xStar[i] + (velocidad*xRandom[i])
       yStar[i] = yStar[i] + (velocidad*yRandom[i])
      if xStar[i] > 500 or xStar[i] < -60 or yStar[i] > 290 or yStar[i] < -60  then
         xStar[i] = math.random(480)
         yStar[i] = math.random(270)
         xRandom[i] = math.random(1,2)
         yRandom[i] = math.random(1,2)
         if xRandom[i] == 1 then xRandom[i] = 1 else xRandom[i] = -1 end
         if yRandom[i] == 1 then yRandom[i] = 1 else yRandom[i] = -1 end
      end
      image.fxtint(xStar[i],yStar[i],estrellas[i],colorPat)
   end
end
function navegador(d,u,r,l,val,limOp,plus,inicio)
	if not inicio then inicio = 1 end
	if controls.press("down") and val > 0 and val ~= limOp and d then
		val = val + plus
	elseif  controls.press("down") and val >= limOp and d then 
		val = inicio
	end
	if controls.press("up") and (val ~= inicio or val > inicio) and val <= limOp and u then   
		val = val - plus
	elseif  controls.press("up") and val == inicio and u then 
		val = limOp
	end
	if controls.press("right") and val > 0 and val ~= limOp and r then
		val = val + plus
	elseif  controls.press("right") and val >= limOp and r then 
		val = inicio
	end
	if controls.press("left") and (val ~= 1 or val > 1) and val <= limOp and l then
		val = val - plus
	elseif  controls.press("left") and val == 1 and l then 
		val = limOp
	end
	return val
end
function draw.circle(x,y,r,color)
  local x0, y0 = r, 0
  for i=0,90,9 do
     local x1,y1 = r*math.cos( math.rad( i )), r*math.sin(math.rad( i ));
     draw.line(x+x1,y+y1,x+x0,y+y0,color);
     draw.line(x+x0,y-y0,x+x1,y-y1,color);
     draw.line(x-x0,y+y0,x-x1,y+y1,color);
     draw.line(x-x0,y-y0,x-x1,y-y1,color);
     x0, y0 = x1, y1;
  end
end
function back()
    if controls.press("circle") then
		infoDicT = {}
		if #curDicT > 0 then
			if files.nofile(curDicT[indice].name) == memoSelect and Xmenu >= 480 and y.conf >= 272 and shell==false and bool_fondoTrans == false  then
				iconos("liberar");
				LiveArenaIconos("cargar");
				shell = true
				ladoSlideShell = -15
				slideShellBool = true
				slideShell = 500
				image.resize(selek,88,88)
			end
		end
		if in_explorer == true and curAux != memoSelect and busqueda == false then
			num_marck = 1
			if portapapeles == "" then 
				marcados = {""}
				num_marck = 1
			end
			busqueda = false
			ir_bus = false
			atras()
        end
		if busqueda == true and in_explorer == true then
			indice      = 1
			indice2    = 11
			limInf     = 1 
			curDicT = files.list(memoSelect)
			table.sort(curDicT, sp)
			busqueda = false
			shell = false
		end
        if readText == true and in_configurationTXT == false then
			in_configurationTXT = false
			readText = false        
			in_explorer = true
			shell = false
			desvanecer()
        end
		if rep_now == true then
			reproductorIconos("liberar");
			rep_now = false
			pintarExplorador = true
			sound.stop(sonido)
			sound.free(sonido)
			if cover_bool  then 
				image.free(cover)
			end
			if cover == image then
				image.free(cover)
			end
			in_explorer = true
			shell = false
			rep_nowNum = 0
			sizeTitle = 0
		end
		if imagenV then
			VisorDeImagenesIconos("liberar");
			imagenV = false
			image.free(foto.pic)
			in_explorer = true
			shell = false
			desvanecer()
		end
		if imagenGif then
			VisorDeImagenesIconos("liberar");
			imagenGif = false
			anim.free(migif)
			in_explorer = true
			shell = false
			desvanecer()
		end
        if bool_fondoTrans == true then
			in_slideTrans = true
			bool_fondoTrans = false
			if imgTemporal ~= nil then
				image.free(imgTemporal)
			end
			if rep_nowNum == 0 then
				if #curDicT > 0 then contarMP3() end
			end
			collectgarbage(restart)  
		end
        if in_slideTrans == false and bool_fondoTrans == false and in_explorer == false and rep_now == false and configuration == false then
			in_slideTrans = true
			in_explorer = false
        elseif in_slideTrans == true and bool_fondoTrans == false and configuration == false then
			in_slideTrans = false
			in_explorer = true
        else
        end
		if rep_nowNum == 0 then
			if #curDicT > 0 then contarMP3() end
		end
		controls.read()
		collectgarbage(restart)
   end
end
function encriptar()
   if os.message("¿Quieres encriptar el script \""..files.nopath(curDicT[indice].name).."\" con contraseña?\n Si lo encriptas con contraseña, no se podra usarse directamente en LuaDEV",1) == 1 then
      os.message("Escribe la contraseña")
      teclados()
      if newName ~= nil and newName ~= "" then
         files.encrypt(curDicT[indice].name,newName)
         os.message("El archivo \""..files.nopath(curDicT[indice].name).."\" ha sido encriptado con contraseña")
         ordenar()
      elseif newName == nil or newName == "" then
         os.message(errorRenombF)
         ordenar()
      end
   else
      files.encrypt(curDicT[indice].name)
      os.message("El archivo \""..files.nopath(curDicT[indice].name).."\" ha sido encriptado")
         ordenar()
   end
end
function desencriptar()
   if os.message("¿El script \""..files.nopath(curDicT[indice].name).."\" tiene contraseña?",1) == 1 then
      os.message("Escribe la contraseña")
      teclados()
      if newName ~= nil and newName ~= "" then
         files.decrypt(curDicT[indice].name,newName)
         os.message("El archivo \""..files.nopath(curDicT[indice].name).."\" ha sido desencriptado")
         ordenar()
      elseif newName == nil or newName == "" then
         os.message(errorRenombF)
         ordenar()
      end
   else
      files.decrypt(curDicT[indice].name)
      os.message("El archivo \""..files.nopath(curDicT[indice].name).."\" ha sido desencriptado")
      ordenar()
   end
end
function ordenar()
   if #curDicT > 0 then
      curDicS = files.nofile(curDicT[indice].name)
      curDicT = files.list(curDicS)
      table.sort(curDicT, sp)
   else
      curDicT = files.list(curAux)
      table.sort(curDicT, sp)
   end
   in_slideTrans = false
   in_explorer = true 
end
function loading(s)
   draw.gradrect(0,0,480,272,colorAlpha[1],colorAlpha[1],negro,negro)
   screen.print(240 - math.ceil(screen.textwidth(s))/2,135,s)
   screen.flip()
end
function teclados(p)
   if not p then p = "" end
   if valorTeclado == 1 then
      newName = os.osk(ingresarNombre,p,40,6,0)
   elseif valorTeclado == 2 then
      newName = xkeyboard(130,150,51,50,p,"")
   elseif valorTeclado == 3 then
      newName = danzeff(375,167,false,p)
   elseif valorTeclado == 4 then
      newName = danzeff(375,167,false,p)
   end
end
function fondos(repp)
	if not repp then repp = false end
	if valorWall == 1 then
		image.center(fondoI)
		if valorWallTint == 1 then
			image.fxtint(480/2,272/2,fondoI,colorTXT[valorFondo])
		else
			fondoI:blit(480/2,272/2)
		end
		draw.fillrect(0,0,480,272,color.new(0,0,0,opacidad),color.new(0,0,0,opacidad),color.new(0,0,0,opacidad),color.new(0,0,0,opacidad))
		image.fxtint(0,0,fondoUP,colorTXT[valorFondo])
	else
		image.fxtint(0,0,fondoUP,colorTXT[valorFondo])
		if repp == false then image.fxtint(0,29,fondoDOWN,colorTXT[valorColorFondo]) end
	end
end
function fondoPer()
   if controls.press("cross") then
      fondoI:free() 
      rutaFondo = curDicT[indice].name
      fondoI = image.load(rutaFondo)
      configurar()
   end
end
function barraCargado(s,it)
	tmpB:blit(0,0)
	draw.gradrect(0,0,480,272,colorAlpha[1],colorAlpha[1],negro,negro)
	screen.print(240 - math.ceil(screen.textwidth(s))/2,125,s)
	draw.fillrect(85,150,300,5,blanco)
	draw.gradrect(85,150,1+((it*100)/#marcados)*3,5,colorAlpha[valorFondo],negro,colorAlpha[valorFondo],blanco)
	screen.print(395,148,math.ceil((it*100)/#marcados).."%")
	screen.flip()
end
function scrollPlug()   
	if controls.press("down") then
		posicion = posicion + 1
		if posicion > 11 then inf = inf + 1 end
		if posicion > #tablaPlug then 
			posicion = 1
			inf = 1			
		end
	end
	if controls.press("up") then  
		posicion = posicion - 1
		if posicion > 10 then inf = inf - 1 end
		if posicion == 0 then 
			posicion = #tablaPlug
			if posicion > 10 then inf = #tablaPlug-10 end		
		end
	end
end
function elegir()
	tmp = screen.toimage ()
	local opcion = 1
	while true do
        collectgarbage(restart)
        controls.read()
		opcion = navegador(false,false,true,true,opcion,3,1)
		tmp:blit(0,0)
		draw.fillrect(0,0,480,272,color.new(0,0,0,150))
		screen.print(240,30,"¿En que archivo deseas instalar este plugin?",0.8,blanco,negro,"center",480)
		if opcion == 1 then
			screen.print(240,60,"< vsh.txt >",0.8,blanco,negro,"center",480)
		elseif opcion == 2 then
			screen.print(240,60,"< game.txt >",0.8,blanco,negro,"center",480)
		elseif opcion == 3 then
			screen.print(240,60,"< pops.txt >",0.8,blanco,negro,"center",480)
		end
		if controls.press("cross") then
			namePlug = TnamePlugins[opcion]..".txt"
			tmp:free()
			plug()
			break
		end
		if controls.press("circle") then
			tmp:free()
			controls.read()
			break
		end
		screen.flip()
	end
end
function elegirLIST()
	tmp = screen.toimage ()
	local opcion = 1
	while true do
        collectgarbage(restart)
        controls.read()
		opcion = navegador(false,false,true,true,opcion,2,1)
		tmp:blit(0,0)
		draw.fillrect(0,0,480,272,color.new(0,0,0,150))
		screen.print(240,30,"Elige una accion que deses realizar",0.8,blanco,negro,"center",480)
		if opcion == 1 then
			screen.print(240,60,"< Crear Playlist >",0.8,blanco,negro,"center",480)
		elseif opcion == 2 then
			screen.print(240,60,"< Ver o Modificar Playlist >",0.8,blanco,negro,"center",480)
		end
		if controls.press("cross") then
			if opcion == 1 then
				tmp:free()
				playlist()
			elseif opcion == 2 then
				valorList = 1
				inferior = 1
				tope = 16
				posicion = 1
				inf = 1
				nameplaylist = "MUSIC"
				listasT = files.list(memoSelect.."PSP/PLAYLIST/"..nameplaylist)
				for i = 1, #listasT do
					if files.ext(listasT[i].name) != "m3u8" then
						table.remove(listasT,i)
					end
				end
				boolListas = true
				TfileContenidos = {}
				playlist1()
			end
			break
		end
		if controls.press("circle") then
			tmp:free()
			controls.read()
			break
		end
		screen.flip()
	end
end
function desvanecer()
	for i = 0,255,20 do
		draw.fillrect(0,0,480,272,color.new(200,200,200,255-i))
		screen.flip()
	end
end
function aparecer()
	for i = 0,255,20 do
		draw.fillrect(0,0,480,272,color.new(200,200,200,0+i))
		screen.flip()
	end
end
function pintarExploradorNames(scrollBarX,posXname,posXinfo)
		for i=limInf, valorTabla do
			check = negro
			for p=1,#marcados do
				if marcados[p] == curDicT[i].name then
					check = color.new(255,255,255)
				end
			end
			if #infoDicT > 0 then 
				draw.gradrect(20,y.dir-5,infoDicT[i].porcentaje*410,20,colorTXT[valorFondo],colorTXT[valorFondo],negro,negro) 
				draw.rect(20,y.dir-5,infoDicT[i].porcentaje*410,20,negro)
				InfoDir = (math.ceil(infoDicT[i].porcentaje*100*100)/100).."% ("..files.sizeformat(curDicT[i].size)..")"
				InfoFile = (math.ceil(infoDicT[i].porcentaje*100*100)/100).."% ("..files.sizeformat(curDicT[i].size)..")"
			else
				InfoDir = carpeta
				InfoFile = files.sizeformat(curDicT[i].size)
			end
			if i == indice then
				Color = colorTXT[valorFonte]
				if #infoDicT <= 0 then draw.fillrect(0,y.dir-5,480,20,color.new(0,0,0,200)) end
				screen.print(posXname,y.dir,string.format("%.56s",files.nopath(curDicT[i].name)),0.6,colorTXT[valorFonte],check)
			else
				Color = blanco
				screen.print(posXname,y.dir,string.format("%.56s",files.nopath(curDicT[i].name)),0.6,blanco,check)
			end
			if curDicT[i].directory then --Icono de carpetas
				if valorTintFile == 1 then
					image.fxtint(0,y.ico,ico.carpeta,colorTXT[valorColorFile]);
				else
					image.blit(0,y.ico,ico.carpeta)
				end
				screen.print(posXinfo,y.dir,InfoDir,0.6,Color,check)
			elseif files.ext(curDicT[i].name) == "mp3" or files.ext(curDicT[i].name) == "at3" or files.ext(curDicT[i].name) == "bgm" or files.ext(curDicT[i].name) == "wav" then
				image.blit(0,y.ico,ico.mp3)
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			elseif files.ext(curDicT[i].name) == "jpg" then
				image.blit(0,y.ico,ico.image)
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			elseif files.ext(curDicT[i].name) == "png" then
				image.blit(0,y.ico,ico.image)
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			elseif files.ext(curDicT[i].name) == "gif"    then
				image.blit(0,y.ico,ico.image)
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			elseif files.ext(curDicT[i].name) == "txt" or files.ext(curDicT[i].name) == "lua" or files.ext(curDicT[i].name) == "ini" or files.ext(curDicT[i].name) == "log" then
				image.blit(0,y.ico,ico.txt)
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			elseif files.ext(curDicT[i].name) == "pbp" then
				image.blit(0,y.ico,ico.eboot)
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			elseif files.ext(curDicT[i].name) == "iso" then
				image.blit(0,y.ico,ico.iso)
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)  
			elseif files.ext(curDicT[i].name) == "cso" then
				image.blit(0,y.ico,ico.cso)
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			elseif files.ext(curDicT[i].name) == "zip" then
				image.blit(0,y.ico,ico.zip)
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			elseif files.ext(curDicT[i].name) == "rar" then
				image.blit(0,y.ico,ico.rar) 
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			elseif files.ext(curDicT[i].name) == "obj" then
				image.blit(0,y.ico,ico.obj) 
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			elseif files.ext(curDicT[i].name) == "prx" then
				image.blit(0,y.ico, ico.plug) 
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)   
			else --Icono archivo
				image.blit(0,y.ico,ico.file)
				screen.print(posXinfo,y.dir,InfoFile,0.6,Color,negro)
			end
			 y.dir = y.dir + 20
			 y.ico = y.ico + 20
		end
		draw.gradrect(scrollBarX,30,10,235,colorTXT[colorScrollBar],negro,colorTXT[colorScrollBar],negro)
		draw.rect(scrollBarX,30,10,235,negro)
		draw.fillrect(scrollBarX,30+(indice-1)*(235/#curDicT),10,(235/#curDicT),color.new(255,255,255))
		draw.rect(scrollBarX,30+(indice-1)*(235/#curDicT),10,(235/#curDicT),negro)
		y.dir = 45
		y.ico = 40
end
function paleton()
	if paletaton then
		valorFondo = 15
		valorColorPar = valorFondo
		valorCola = valorFondo
		valorFonte = valorFondo
		valorColorFile = valorFondo
		colorScrollBar = valorFondo
		valorColorFondo = valorFondo
		local palet,x,y,r,g,b = 1,135,80,canalR,canalG,canalB
		punteroX,punteroY = x,y
		local xTexto = x-30
		slideAlpha3 = 255
		while true do
			elementosBases()
			if slideAlpha3 == 255 then
				slideAlphaPlus = -5 
			elseif slideAlpha3 == 10 then
				slideAlphaPlus = 5
			end
			slideAlpha3 = slideAlpha3 + slideAlphaPlus
			blancoAlpha = color.new(255,255,255,slideAlpha3)
			if palet == 1 then
				paletaC:blit(x,y)
				colorPaleta = image.pixel(paletaC,punteroX-x,punteroY-y)
				screen.print(x+40,y-15,"Paleta de Color",0.65,blanco,0x0)
			else
				paletaG:blit(x,y)
				colorPaleta = image.pixel(paletaG,punteroX-x,punteroY-y)
				screen.print(x+40,y-15,"Paleta de Gris",0.65,blanco,0x0)
			end
			draw.rect(x,y,154,155,negro)
			draw.fillrect(x+160,y,64,64,colorPaleta)
			draw.rect(x+160,y,64,64,negro)
			puntero(x,y,punteroX,punteroY)
			convertHexa(tostring(colorPaleta))
			screen.print(x+160,y+70,"R: "..rgb[3].."\nG: "..rgb[2].."\nB: "..rgb[1])
			draw.fillrect(0,30,480,25,color.new(0,0,0,200))
			screen.print(240,40,"Selector de Color Personalizado",0.8,colorPaleta,0x0,"center",480)
			xTexto = screen.print(xTexto,255,"Presionar equis para guardar el color",0.7,blanco,blancoAlpha,"scroll_through",xTexto+150)
			screen.flip()
			if controls.press("select") then
				palet = palet + 1
				if palet > 2 then palet = 1 end
			end
			if controls.press("cross") then
				paletaton = false
				configurar()
				os.message("El color ha sido guardado")
				break
			end
			if controls.press("circle") then
				paletaton = false
				colorTXT[15] 	= color.new(r,g,b)
				colorAlpha[15] 	= color.new(r,g,b,100)
				colorAlpha2[15] = color.new(r,g,b,100)
				slideAlpha      = 0
				os.message("No se efectuaron cambios")
				break
			end
		end
	end
end

function puntero(x,y)
	if controls.left() and punteroX > x then
		punteroX = punteroX - 1
	end
	if controls.right() and punteroX < x+153 then
		punteroX = punteroX + 1
	end
	if controls.up() and punteroY > y then
		punteroY = punteroY - 1
	end
	if controls.down() and punteroY < (y-1)+155 then
		punteroY = punteroY + 1
	end
	draw.line(punteroX,punteroY,punteroX+5,punteroY,blanco)
	draw.line(punteroX,punteroY,punteroX-4,punteroY,blanco)
	draw.line(punteroX,punteroY,punteroX,punteroY+5,blanco)
	draw.line(punteroX,punteroY,punteroX,punteroY-4,blanco)
end
paletaton 	= false
--#3A4EC6
function convertHexa(valor)
	rgb = {0,0,0}
	hexaRGB = {string.sub(valor,5,6):upper(),string.sub(valor,7,8):upper(),string.sub(valor,9,10):upper()}
	for j=1,#hexaRGB do
		rgb[j] = tonumber("0x"..hexaRGB[j])
	end
	colorTXT[15] = color.new(rgb[3],rgb[2],rgb[1])
	colorAlpha[15] = color.new(rgb[3],rgb[2],rgb[1],100)
	colorAlpha2[15] = color.new(rgb[3],rgb[2],rgb[1],100)
	canalR = rgb[3]
	canalG = rgb[2]
	canalB = rgb[1]
end
function elementosBases()
	collectgarbage(restart)
	controls.read()
	protectorPantalla()
	if controls.press("hold") then
		screen.brightness(30)
		os.cpu(222)
	end
	if controls.release("hold") then
		screen.brightness(90)
		os.cpu(333)
	end
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
	olasOn()   
	Thora = os.date("%I:%M %p")
	screen.print(320,10,Thora,0.6,blanco,negro)
end
function cargaPlug()
	for plu=1,#TnamePlugins do
		if namePlug == TnamePlugins[plu]..".txt" then
			valorPlug = plu
			break
		end
	end
	if files.exists(memoSelect.."seplugins/"..namePlug) == false then
		txt = io.open(memoSelect.."seplugins/"..namePlug,"w")
		io.close(txt)
	end
	if instalPlug != nil and instalPlug != "" then
		txt = io.open(memoSelect.."seplugins/"..namePlug,"a")
		txt:write(instalPlug.." 1\n")
		io.close(txt)
		instalPlug = ""
	end   
	contador2 = 0
	tablaPlug = {}
	txt = io.open(memoSelect.."seplugins/"..namePlug,"r")
	for linea in io.lines(memoSelect.."seplugins/"..namePlug) do
		contador2 = contador2 + 1      
		a,b = linea:lower():find(".prx ")
		if a and b then
			tablaPlug[contador2] = {plugin=string.sub(linea,1,b),estado=string.sub(linea,b+1,b+1)}
		end
	end
	io.close(txt)       
end
function check_image_size(ruta)
local temp=io.open(ruta,"r")
local ext=temp:read(4)
 
if string.upper(ext)=="‰PNG" then
	local tmp=temp:read(12)
	local w_car=temp:read(4)
	local h_car=temp:read(4)
	local w_hexa="0x"
	local h_hexa="0x"
	for i=1,4 do
		w_hexa=w_hexa..string.format("%0x",string.byte(string.sub(w_car,i,i)))
		h_hexa=h_hexa..string.format("%0x",string.byte(string.sub(h_car,i,i)))
	end
	w=tonumber(string.format("%d",tonumber(w_hexa)))
	h=tonumber(string.format("%d",tonumber(h_hexa)))
elseif string.upper(string.sub(ext,1,3))=="GIF" then
	local tmp=temp:read(2)
	local w_car=temp:read(2)
	local h_car=temp:read(2)
	local w_hexa="0x"
	local h_hexa="0x"
	for i=2,1,-1 do
		w_hexa=w_hexa..string.format("%0x",string.byte(string.sub(w_car,i,i)))
		h_hexa=h_hexa..string.format("%0x",string.byte(string.sub(h_car,i,i)))
	end
	w=tonumber(string.format("%d",tonumber(w_hexa)))
	h=tonumber(string.format("%d",tonumber(h_hexa)))
end
 
temp:close()
return w,h
end
loadcallback = nil