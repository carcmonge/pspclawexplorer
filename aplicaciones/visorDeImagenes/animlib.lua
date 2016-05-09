------------------------- ANIMLIB v4.7 - (c) 2011 Chimecho @ Gcrew - www.gcrew.es -------------------------
-- BUG: Si se carga un gif muy grande o con muchos frames, la memoria RAM se drena
-- raminicial = os.getfreememory()

anim = {}

function anim.createloadtable(rutaprefijo, inicio, fin, extension, cantcf)
	local tbl = {}
	local cantcf = cantcf
	if cantcf then cantcf = "%0"..cantcf.."d" -- si se definen cantidad de cifras, que todos sean de esa cantidad (Ej: cantcf = 2, 01 02 03 04 05 06.....)
	else cantcf = "%d" end -- sino, el n�mero tal cual (Ej: 1 2 3 4 5 6...)
	
	if inicio>fin then
		local tmp = inicio
		inicio = fin
		fin = tmp
	end
	
	for i = inicio, fin do
		table.insert(tbl, rutaprefijo..string.format(cantcf,i).."."..extension)
	end
	
	return tbl
end

function anim.refresh(obj)
	if obj.tim_act:time() >= obj.tim[obj.frame] then
		obj.tim_act:reset()
		obj.frame = obj.frame + 1
	end
	if obj.frame > obj.frames then obj.frame = 1 end
	obj.imgs[obj.frame]:rotate(obj.ang)
end

function anim.blit(obj,x,y,factor)
	anim.refresh(obj)
	obj.imgs[obj.frame]:factorscale(factor)
	local w = obj.imgs[obj.frame]:width()
	local h = obj.imgs[obj.frame]:height()
	obj.imgs[obj.frame]:center()
	obj.imgs[obj.frame]:blit(x+w/2,y+h/2)
end

function anim.fxtint(obj,x,y,color)
	anim.refresh(obj)
	local w = obj.imgs[obj.frame]:width()
	local h = obj.imgs[obj.frame]:height()
	image.fxtint(x+w/2,y+h/2,obj.imgs[obj.frame],color)
end

function anim.fxadd(obj,x,y,color)
	anim.refresh(obj)
	local w = obj.imgs[obj.frame]:width()
	local h = obj.imgs[obj.frame]:height()
	image.fxadd(x+w/2,y+h/2,obj.imgs[obj.frame],color)
end

function anim.fxsub(obj,x,y,color)
	anim.refresh(obj)
	local w = obj.imgs[obj.frame]:width()
	local h = obj.imgs[obj.frame]:height()
	image.fxsub(x+w/2,y+h/2,obj.imgs[obj.frame],color)
end

function anim.blend(obj,x,y,alfa)
	anim.refresh(obj)
	local w = obj.imgs[obj.frame]:width()
	local h = obj.imgs[obj.frame]:height()
	image.blend(x+w/2,y+h/2,obj.imgs[obj.frame],alfa)
end

function anim.setframe(obj,frame)
	obj.tim_act:reset()
	obj.frame = math.max(1,math.min(frame,obj.frames))
end

function anim.rotate(obj,ang)
	obj.ang = ang
end

function anim.start(obj)
	obj.tim_act:start()
	obj.stat = "run"
end

function anim.pause(obj)
	obj.tim_act:reset()
	obj.tim_act:stop()
	obj.stat = "stop"
end

function anim.reset(obj)
	obj.tim_act:reset()
	if obj.stat=="stop" or obj.stat=="end" then
		obj.tim_act:stop()
	end
	obj.frame = 1
end

function anim.currentframe(obj)
	return obj.frame
end

function anim.free(obj)
	for i=1,#obj.imgs do
		obj.imgs[i]:free()
	end
	obj.imgs = nil
	obj.tim = nil
end

function anim.create(imgs, w, h, tiempo)
	local tiempo = tiempo
	local args = 4
	if type(imgs)=="table" then tiempo = w; args = 2
	elseif type(imgs)=="string" and (not w) and (not h) and (not tiempo) then args = 1 end
	local tbltim = type(tiempo)=="table"
	
	animobj = {w=0, h=0, blit = anim.blit, fxtint = anim.fxtint, fxadd = anim.fxadd, fxsub = anim.fxsub, blend = anim.blend, rotate = anim.rotate, setframe = anim.setframe, start = anim.start, pause = anim.pause, reset = anim.reset, currentframe = anim.currentframe, free = anim.free, ang = 0, frame = 1, frames = 0, imgs = {}, tim = {}, tim_act = timer.new(), state="stop"}
	
	if args == 1 then -- anim.create(ruta) -- ruta de un gif... bwa ha ha ha ^^,
		animobj.imgs, animobj.tim = anim.loadgif(imgs) -- loadgif? >:D
	elseif args == 2 then -- anim.create(imgs,tiempo) -- tabla con imagenes o rutas o variadas, y tiempo entre cada cuadro
		for i=1,#imgs do
			if type(imgs[i])=="string" then -- si es una ruta
				animobj.imgs[i] = image.load(imgs[i]) -- cargar
			else -- supongo que es imagen
				animobj.imgs[i] = imgs[i] -- agregar
			end
			
			if tbltim then -- si los tiempos son una tabla
				animobj.tim[i] = tiempo[i] -- agrego el tiempo de ese frame
			else -- supongo que es un n�mero
				animobj.tim[i] = tiempo -- todos los frames la misma duraci�n
			end
		end
	elseif args == 4 then -- anim.create(spritesheet o ruta,w,h,tiempo) -- imagen precargada o ruta para cargar, ancho, alto, y tiempo entre cada cuadro
		if type(imgs) == "string" then
			imgs = image.load(imgs)
		end
		local indice = 1
		local cw = math.floor(imgs:realwidth()/w)
		local ch = math.floor(imgs:realheight()/h)
		for j=1,ch do
			for i = 1,cw do
				animobj.imgs[indice] = image.create(w,h,0x0)
				animobj.imgs[indice]:blit(0,0,imgs,(i-1)*w,(j-1)*h,w,h)
				if tbltim then -- si los tiempos son una tabla
					animobj.tim[indice] = tiempo[indice] -- agrego el tiempo de ese frame
				else -- supongo que es un n�mero
					animobj.tim[indice] = tiempo -- todos los frames la misma duraci�n
				end
				indice = indice + 1
			end
		end
		imgs:free()
	end
	
	animobj.w = animobj.imgs[1]:realwidth()
	animobj.h = animobj.imgs[1]:realheight()
	animobj.frames = #animobj.imgs
	animobj.tim_act:reset()
	animobj.tim_act:stop()
	return animobj
end


------------------------- GIFLIB v2.7 - (c) 2011 Chimecho @ Gcrew - www.gcrew.es -------------------------
-- Carga de gifs animados

function math.pow(x,y) -- funci�n math.pow casera... ya que en algunos eboots est� invertida ._.
	if x==0 then
		return 0
	elseif y==0 then
		return 1
	elseif y==1 then
		return x
	end
	
	res = x
	for i=2,y do
		res = res * x
	end
	return res
end

function anim.loadgif(ruta)  -- carga un gif animado y retorna una tabla con los frames y otra con la duraci�n de cada frame en milisegundos (ahora integrada a animlib)
	local frames = {} -- cada frame tiene, duracion, sx, sy, w, h, disposal (por el momento, luego ser�n solo im�genes)
	local durs = {} -- duraciones en milisegundos
	local gif = io.open(ruta,"r");
	local header = gif:read(6)
	local wgif = gif:read(2)
	local hgif = gif:read(2)
	local paletaglobal = ""
	local foo
	local GCT = gif:read(1)
	
	header = header..wgif..hgif
	header2 = gif:read(2) -- BG, RATIO
	
	local GCTbin = hex2bin(string.format("%02X",GCT:byte()))
	-- Global Color Table Flag		1 Bit
	-- Color Resolution				3 Bit
	-- Sort Flag					1 Bit
	-- Size of Global Color Table	3 Bit
	
	if GCTbin:sub(1,1) == "1" then -- si tiene GCT
		size = GCTbin:sub(-3) -- ultimos 3 bits
		size = "0x"..bin2hex(size) -- pasamos a hexa (string)
		size = tonumber(size) -- pasamos a n�mero
		size = math.pow(2,size+1) -- colores a leer
		paletaglobal = paletaglobal..gif:read(3*size) -- leer paleta global (Global Color Table) (cada color 3 bytes, 3*size = bytes a leer)
	end
	
	wgif = _2b2n(wgif)
	hgif = _2b2n(hgif)
	
	local _21f9 = false
	local fb, sb = gif:read(1), gif:read(1) -- 21 FF (Application Extension) o 21 F9 (Graphic Color extension)
	if sb == string.char(0xFF) then -- Application Extension
		foo = gif:read(12) -- .NETSCAPE2.0
	elseif sb == string.char(0xF9) then -- Graphic Color extension
		_21f9 = true
	end

	while not _21f9 do -- si no se encontr� el GCE, buscar en cada par hasta encontrarlo
		fb = sb
		sb = gif:read(1)
		if fb..sb==string.char(0x21)..string.char(0xF9) then
			_21f9 = true
		end
	end
	
	while true do
		local comienzo = string.char(0x21,0xF9)..gif:read(1)
		local tr = gif:read(1)
		comienzo = comienzo..tr
		
		local trbin = hex2bin(string.format("%02X",tr:byte()))
		-- Reserved						3 bits
		-- Disposal method				3 bits
		-- User input flag				1 bit
		-- Transparent color flag		1 bit
		
		local trcolor = false
		if trbin:sub(-1)=="1" then -- el bit menos significativo es un flag, 1 -> tiene color transparente, 0 -> no tiene color transparente
			trcolor = true
		end
		
		local disposal = trbin:sub(4,6) -- DDD (bin)
		disposal = "0x"..bin2hex(disposal) -- DDD (hex)
		disposal = tonumber(disposal) -- n�mero
		
		local dur = gif:read(2)
		comienzo = comienzo..dur
		dur = _2b2n(dur) -- duraci�n en segundos/100
		
		-- El byte del color transparente est� presente si y s�lo si, la bandera (flag) de color transparente es 1
		--if trcolor then -- entonces... el flag es 1?
			--comienzo = comienzo..gif:read(1) -- leer color transparente
		--end
		comienzo = comienzo..gif:read(3) -- fin, e Image Descriptor (2C)
		
		local sx = gif:read(2) -- coordenada de inicio en x
		local sy = gif:read(2) -- coordenada de inicio en y

		local sw = gif:read(2) -- ancho de este frame
		local sh = gif:read(2) -- alto de este frame

		comienzo = comienzo..sx..sy..sw..sh
		sx, sy, sw, sh = _2b2n(sx), _2b2n(sy), _2b2n(sw), _2b2n(sh)
		
		local fin = gif:read(1) -- aki hay un flag al inicio para saber si tiene una tabla de colores local
		comienzo = comienzo..string.char(0x00) -- no necesito que tenga tabla de colores local, es un solo frame...
		
		local packed = hex2bin(string.format("%02X",fin:byte()))
		-- Local Color Table Flag 		1 bit
		-- Interlace Flag		 		1 bit
		-- Sort Flag			 		1 bit
		-- Reserved				 		2 bit
		-- Size of Local Color Table	3 bit
		-- Tama�o de bytes a leer = 3x2^(Size of Local Color Table+1)
		
		local paleta = paletaglobal -- asignamos paletaglobal para trabajar este frame
		if packed:sub(1,1)=="1" then -- el primer bit es un flag, 1 -> tiene paleta local, 0 -> usar la global por default
			paleta = "" -- vaciar paleta
			size = packed:sub(-3) -- �ltimos 3 bits
			size = "0x"..bin2hex(size) -- pasamos a hexa en string...
			size = tonumber(size) -- pasamos a n�mero...
			size = math.pow(2,size+1) -- colores a leer
			paleta = paleta..gif:read(3*size) -- leer paleta local (Local Color Table) (cada color 3 bytes, 3*size = bytes a leer)
			
			-- hay que actualizar el byte GCT para el nuevo gif
			GCT = "1" -- 1 bit, flag de paleta global
			GCT = GCT..GCTbin:sub(2,4) -- 3 bits, resoluci�n de color (tomados del GCT original)
			GCT = GCT..packed:sub(3,3) -- 1 bit, flag de ordenamiento (tomado de la paleta local)
			GCT = GCT..packed:sub(-3) -- 3 bits, tama�o de la tabla de colores (tomado de la paleta local)
			GCT = "0x"..bin2hex(GCT) -- pasamos a hexa (string)
			GCT = tonumber(GCT) -- pasamos a n�mero
			GCT = string.char(GCT) -- pasamos a char (byte)
		end
		
		local minLWZsize = gif:read(1) -- LWZ min code size
		local toread = gif:read(1) -- cuantos bytes leer para este LWZ
		local medio = minLWZsize..toread
		
		toread = toread:byte()
		while toread>0 do -- todos los LWZ de este frame
			medio = medio..gif:read(toread)
			toread = gif:read(1) -- cuantos bytes leer
			medio = medio..toread
			toread = toread:byte()
		end
		
		local finalGif = header..GCT..header2..paleta..comienzo..medio..string.char(0x3B)
		table.insert(frames, {img = image.loadfrommemory(finalGif,"GIF"), sx = sx, sy = sy, w = sw, h = sh, trcolor = trcolor, disposal = disposal})
		table.insert(durs, dur*10)
		-- Por hacer: si os.getfreememory() < ???? then liberar todo, y mostrar que no se pudo cargar el gif
		
		local _1b = gif:read(1) -- 3B o 21 ?
		if _1b == string.char(0x3B) then -- fin del gif?
			break
		else -- no? esperemos q sea 21... sino, de seguro se cae xD
			gif:read(1) -- leer F9
		end
	end
	gif:close()
	
	-- actualizar todos los frames (esto lleva su tiempo, temporal hasta que el blit a imagen est� pulido)
	cantframes = #frames
	
	nframes = {}
	if cantframes>0 then -- si tiene al menos un frame
		nframes[1] = image.create(wgif,hgif,0x0) -- crearlo
		nframes[1]:blit(0,0,frames[1].img) -- pintarlo
		frames[1].img:free() -- libreamos imagen
		frames[1] = nil -- la tabla del frame ya no existe
	end
	
	--[[ -- Actualizar seg�n disposal:
			0 -	No disposal specified. The decoder is not required to take any action.
			1 - Do not dispose. The graphic is to be left in place.
			2 - Restore to background color. The area used by the graphic must be restored to the background color.
			3 - Restore to previous. The decoder is required to restore the area overwritten by the graphic with what was there prior to rendering the graphic.
			4-7 - To be defined.
		]]
	-- Usar� 1 para actualizar y el resto solo pintar el frame completo (por el momento)
	for i=2,cantframes do
		nframes[i] = image.create(wgif,hgif,0x0) -- creamos el frame actual
		if frames[i].disposal==1 then -- si el m�todo es de actualizaci�n
			nframes[i]:blit(0,0,nframes[i-1]) -- colocamos el frame anterior
		end
		
		if frames[i].trcolor and frames[i].disposal==1 then -- si tiene un color transparente y es una actualizaci�n del siguiente frame then
			blitoimage(nframes[i],frames[i].img,frames[i].sx,frames[i].sy) -- <-- raz�n por la que demora...
		else -- si no tiene un color transparente
			nframes[i]:blit(frames[i].sx,frames[i].sy,frames[i].img) -- blit normal a imagen
		end
		
		frames[i].img:free() -- libreamos el frame ya bliteado
		frames[i] = nil -- la tabla del frame ya no existe
	end
	frames = nil
	
	collectgarbage() -- me pude haber dejado algo...
	
	return nframes, durs
end

function blitoimage(des,ori,sx,sy) -- blit a imagen, saltar colores transparentes al 100%
	for j=0,ori:height()-1 do
		for i=0,ori:width()-1 do
			c = ori:pixel(i,j)
			if color.A(c) > 0 then
				des:pixel(i+sx,j+sy,c)
			end
		end
	end
end

function _2b2n(_2b) -- 2 bytes to number (Ej: de 45 01 a 325)
	_2b_h = "0x"..string.format("%02X%02X", _2b:sub(2,2):byte(), _2b:sub(1,1):byte())
	return tonumber(_2b_h)
end


------------------------- HEXLIB v1 - (c) 2011 Chimecho @ Gcrew - www.gcrew.es -------------------------
-- facilidades de conversi�n hexadecimal a binario y viceversa

function sumBin(str) -- suma 1 a un n�mero binario en string, a�ade bits en caso de ser necesario
    newstr = ""
    llevo = 1
    start = #str
    while llevo==1 or start>0 do
        i = start

        if i>=1 then
            car = str:sub(i,i)
        else
            car = "0"
        end

        res = tonumber(car)+llevo
        add = 0
        if res==2 then
            llevo = 1
        elseif res==1 then
            llevo = 0
            add = 1
        end
        newstr = add..newstr
        start = start - 1
    end
    
    for i=4-#newstr,1,-1 do
        newstr = "0"..newstr
    end

    return newstr
end

function hex2bin(hexstr) -- de hexa a binario
	binstr = ""
	for i=1,#hexstr do
		binstr = binstr..tblH2B[hexstr:sub(i,i):upper()]
	end
	return binstr
end

function bin2hex(binstr) -- de binario a hexa
	hexstr = ""
	p4 = #binstr/4

	while math.floor(p4)~=p4 do
		binstr = "0"..binstr
		p4 = #binstr/4
	end
	for i=1,p4 do
		act = (i-1)*4+1
		hexstr = hexstr..tblB2H[binstr:sub(act,act+3)]
	end
	return hexstr
end

function inithexlib() -- generar tablas de conversi�n
	tblH2B = {}
	tblB2H = {}
	hex = "0123456789ABCDEF"
	actBin = "0000"
	for i=1,#hex do
		rawset(tblH2B,hex:sub(i,i),actBin)
		rawset(tblB2H,actBin,hex:sub(i,i))
		actBin = sumBin(actBin)
	end
end

inithexlib() -- inicializar HexLib