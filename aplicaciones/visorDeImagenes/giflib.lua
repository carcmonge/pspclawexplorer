------------------------- GIFLIB v2.7 - (c) 2011 Chimecho @ Gcrew - www.gcrew.es -------------------------
-- BUG: Si se carga un archivo muy grande o con muchos frames, la memoria RAM se drena
-- raminicial = os.getfreememory()

giflib = {}

function math.pow(x,y) -- función math.pow casera... ya que en algunos eboots está invertida ._.
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

function giflib.load(ruta) -- carga un gif animado y retorna una tabla con los frames y otra con la duración de cada frame en milisegundos
	local frames = {} -- cada frame tiene, duracion, sx, sy, w, h, disposal (por el momento, luego serán solo imágenes)
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
		size = tonumber(size) -- pasamos a número
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

	while not _21f9 do -- si no se encontró el GCE, buscar en cada par hasta encontrarlo
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
		disposal = tonumber(disposal) -- número
		
		local dur = gif:read(2)
		comienzo = comienzo..dur
		dur = _2b2n(dur) -- duración en segundos/100
		
		-- El byte del color transparente está presente si y sólo si, la bandera (flag) de color transparente es 1
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
		-- Tamaño de bytes a leer = 3x2^(Size of Local Color Table+1)
		
		local paleta = paletaglobal -- asignamos paletaglobal para trabajar este frame
		if packed:sub(1,1)=="1" then -- el primer bit es un flag, 1 -> tiene paleta local, 0 -> usar la global por default
			paleta = "" -- vaciar paleta
			size = packed:sub(-3) -- últimos 3 bits
			size = "0x"..bin2hex(size) -- pasamos a hexa en string...
			size = tonumber(size) -- pasamos a número...
			size = math.pow(2,size+1) -- colores a leer
			paleta = paleta..gif:read(3*size) -- leer paleta local (Local Color Table) (cada color 3 bytes, 3*size = bytes a leer)
			
			-- hay que actualizar el byte GCT para el nuevo gif
			GCT = "1" -- 1 bit, flag de paleta global
			GCT = GCT..GCTbin:sub(2,4) -- 3 bits, resolución de color (tomados del GCT original)
			GCT = GCT..packed:sub(3,3) -- 1 bit, flag de ordenamiento (tomado de la paleta local)
			GCT = GCT..packed:sub(-3) -- 3 bits, tamaño de la tabla de colores (tomado de la paleta local)
			GCT = "0x"..bin2hex(GCT) -- pasamos a hexa (string)
			GCT = tonumber(GCT) -- pasamos a número
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
	
	-- actualizar todos los frames (esto lleva su tiempo, temporal hasta que el blit a imagen esté pulido)
	cantframes = #frames
	
	nframes = {}
	if cantframes>0 then -- si tiene al menos un frame
		nframes[1] = image.create(wgif,hgif,0x0) -- crearlo
		nframes[1]:blit(0,0,frames[1].img) -- pintarlo
		frames[1].img:free() -- libreamos imagen
		frames[1] = nil -- la tabla del frame ya no existe
	end
	
	--[[ -- Actualizar según disposal:
			0 -	No disposal specified. The decoder is not required to take any action.
			1 - Do not dispose. The graphic is to be left in place.
			2 - Restore to background color. The area used by the graphic must be restored to the background color.
			3 - Restore to previous. The decoder is required to restore the area overwritten by the graphic with what was there prior to rendering the graphic.
			4-7 - To be defined.
		]]
	-- Usaré 1 para actualizar y el resto solo pintar el frame completo (por el momento)
	for i=2,cantframes do
		nframes[i] = image.create(wgif,hgif,0x0) -- creamos el frame actual
		if frames[i].disposal==1 then -- si el método es de actualización
			nframes[i]:blit(0,0,nframes[i-1]) -- colocamos el frame anterior
		end
		
		if frames[i].trcolor and frames[i].disposal==1 then -- si tiene un color transparente y es una actualización del siguiente frame then
			blitoimage(nframes[i],frames[i].img,frames[i].sx,frames[i].sy) -- <-- razón por la que demora...
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
	_2b_h = "0x"..string.format("%02X%02X",wgif:sub(2,2):byte(),wgif:sub(1,1):byte())
	return tonumber(_2b_h)
end


------------------------- HEXLIB v1 - (c) 2011 Chimecho @ Gcrew - www.gcrew.es -------------------------
-- facilidades de conversión hexadecimal a binario y viceversa

function sumBin(str) -- suma 1 a un número binario en string, añade bits en caso de ser necesario
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

function inithexlib() -- generar tablas de conversión
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