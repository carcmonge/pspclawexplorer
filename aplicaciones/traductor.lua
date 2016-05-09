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
function get_word(idioma,traduccion,palabra)
	local res = http.get("http://translate.reference.com/translate?query="..escape(palabra).."&src="..idioma.."&dst="..traduccion.."&v=1.0","tmp")

	if not res then return false,"ggl" end
	local arch = io.open("tmp","r")
	local txt = arch:read("*a")
	arch:close()
	local url = txt:match('<textarea  id="tabr1" name="text2" readonly="readonly">(.-)</textarea>')
	if url then
		return url
	else
		url = txt:match('<div id="content" class="PD_10">(.-)</div>')
	end 
	--files.remove("tmp")
	if url then
		return url
	else
		return "Intentelo de nuevo"
	end
end
VM = 1
numOpci = 5
word = ""
word_trac = ""
idiomasGoogle={"en","es"}
idiomasGoogleName={"English","Spanish"}
idioma1 = 1
idioma2 = 2
multi = 1
res = false
while true do
	elementosBases()
	VM = navegador(true,true,false,false,VM,numOpci,1)
	screen.print(73,60,word,0.7,blanco,negro)
	draw.rect(72,55,360,20,negro)
	draw.line(0,145,480,145,negro)
	if multi == 1 then
		screen.print(5,10,"Ingles - Español")
	else
		screen.print(5,10,"Multi - Idiomas")
	end
	screen.print(5,170,idiomasGoogleName[idioma1]..": ",0.6,blanco,colorTXT[valorFonte])
	screen.print(5+(screen.textwidth(idiomasGoogleName[idioma1]..": ")),170,word,0.6,blanco,negro)
	screen.print(5,185,idiomasGoogleName[idioma2]..": ",0.6,blanco,colorTXT[valorFonte])
	screen.print(5+(screen.textwidth(idiomasGoogleName[idioma2]..": ")),185,word_trac,0.6,blanco,negro)
	if VM == 1 then
		screen.print(240,40,"Frase o Palabra",0.6,blanco,AliceBlue,"center",480)
		if controls.press("cross") then
			teclados(word)
			word = newName
		end
	else
		screen.print(240,40,"Frase o Palabra",0.6,blanco,colorTXT[valorFonte],"center",480)
	end
			
	if VM == 2 then
		screen.print(70,90,"("..#idiomasGoogle..") Del: ",0.6,blanco,AliceBlue)
		screen.print(70+(screen.textwidth("("..#idiomasGoogle..") Del: ")),90,idiomasGoogleName[idioma1],0.6,blanco,AliceBlue)
		if controls.press("right") or controls.press("left") then
			idioma1 = navegador(false,false,true,true,idioma1,#idiomasGoogle,1)
			word_trac = ""
		end
	else  
		screen.print(70,90,"("..#idiomasGoogle..") Del: ",0.6,blanco,colorTXT[valorFonte])
		screen.print(70+(screen.textwidth("("..#idiomasGoogle..") Del: ")),90,idiomasGoogleName[idioma1],0.6,blanco,negro)
	end
			
	if VM == 3 then
		screen.print(70,110,"("..#idiomasGoogle..") Al: ",0.6,blanco,AliceBlue)
		screen.print(70+(screen.textwidth("("..#idiomasGoogle..") Del: ")),110,idiomasGoogleName[idioma2],0.6,blanco,AliceBlue)
		if controls.press("right") or controls.press("left") then
			idioma2 = navegador(false,false,true,true,idioma2,#idiomasGoogle,1)
			word_trac = ""
		end
	else 
		screen.print(70,110,"("..#idiomasGoogle..") Al: ",0.6,blanco,colorTXT[valorFonte])
		screen.print(70+(screen.textwidth("("..#idiomasGoogle..") Del: ")),110,idiomasGoogleName[idioma2],0.6,blanco,negro)	
	end		
	if VM == 4 then
		screen.print(240,130,"Traducir",0.6,blanco,AliceBlue,"center",480)
		if controls.press("cross") then
			for i=1,3 do
				if wlan.connected() == false then 
					wlan.init(con,conTime)
					if wlan.connected() then break end					
				end
			end
			if wlan.connected() then
				word_trac = get_word(idiomasGoogle[idioma1],idiomasGoogle[idioma2],word)
			elseif controls.press("cross") and controls.wlan() == false then
				os.message("Enciende el interruptor wlan")
			end
		end
	else
		screen.print(240,130,"Traducir",0.6,blanco,negro,"center",480)
	end
	if VM == 5 then
		screen.print(240,155,"Guardar",0.6,blanco,AliceBlue,"center",480)
		draw.line(0,145,480,145,blanco)
		if controls.press("cross") then
			teclados()
			nameTras = newName
			txtTras = io.open(memoSelect..nameTras..".txt","w")
			txtTras:write(idiomasGoogleName[idioma1]..": "..word.."\n"..idiomasGoogleName[idioma2]..": "..word_trac)
			io.close(txtTras)
			os.message("El archivo ha sido guardado en el directorio "..memoSelect)
		end
	else
		screen.print(240,155,"Guardar",0.6,blanco,negro,"center",480)
	end
	if controls.press("circle") then
		wlan.term()
		break
	end
	if controls.press("r") or controls.press("l") then
		multi = multi + 1 
		if multi == 3 then multi = 1 end
		if multi == 1 then
			idiomasGoogle={"en","es"}
			idiomasGoogleName={"English","Spanish"}
		else
			idiomasGoogle={"af","sq","ar","be","bg","ca","zh-CN","hr","cs","da","nl","en","et","tl","fi","fr","gl","de","el","ht","iw","hi","hu","is","id","ga","it","ja","ko","lv","lt","mk","ms","mt","no","fa","pl","pt","pt-PT","ro","ru","sr","sl","es","sw","sv","tl","th","tr","uk","vi","cy","yi"}
			idiomasGoogleName={"Afrikaans","Albanian","Arabic","Belarusian","Bulgarian","Catalan","Chinese","Croatian","Czech","Danish","Dutch","English","Estonian","Filipino","Finnish","French","Galician","German","Greek","Haitian Creole","Hebrew","Hindi","Hungarian","Icelandic","Indonesian","Irish","Italian","Japanese","Korean","Latvian","Lithuanian","Macedonian","Malay","Maltese","Norwegian","Persian","Polish","Portuguese","Portuguese(Portugal)","Romanian","Russian","Serbian","Slovenian","Spanish","Swahili","Swedish","Tagalog","Thai","Turkish","Ukrainian","Vietnamese","Welsh","Yiddish"}
		end
	end
	screen.flip()
end