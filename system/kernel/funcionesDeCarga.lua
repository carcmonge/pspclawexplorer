	function iconos(opcion)
		if opcion == "cargar" then
			ico 			= {}
			ico.carpeta		= image.load(RutaDelTemaIconos[1].."carpetaICO.png")
			ico.file		= image.load(RutaDelTemaIconos[1].."fileICO.png")
			ico.mp3			= image.load(RutaDelTemaIconos[1].."mp3ICO.png")
			ico.image		= image.load(RutaDelTemaIconos[1].."imagenICO.png")
			ico.html		= image.load(RutaDelTemaIconos[1].."htmlICO.png")
			ico.eboot		= image.load(RutaDelTemaIconos[1].."ebootICO.png")
			ico.zip         = image.load(RutaDelTemaIconos[1].."zipICO.png")
			ico.rar         = image.load(RutaDelTemaIconos[1].."rarICO.png")
			ico.txt         = image.load(RutaDelTemaIconos[1].."txt.png")     
			ico.iso         = image.load(RutaDelTemaIconos[1].."iso.png")
			ico.obj         = image.load(RutaDelTemaIconos[1].."obj.png")
			ico.cso         = image.load(RutaDelTemaIconos[1].."cso.png")      
			ico.plug		= image.load(RutaDelTemaIconos[1].."plug.png")
		elseif opcion == "liberar" then
			ico.carpeta:free();
			ico.file:free();
			ico.mp3:free();
			ico.image:free();
			ico.html:free();
			ico.eboot:free();
			ico.zip:free();
			ico.rar:free();
			ico.txt:free();     
			ico.iso:free();
			ico.obj:free();
			ico.cso:free();
			ico.plug:free();
			ico = {}
			collectgarbage("collect")
		end
	end
	function LiveArenaIconos(opcion)
		if opcion == "cargar" then
			shelli = {}
			shelli["11"]={ico = image.load(RutaDelTemaArena[tema].."explorador.png"),name = "Explorador de Archivos"}
			shelli["21"]={ico = image.load(RutaDelTemaArena[tema].."buscador.png"),name = "Buscar"}
			shelli["31"]={ico = image.load(RutaDelTemaArena[tema].."traductor.png"),name = "Traductor"}
			shelli["41"]={ico = image.load(RutaDelTemaArena[tema].."DescargarMusica.png"),name = "Descargar Musica"}
			shelli["51"]={ico = image.load(RutaDelTemaArena[tema].."paleta.png"),name = "Paleta de Colores"}
			shelli["12"]={ico = image.load(RutaDelTemaArena[tema].."informacion.png"),name = "Informacion"}
			shelli["22"]={ico = image.load(RutaDelTemaArena[tema].."wikipedia.png"),	name = "Wikipedia"}
			shelli["32"]={ico = image.load(RutaDelTemaArena[tema].."configuracion.png"),name = "Configuracion"}
			shelli["42"]={ico = image.load(RutaDelTemaArena[tema].."juego.png"),name = "Descargar Rooms"}
			shelli["52"]={ico = image.load(RutaDelTemaArena[tema].."DescargarImagenes.png"),name = "Descargar Imagenes"}
			shelli["13"]={ico = image.load(RutaDelTemaArena[tema].."plugin.png"),name = "Plugins"}
			shelli["23"]={ico = image.load(RutaDelTemaArena[tema].."pspcc.png"),name = "PSP Claw Cleaner"}
			shelli["33"]={ico = image.load(RutaDelTemaArena[tema].."paint.png"),name = "Paint"}
			shelli["43"]={ico = image.load(RutaDelTemaArena[tema].."reproductor.png"),name = "Reproductor"}
			shelli["53"]={ico = image.load(RutaDelTemaArena[tema].."camara.png"),name = "Camara"}
			shellExplor=shelli["51"].ico
		elseif opcion == "liberar" then
			shelli["11"].ico:free();
			shelli["21"].ico:free();
			shelli["31"].ico:free();
			shelli["41"].ico:free();
			shelli["51"].ico:free();
			shelli["12"].ico:free();
			shelli["22"].ico:free();
			shelli["32"].ico:free();
			shelli["42"].ico:free();
			shelli["52"].ico:free();
			shelli["13"].ico:free();
			shelli["23"].ico:free();
			shelli["33"].ico:free();
			shelli["43"].ico:free();
			shelli["53"].ico:free();
			shelli = {}
			collectgarbage("collect")
		end
	end
	function reproductorIconos(opcion)
		if opcion == "cargar" then
				reproductor 					= {}
				reproductor.notaICO				= image.load("./aplicaciones/reproductor/notaMusical.png")
				reproductor.numeroDePistaICO	= image.load("./aplicaciones/reproductor/numPista.png")
				reproductor.pauseICO			= image.load("./aplicaciones/reproductor/pause.png") 
				reproductor.playICO				= image.load("./aplicaciones/reproductor/play.png")
				reproductor.icoPlay       		= reproductor.playICO
				reproductor.adelanteICO			= image.load("./aplicaciones/reproductor/adelante.png") 
				reproductor.atrasICO			= image.load("./aplicaciones/reproductor/atras.png")
				reproductor.pauseICO			= image.load("./aplicaciones/reproductor/pause.png")
				reproductor.stopICO				= image.load("./aplicaciones/reproductor/stop.png")
		elseif opcion == "liberar" then
				reproductor.notaICO:free();
				reproductor.numeroDePistaICO:free();
				reproductor.pauseICO:free();
				reproductor.icoPlay:free();
				reproductor.playICO:free();
				reproductor.adelanteICO:free();
				reproductor.atrasICO:free();
				reproductor.pauseICO:free();
				reproductor.stopICO:free();
				reproductor = {}
			collectgarbage("collect")
		end
	end
	function VisorDeImagenesIconos(opcion)
		if opcion == "cargar" then
				visorDeImagenes = {}
				visorDeImagenes.zoomMas				= image.load("./aplicaciones/visorDeImagenes/menuMas.png")
				visorDeImagenes.zoomMenos			= image.load("./aplicaciones/visorDeImagenes/menuMenos.png")
				visorDeImagenes.zoomCancel			= image.load("./aplicaciones/visorDeImagenes/menuCancel.png")
				visorDeImagenes.rotateLeft			= image.load("./aplicaciones/visorDeImagenes/rotateI.png")
				visorDeImagenes.rotateRight			= image.load("./aplicaciones/visorDeImagenes/rotateD.png")
				visorDeImagenes.direccionUp			= image.load("./aplicaciones/visorDeImagenes/DezA.png")
				visorDeImagenes.direccionDown		= image.load("./aplicaciones/visorDeImagenes/DezAb.png")
				visorDeImagenes.direccionLeft		= image.load("./aplicaciones/visorDeImagenes/DezI.png")
				visorDeImagenes.direccionRight		= image.load("./aplicaciones/visorDeImagenes/DezDe.png")
				visorDeImagenes.InformacionDeImagen	= image.load("./aplicaciones/visorDeImagenes/infoIMG.png")
		elseif opcion == "liberar" then
				visorDeImagenes.zoomMas:free();
				visorDeImagenes.zoomMenos:free();
				visorDeImagenes.zoomCancel:free();
				visorDeImagenes.rotateLeft:free();
				visorDeImagenes.rotateRight:free();
				visorDeImagenes.direccionUp:free();
				visorDeImagenes.direccionDown:free();
				visorDeImagenes.direccionLeft:free();
				visorDeImagenes.direccionRight:free();
				visorDeImagenes.InformacionDeImagen:free();
				visorDeImagenes = {}
			collectgarbage("collect")
		end
	end

--[[		
   colorICO			= image.load("./recursos/color.png")   

   dofile("teclado.lua")
dofile("Danzeff.lua")
--]]