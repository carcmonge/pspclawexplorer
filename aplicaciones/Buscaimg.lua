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
	res = http.get(url,"tmp")
	local arch = io.open("tmp","r")
	local txt = arch:read("*a")
	arch:close()
	if valorSeverImg == 2 then
		basura,img,nameImg = txt:match(ImgServer[valorSeverImg].rex2)
	elseif valorSeverImg == 3 then
		img = txt:match(ImgServer[valorSeverImg].rex2)
		while true do
			controls.read()
			screen.print(10,15,tostring(img))
			screen.flip()
			if controls.press("start") then
				break
			end
		end
	end
	
	if not img then return false end
	if img then
		if not files.ext(nameImg) and valorSeverImg == 2 then
			nameImg = nameImg..".jpg"
		elseif valorSeverImg == 3 then
			nameImg = "foto.jpg"
		end
		http.get(img,memoSelect.."PICTURE/"..nameImg)
	end
end
VM = 1
numOpci = 3
nombeImg = ""
valorSeverImg = 1
ImgServer = {} 
ImgServer[1] = {name="No",site="No",rex="No",rex2="No"}                         
ImgServer[2] = {name="Opcion #1",site="everystockphoto.com",rex='<a href="(http://www%.everystockphoto%.com/photo%.php%?imageId=.-)"(.-)>(.-)</a>',rex2='<img class="draggable"(.-)src="(http://s3.amazonaws.com/.-)" title="(.-)"'} 
--ImgServer[3] = {name="www.flickr.com",site="flickr.com",rex='<a href="(http://www%.flickr%.com/photos/%a+/%d+/.-)"(.-)>(.-)</a>',rex2='<div class="photo%-div">(.-)src="(.-)"(.-)<div>'} 

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
				screen.print(70,30,"Servidor: ",0.6,blanco,AliceBlue)
				screen.print(70+(screen.textwidth("Servidor: ")),30,ImgServer[valorSeverImg].name,0.6,blanco,AliceBlue)
				if controls.press("right") or controls.press("left") then
					valorSeverImg = navegador(false,false,true,true,valorSeverImg,#ImgServer,1)
				end
			else
				screen.print(70,30,"Servidor: ",0.6,blanco,colorTXT[valorFonte])
				screen.print(70+(screen.textwidth("Servidor: ")),30,ImgServer[valorSeverImg].name,0.6,blanco,negro)
			end
			
			if VM == 2 then
				screen.print(240,50,"Nombre de la Imagen",0.6,blanco,AliceBlue,"center",480)
				draw.rect(72,65,360,20,blanco)
				screen.print(74,70,nombeImg,0.6,blanco,AliceBlue)
				if controls.press("cross") then
					teclados(nombeImg)
					nombeImg = newName
				end
			else
				screen.print(240,50,"Nombre de la Imagen",0.6,blanco,colorTXT[valorFonte],"center",480)
				draw.rect(72,65,360,20,negro)
				screen.print(74,70,nombeImg,0.6,blanco,negro)
			end
			
			if VM == 3 then 
				screen.print(240,90,"Buscar",0.6,blanco,AliceBlue,"center",480)
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
				screen.print(240,90,"Buscar",0.6,blanco,colorTXT[valorFonte],"center",480)
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
					os.message("Los archivos han sido guardados en la carpeta "..memoSelect.."PICTURE/")
				else
					for i = 1,#listaDescarga do
						if listaDescarga[i].urlImg != nil then
							saveImg(listaDescarga[i].urlImg)
						end
					end
					os.message("Los archivos han sido guardados en la carpeta "..memoSelect.."PICTURE/")
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