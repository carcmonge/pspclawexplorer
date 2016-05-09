function escape(str)
	local nstr=""
	for i=1,#str do
		nstr=nstr.."%"..string.format("%0x",str:sub(i,i):byte())
	end
	return nstr
end

function get_url(nombre)
	local q = escape(nombre.."+site:"..ImgServer[valorSeverImg].site)
	local res = http.get("http://www.google.com/search?q="..q,"tmp")
	if not res then return false,"ggl" end
	local arch = io.open("tmp","r")
	local txt = arch:read("*a")
	arch:close()
	resultados={}
	resultados[1] = {dir = nil,nom="No Descargar"}
	i = 2
    for  url,basura,name in string.gmatch(txt,ImgServer[valorSeverImg].rex) do
		name = string.gsub(name,"<em>","")
		name = string.gsub(name,"</em>","")
		name = string.gsub(name,"&#39;","'")
		name = string.gsub(name,"&lt;","<")
		url = string.gsub(url,"&#39;","'")
		url = string.gsub(url,"&lt;","<")
		resultados[i] = {dir = url,nom =name}
		i = i +1
    end
	if #resultados <= 1 then 
		resultados={}
		resultados[1] = {dir = nil,nom="No se encontraron resultados"}
		return resultados
	end
	return resultados
end
function saveImg(url)
	if valorSeverImg == 2 then
		url = url:match(ImgServer[valorSeverImg].rex2)
		nom = string.gsub(url,"_"," ")	
		url = string.gsub(url,"_","%%20")	
		http.get(ImgServer[valorSeverImg].rex3..url..".zip","ms0:/"..nom..".zip")
	elseif valorSeverImg == 3 then
		local res = http.get(url,"tmp")
		if not res then return false end
		local arch = io.open("tmp","r")
		local txt = arch:read("*a")
		arch:close()
		local res = {}
		i = 1
		for url in string.gmatch(txt,ImgServer[valorSeverImg].rex3) do
			res[i] = url
			i = i + 1
		end
		for i = 1,#res do
			local a = string.find(res[i],".zip")
			if a then
				numres = i
				break
			end
		end
		http.get("http://freeroms810.freeroms.com/gameboy_advance_roms/"..res[numres],"ms0:/"..res[numres])
	elseif valorSeverImg == 4 then
		local res = http.get(url,"tmp")
		if not res then return false end
		local arch = io.open("tmp","r")
		local txt = arch:read("*a")
		arch:close()
		local res = {}
		i = 1
		for url in string.gmatch(txt,ImgServer[valorSeverImg].rex3) do
			res[i] = url
			i = i + 1
		end
		for i = 1,#res do
			if string.find(res[i],"http://n64roms100.freeroms.com/n64-roms/d%+/") then
				server = res[i]
			end
			if string.find(res[i],".zip") then
				nombrezip = res[i]
			end
		end
		if not server or not nombrezip then return false end
		http.get(server..nombrezip,"ms0:/"..res[numres])
	end
	
end
VM = 1
numOpci = 3
nombeImg = ""
valorSeverImg = 1
ImgServer = {} 
ImgServer[1] = {name="No",site="No",rex="No",rex2="No"}                         
ImgServer[2] = {
	name="Super Nintendo",
	site="emuparadise.me/Super_Nintendo_Entertainment_System_(SNES)_ROMs",
	rex='<a href="(http://www%.emuparadise%.me/Super_Nintendo_Entertainment_System_%(SNES%)_ROMs/.-)"(.-)>(.-)</a>',
	rex2='http://www%.emuparadise%.me/Super_Nintendo_Entertainment_System_%(SNES%)_ROMs/(.-)/',
	rex3='http://phobos.emuparadise.org/120/Super%20Nintendo%20Roms/',
}
ImgServer[3] = {
	name="Gameboy Advance",
	site="freeroms.com/roms/gameboy_advance",
	rex='<a href="(http://www%.freeroms%.com/roms/gameboy_advance/.-)"(.-)>(.-)</a>',
	rex2='http://www%.emuparadise%.me/Nintendo_Gameboy_Advance_ROMs/(.-)/',
	rex3='server%d+="(.-)"'
}
--[[ImgServer[4] = {
	name="Nintendo 64",
	site="freeroms.com/roms/n64",
	rex='<a href="(http://www%.freeroms%.com/roms/n64/.-)"(.-)>(.-)</a>',
	rex2='http://www%.emuparadise%.me/Nintendo_Gameboy_Advance_ROMs/(.-)/',
	rex3='server%d+="(.-)"'
}
http://chrono.emuparadise.org/Gameboy%20Advance%20Roms/GBA%20Roms%201901%20-%202000/1986%20-%20Pokemon%20Emerald%20(U)(TrashMan).zip
http://chrono.emuparadise.org/Gameboy%20Advance%20Roms/GBA%20Roms%200901%20-%201000/0940%20-%20Golden%20Sun%202%20-%20The%20Lost%20Age%20(U)(Megaroms).zip 
http://chrono.emuparadise.org/Gameboy%20Advance%20Roms/GBA%20Roms%201401%20-%201500/1467%20-%20Digimon%20Racing%20(E)(Rising%20Sun).zip--]]
resImg = 1
tableResImg={}
listaDescarga={}
res = false
respuesta = "No se encontraron resultados"
x=10
os.message("La descarga de ciertos archivos como, musica, imagenes y rooms son legales, solo si posees la copia original de este. Si es asi puedes hacer uso de las descargas. Gracias por disfrutar las molestias.")
while true do
	elementosBases()
	VM = navegador(true,true,false,false,VM,numOpci,1)
	draw.line(0,190,480,190,negro)
	--image.fxtint(230,130,boton,colorTXT[valorFondo])
			if VM == 1  then
				screen.print(70,35,"Servidor: ",0.6,blanco,AliceBlue)
				screen.print(70+(screen.textwidth("Servidor: ")),35,ImgServer[valorSeverImg].name,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorSeverImg = navegador(false,false,true,true,valorSeverImg,#ImgServer,1)
				end
			else
				screen.print(70,35,"Servidor: ",0.6,blanco,colorTXT[valorFonte])
				screen.print(70+(screen.textwidth("Servidor: ")),35,ImgServer[valorSeverImg].name,0.6,blanco,negro)
			end
			
			if VM == 2 then
				screen.print(240,55,"Nombre de la Imagen",0.6,blanco,AliceBlue,"center",480)
				draw.rect(72,70,360,20,blanco)
				screen.print(74,75,nombeImg,0.6,blanco,AliceBlue)
				if controls.press("cross") then
					teclados(nombeImg)
					nombeImg = newName
				end
			else
				screen.print(240,55,"Nombre de la Imagen",0.6,blanco,colorTXT[valorFonte],"center",480)
				draw.rect(72,70,360,20,negro)
				screen.print(74,75,nombeImg,0.6,blanco,negro)
			end
			
			if VM == 3 then 
				screen.print(240,95,"Buscar",0.6,blanco,AliceBlue,"center",480)
				if controls.cross() and controls.wlan() then
					nombre,res,resL,resT,descargar,numOpci = nil,nil,nil,nil,false,6
					for i=1,3 do
						if wlan.connected() == false then 
							conectado = wlan.init(con,conTime)
							if conectado then break end					
						end
					end
					if wlan.connected() then
						if valorSeverImg > 1 then 
							tableResImg = get_url(nombeImg)
						end
						descargar = true
					elseif controls.press("cross") and controls.wlan() == false then
						os.message("Enciende el interruptor wlan")
					end
				elseif controls.press("cross") and controls.wlan() == false then
					os.message("Enciende el wlan D:")
				end
			else 
				screen.print(240,95,"Buscar",0.6,blanco,colorTXT[valorFonte],"center",480)
			end
	
	if descargar then
		numOpci = 6
		if #tableResImg <= 0 then
			tableResImg={}
			tableResImg[1] = {nom = "No se encontraron resultados",dir = nil}		
		end
		if VM == 4 then
			screen.print(240,195,"Descargar",0.6,blanco,AliceBlue,"center",480)
				draw.line(0,190,480,190,blanco)
			if controls.press("cross") then
				if #listaDescarga <= 0 then
					if valorSeverImg > 1 and resImg > 1 then 
						saveImg(tableResImg[resImg].dir)
					end
						os.message("Los archivos han sido guardados en el directorio "..memoSelect)
				else
					for i = 1,#listaDescarga do
						if listaDescarga[i].urlImg != nil then
							saveImg(listaDescarga[i].urlImg)
						end
					end
						os.message("Los archivos han sido guardados en el directorio "..memoSelect)
				end
				nombre,res,resL,resT,descargar,numOpci = nil,nil,nil,nil,false,6
			end
		else 
			screen.print(240,195,"Descargar",0.6,blanco,negro,"center",480)
		end
		
			if VM == 5 then
				screen.print(5,210,"Imagen: ",0.6,blanco,AliceBlue)
				screen.print(5+(screen.textwidth("Imagen: ")),210,"("..(#tableResImg-1)..") "..tableResImg[resImg].nom,0.6,blanco,AliceBlue) 
				if controls.press("right") or controls.press("left") then
					resImg = navegador(false,false,true,true,resImg,#tableResImg,1)
				end
			else 
				screen.print(5,210,"Imagen: ",0.6,blanco,colorTXT[valorFonte])
				screen.print(5+(screen.textwidth("Imagen: ")),210,"("..(#tableResImg-1)..") "..tableResImg[resImg].nom,0.6,blanco,negro)
			end
			if VM == 6 then
				screen.print(240,260,"Añadir a Lista de Descarga: ("..#listaDescarga..")",0.6,blanco,AliceBlue,"center",480)
				if controls.press("cross") then
					for i = 1,#listaDescarga do
						--if listaDescarga[i].urlS == tableResImg[resImg].dir and listaDescarga[i].urlL == tableResL[resLetra].dir and listaDescarga[i].urlT == tableResT[resTab].dir then
						--	table.remove(listaDescarga,i)
						--end
					end
					listaDescarga[#listaDescarga+1] = 
					{
					 nameImg=tableResImg[resImg].nom,urlImg=tableResImg[resImg].dir
					}
				end
			else 
				screen.print(240,260,"Añadir a Lista de Descarga: ("..#listaDescarga..")",0.6,blanco,negro,"center",480)
			end
	end
	if controls.press("circle") then
		if wlan.connected() then wlan.term() end
		break
	end
	--screen.print(10,5,tostring(wlan.connected()).." :B")
	screen.flip()
end