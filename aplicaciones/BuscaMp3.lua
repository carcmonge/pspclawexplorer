--[[
 * PSP Claw Explorer
 * Copyright 2016 Carlos Monge.
 * Licensed under MIT (https://github.com/carcmonge/pspclawexplorer/blob/master/LICENSE)
]]--
function escape(str)
	local nstr=""
	for i=1,#str do
		nstr=nstr.."%"..string.format("%0x",str:sub(i,i):byte())
	end
	return nstr
end

function get_url(artista, cancion)
	local q = escape(artista.." - "..cancion.."+site:"..SongServer[valorSeverSong].site)
	local res = http.get("http://www.google.com/search?q="..q,"tmp")
	if not res then return false,"ggl" end
	local arch = io.open("tmp","r")
	local txt = arch:read("*a")
	arch:close()
	resultados={}
	resultados[1] = {nom = "No Descargar",dir = nil}
	i = 2
    for  url,basura,name in string.gmatch(txt,SongServer[valorSeverSong].rex) do
		name = string.gsub(name,"<em>","")
		name = string.gsub(name,"</em>","")
		resultados[i] = {nom = name,dir = url}
		i = i +1
    end
	if #resultados <= 1 then 
		resultados={}
		resultados[1] = {nom = "No se encontraron resultados",dir = nil}
		return resultados
	end
	return resultados
end
function get_song(url)
	if not url then return "No se encontraron resultados" end
	res = http.get("http://dowint.net/?site=1&url="..url.."&download=Descargar","tmp")
	if not res then return nil, nil, nil, nil end

	arch = io.open("tmp","r")
	txt = arch:read("*a")
	arch:close()
	--files.remove("tmp")
	
	local name, size, urllivegoear = txt:match('id="namefile".-value="([^"]+).-Size:.-<td align="left">([^<]+).-id="descargar" href="([^"]+)')
	if not (name and size and urllivegoear) then return nil, nil, nil, nil end
	
	if (#urllivegoear==0 or size=='0 MB' or #name>100) then
		return nil, nil, nil, nil
	end
	return true, name, size, urllivegoear
end
function get_lyricURL(artista, cancion)
	local q = escape(artista.." - "..cancion.."+site:"..letraServer[valorSeverLetra].site)
	local res = http.get("http://www.google.com/search?q="..q,"tmp")
	if not res then return false, "No se encontraron resultados" end
	
	local arch = io.open("tmp","r")
	local txt = arch:read("*a")
	arch:close()
	--files.remove("tmp")
	resultados={}
	resultados[1] = {nom = "No Descargar",dir = nil}
	i = 2
    for  url,basura,name in string.gmatch(txt,letraServer[valorSeverLetra].rex) do
		name = string.gsub(name,"<em>","")
		name = string.gsub(name,"</em>","")
		resultados[i] = {nom = name,dir = url}
		i = i +1
    end
	if #resultados <= 1 then 
		resultados={}
		resultados[1] = {nom = "No se encontraron resultados",dir = nil}
		return resultados
	end
	return resultados
end
function get_tabURL(artista, cancion)
	local q = escape(artista.." - "..cancion.."+site:"..TabServer[valorSeverTab].site)
	local res = http.get("http://www.google.com/search?q="..q,"tmp")
	if not res then return false,"No se encontraron resultados" end
	local arch = io.open("tmp","r")
	local txt = arch:read("*a")
	arch:close()
	resultados={}
	resultados[1] = {nom = "No Descargar",dir = nil}
	i = 2
    for  url,basura,name in string.gmatch(txt,TabServer[valorSeverTab].rex) do
		name = string.gsub(name,"<em>","")
		name = string.gsub(name,"</em>","")
		resultados[i] = {nom = name,dir = url}
		i = i +1
    end
	if #resultados <= 1 then 
		resultados={}
		resultados[1] = {nom = "No se encontraron resultados",dir = nil}
		return resultados
	end
	return resultados
end
function save_lyric(url,name)
	res = http.get(url,"tmp")
	local arch = io.open("tmp","r")
	local txt = arch:read("*a")
	arch:close()         
	letra = txt:match(letraServer[valorSeverLetra].rex2)
	if not letra then return false end
	if letra then
		letra = string.gsub(letra,"<br />","\n")
		letra = string.gsub(letra,"<span>"," ")
		letra = string.gsub(letra,"</span>"," ")
		configuracion = io.open(memoSelect.."MUSIC/"..name..".txt","w")
		configuracion:write(letra)
		io.close(configuracion)
	end
end
function save_tab(url,name)
	res = http.get(url,"tmp")
	local arch = io.open("tmp","r")
	local txt = arch:read("*a")
	arch:close()
	t = {}
	i = 1
    for  v in string.gmatch(txt,TabServer[valorSeverTab].rex2) do
		t[i] = v
		i = i +1
    end
	if #t>0 then
		t[#t] = string.gsub(t[#t],"<br />","\n")
		t[#t] = string.gsub(t[#t],"<span>"," ")
		t[#t] = string.gsub(t[#t],"</span>"," ")
		configuracion = io.open(memoSelect.."MUSIC/tab_"..name..".txt","w")
		configuracion:write(t[#t])
		io.close(configuracion)
	end
end
VM = 1
numOpci = 6
artist = ""
song =  ""
valorSeverSong = 1
SongServer = {} 
SongServer[1] = {name="No",site="No",rex="No",rex2="No"} 
SongServer[2] = {name="Opcion #1",site="goear.com",rex='<a href="(http://www.goear.com/listen/.-)"(.-)>(.-)</a>',rex2='<pre>(.-)</pre>'} 

valorSeverLetra = 1
letraServer = {}   
letraServer[1] = {name="No",site="No",rex="No",rex2="No"} 
letraServer[2] = {name="Opcion #1",site="musica.com",rex='<a href="(http://www.musica.com/letras%.asp%?letra=.-)"(.-)>(.-)</a>',rex2='<font style=line%-height:20px;font%-size:14px;font%-family:arial,tahoma,verdana>(.-)</font>'} 
valorSeverTab = 1 
TabServer = {} 
TabServer[1] = {name="No",site="No",rex="No",rex2="No"} 
TabServer[2] = {name="Opcion #1",site="ultimate-guitar.com",rex='<a href="(http://tabs%.ultimate%-guitar%.com.-)"(.-)>(.-)</a>',rex2='<pre>(.-)</pre>'} 
TabServer[3] = {name="Opcion #2",site="lacuerda.net",rex='<a href="(http://lacuerda.net/tabs.-shtml)"(.-)>(.-)</a>',rex2='<PRE>(.-)</PRE>'} 

resSong = 1
resLetra = 1
resTab = 1
tableResS={}
tableResL={}
tableResT={}
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
				screen.print(70+(screen.textwidth("Servidor: ")),35,SongServer[valorSeverSong].name,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorSeverSong = navegador(false,false,true,true,valorSeverSong,#SongServer,1)
				end
			else
				screen.print(70,35,"Servidor: ",0.6,blanco,colorTXT[valorFonte])
				screen.print(70+(screen.textwidth("Servidor: ")),35,SongServer[valorSeverSong].name,0.6,blanco,negro)
			end
			
			if VM == 2 then
				screen.print(240,50,"Artista",0.6,blanco,AliceBlue,"center",480)
				draw.rect(72,65,360,20,blanco)
				screen.print(74,70,artist,0.6,blanco,AliceBlue)
				if controls.press("cross") then
					teclados(artist)
					artist = newName
				end
			else
				screen.print(240,50,"Artista",0.6,blanco,colorTXT[valorFonte],"center",480)
				draw.rect(72,65,360,20,negro)
				screen.print(74,70,artist,0.6,blanco,negro)
			end
			
			if VM == 3 then
				screen.print(240,90,"Cancion",0.6,blanco,AliceBlue,"center",480)
				screen.print(74,110,song,0.6,blanco,AliceBlue)
				draw.rect(72,105,360,20,blanco)
				if controls.press("cross") then
					teclados(song)
					song = newName
				end
			else  
				screen.print(240,90,"Cancion",0.6,blanco,colorTXT[valorFonte],"center",480)
				screen.print(74,110,song,0.6,blanco,negro)
				draw.rect(72,105,360,20,negro)
			end
			
			if VM == 4 then
				screen.print(70,135,"Server de la letra: ",0.6,blanco,AliceBlue)
				screen.print(70+(screen.textwidth("Server de la tablatura: ")),135,letraServer[valorSeverLetra].name,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorSeverLetra = navegador(false,false,true,true,valorSeverLetra,#letraServer,1)
				end
			else 
				screen.print(70,135,"Server de la letra: ",0.6,blanco,colorTXT[valorFonte])
				screen.print(70+(screen.textwidth("Server de la tablatura: ")),135,letraServer[valorSeverLetra].name,0.6,blanco,negro)
			end
			
			
			if VM == 5 then
				screen.print(70,155,"Server de la tablatura: ",0.6,blanco,AliceBlue)
				screen.print(70+(screen.textwidth("Server de la tablatura: ")),155,TabServer[valorSeverTab].name,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorSeverTab = navegador(false,false,true,true,valorSeverTab,#TabServer,1)
				end
			else 
				screen.print(70,155,"Server de la tablatura: ",0.6,blanco,colorTXT[valorFonte])
				screen.print(70+(screen.textwidth("Server de la tablatura: ")),155,TabServer[valorSeverTab].name,0.6,blanco,negro)

			end
			
			if VM == 6 then 
				screen.print(240,175,"Buscar",0.6,blanco,AliceBlue,"center",480)
				if controls.cross() and controls.wlan() then
					nombre,res,resL,resT,descargar,numOpci = nil,nil,nil,nil,false,6
					for i=1,3 do
						if wlan.connected() == false then
							conectado = wlan.init(con,conTime)
							if conectado then break end					
						end
					end
					if wlan.connected() then
						if valorSeverSong > 1 then 
							tableResS = get_url(artist,song)
						end
						if valorSeverLetra > 1 then 
							tableResL = get_lyricURL(artist,song)
						end
						if valorSeverTab > 1 then 
							tableResT = get_tabURL(artist,song)
						end
						descargar = true
					end
				elseif controls.press("cross") and controls.wlan() == false then
					os.message("Enciende el interruptor wlan")
				end
			else 
				screen.print(240,175,"Buscar",0.6,blanco,colorTXT[valorFonte],"center",480)
			end
	
	if descargar then
		numOpci = 11
		if nombre == "" or nombre == nil then nombre = artist.."-"..song end
		if #tableResS <= 0 then
			tableResS={}
			tableResS[1] = {nom = "No se encontraron resultados",dir = nil}		
		end
		if #tableResL <= 0 then
			tableResL={}
			tableResL[1] = {nom = "No se encontraron resultados",dir = nil}
		end
		if #tableResT <= 0 then
			tableResT={}
			tableResT[1] = {nom = "No se encontraron resultados",dir = nil}
		end
		if VM == 7 then
			screen.print(240,195,"Descargar",0.6,blanco,AliceBlue,"center",480)
				draw.line(0,190,480,190,blanco)
			if controls.press("cross") then
				if #listaDescarga <= 0 then
					if valorSeverSong > 1 and resSong > 1 then 
						res, nombre, tam, url_mp3 = get_song(tableResS[resSong].dir)
						if url_mp3 != nil then
							http.get(url_mp3,memoSelect.."MUSIC/"..nombre)
						end
					end
					if nombre == "" or nombre == nil then nombre = artist.."-"..song end
					if valorSeverLetra > 1 and resLetra > 1 then 
						save_lyric(tableResL[resLetra].dir,nombre)  
					end
					if valorSeverTab > 1 and resTab > 1 then 
						save_tab(tableResT[resTab].dir,nombre) 
					end
					os.message("Los archivos han sido guardados en la carpeta "..memoSelect.."MUSIC/")
				else
					for i = 1,#listaDescarga do
						if listaDescarga[i].urlS != nil then
							res, nombre, tam, url_mp3 = get_song(listaDescarga[i].urlS)
							if url_mp3 != nil then
								http.get(url_mp3,memoSelect.."MUSIC/"..nombre)
							end
						end
						if listaDescarga[i].urlL != nil then
							save_lyric(listaDescarga[i].urlL,nombre)
						end
						if listaDescarga[i].urlT != nil then
							save_tab(listaDescarga[i].urlT,nombre)
						end
					end
					os.message("Los archivos han sido guardados en tu memoria")
				end
				nombre,res,resL,resT,descargar,numOpci = nil,nil,nil,nil,false,6
			end
		else 
			screen.print(240,195,"Descargar",0.6,blanco,negro,"center",480)
		end
		
			if VM == 8 then
				screen.print(5,210,"Cancion: ",0.6,blanco,AliceBlue)
				screen.print(5+(screen.textwidth("Tablatura: ")),210,"("..(#tableResS-1)..") "..tableResS[resSong].nom,0.6,blanco,AliceBlue) 
				if controls.press("right") or controls.press("left") then
					resSong = navegador(false,false,true,true,resSong,#tableResS,1)
				end
			else 
				screen.print(5,210,"Cancion: ",0.6,blanco,colorTXT[valorFonte])
				screen.print(5+(screen.textwidth("Tablatura: ")),210,"("..(#tableResS-1)..") "..tableResS[resSong].nom,0.6,blanco,negro)
			end
			if VM == 9 then
				screen.print(5,225,"Letra: ",0.6,blanco,AliceBlue)
				screen.print(5+(screen.textwidth("Tablatura: ")),225,"("..(#tableResL-1)..") "..tableResL[resLetra].nom,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					resLetra = navegador(false,false,true,true,resLetra,#tableResL,1)
				end
			else 
				screen.print(5,225,"Letra: ",0.6,blanco,colorTXT[valorFonte])
				screen.print(5+(screen.textwidth("Tablatura: ")),225,"("..(#tableResL-1)..") "..tableResL[resLetra].nom,0.6,blanco,negro)

			end
			if VM == 10 then
				screen.print(5,240,"Tablatura: ",0.6,blanco,AliceBlue)
				screen.print(5+(screen.textwidth("Tablatura: ")),240,"("..(#tableResT-1)..") "..tableResT[resTab].nom,0.6,blanco,AliceBlue)		
				if controls.press("right") or controls.press("left") then
					resTab = navegador(false,false,true,true,resTab,#tableResT,1)
				end
			else 
				screen.print(5,240,"Tablatura: ",0.6,blanco,colorTXT[valorFonte])
				screen.print(5+(screen.textwidth("Tablatura: ")),240,"("..(#tableResT-1)..") "..tableResT[resTab].nom,0.6,blanco,negro)		
			end
			if VM == 11 then
				screen.print(240,260,"Añadir a Lista de Descarga: ("..#listaDescarga..")",0.6,blanco,AliceBlue,"center",480)
				if controls.press("cross") then
					for i = 1,#listaDescarga do
						if listaDescarga[i].urlS == tableResS[resSong].dir and listaDescarga[i].urlL == tableResL[resLetra].dir and listaDescarga[i].urlT == tableResT[resTab].dir then
							table.remove(listaDescarga,i)
						end
					end
					listaDescarga[#listaDescarga+1] = 
					{
					 nameS=tableResS[resSong].nom,urlS=tableResS[resSong].dir
					,nameL=tableResL[resLetra].nom,urlL=tableResL[resLetra].dir 
					,nameT=tableResT[resTab].nom,urlT=tableResT[resTab].dir
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
	screen.flip()
end