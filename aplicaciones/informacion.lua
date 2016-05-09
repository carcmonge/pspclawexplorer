ibateria = {}

if batt.exists() then ibateria.exists = "Insertada" else ibateria.exists = "No hay bateria" end
if batt.charging() then ibateria.charging = "Si" else ibateria.charging = "No" end
if batt.islow() then ibateria.islow = "Bateria baja" else ibateria.islow = "Normal" end
ibateria.percent 		= batt.percent()
ibateria.time 			= batt.time()
ibateria.temp 			= batt.temp()
ibateria.volt 			= batt.volt()
inick 					= os.nick()
icpu 					= os.cpu()

ispace 					= {}
ispace.freespaceP 		= " ("..((math.ceil((files.freespace()/files.totalspace())*100*100)/100)-0.01).."%)"
ispace.freespace 		= files.sizeformat(files.freespace())..ispace.freespaceP
ispace.usespaceP 		= " ("..(math.ceil((((files.totalspace() - files.freespace())/files.totalspace())*100*100))/100).."%)"
ispace.usespace			= files.sizeformat(files.totalspace() - files.freespace())..ispace.usespaceP
ispace.totalspace 		= files.sizeformat(files.totalspace())

ispace.getinitmemory 	= files.sizeformat(os.getinitmemory())
ispace.getfreememoryP 	= " ("..(math.ceil((os.getfreememory()/ os.getinitmemory())*100*100)/100).."%)"
ispace.getfreememory 	= files.sizeformat(os.getfreememory())..ispace.getfreememoryP
ispace.getusememoryP 	= " ("..((math.ceil((os.getinitmemory() - os.getfreememory())/ os.getinitmemory()*100*100)/100)-0.01).."%)"
ispace.getusememory 	= files.sizeformat(os.getinitmemory() - os.getfreememory())..ispace.getusememoryP
numFiles = 0
numCarpetas = 0
sizeDic = 0
indiceCur = 1
loading("Analizando...")
pesoDir(memoSelect)
icarpetas = numFiles
iarchivos = numCarpetas

while true do
	elementosBases()
	screen.print(10,45,"Bateria: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("Bateria: "),45,ibateria.exists,0.7,blanco,negro)
	screen.print(10,60,"Fuente de alimentacion: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("Fuente de alimentacion: "),60,ibateria.charging,0.7,blanco,negro)
	screen.print(10,75,"Porcentaje de carga: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("Porcentaje de carga: "),75,ibateria.percent.."%",0.7,blanco,negro)
	screen.print(10,90,"Estado de carga: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("Estado de carga: "),90,ibateria.islow,0.7,blanco,negro)
	screen.print(10,105,"Tiempo de carga: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("Tiempo de carga: "),105,ibateria.time.." min",0.7,blanco,negro)
	screen.print(10,120,"Temperatura: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("Temperatura: "),120,ibateria.temp.." *C",0.7,blanco,negro)
	screen.print(10,135,"Voltaje: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("Voltaje: "),135,ibateria.volt.." V",0.7,blanco,negro)
	
	screen.print(10,165,"Nick: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("Nick: "),165,inick,0.7,blanco,negro)
	screen.print(10,180,"Velocidad de CPU: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("Velocidad de CPU: "),180,icpu,0.7,blanco,negro)

	screen.print(10,195,"RAM Total: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("RAM Total: "),195,ispace.getinitmemory,0.7,blanco,negro)
	screen.print(10,210,"RAM Usada: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("RAM usada: "),210,ispace.getusememory,0.7,blanco,negro)
	screen.print(10,225,"RAM Libre: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(10+screen.textwidth("RAM Libre: "),225,ispace.getfreememory,0.7,blanco,negro)
	draw.fillrect(10,240,100,10,blanco)
	draw.gradrect(10,240,((os.getinitmemory()-os.getfreememory())/os.getinitmemory())*100,10,colorAlpha[valorFondo],negro,colorAlpha[valorFondo],blanco)
	draw.rect(10,240,((os.getinitmemory()-os.getfreememory())/os.getinitmemory())*100,10,negro)
	draw.rect(10,240,100,10,negro)
	screen.print(115,240,ispace.getusememoryP ,0.7,blanco,colorTXT[valorFonte])
	
	screen.print(240,45,"Espacio Total: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(240+screen.textwidth("Espacio Total: "),45,ispace.totalspace,0.7,blanco,negro)
	screen.print(240,60,"Espacio Usada: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(240+screen.textwidth("Espacio usada: "),60,ispace.usespace,0.6,blanco,negro)
	screen.print(240,75,"Espacio Libre: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(240+screen.textwidth("Espacio Libre: "),75,ispace.freespace,0.6,blanco,negro)
	screen.print(240,90,"Numero de Carpetas: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(240+screen.textwidth("Numero de Carpetas: "),90,icarpetas,0.7,blanco,negro)
	screen.print(240,105,"Numero de Archivos: ",0.7,blanco,colorTXT[valorFonte])
	screen.print(240+screen.textwidth("Numero de Archivos: "),105,iarchivos,0.7,blanco,negro)
	draw.fillrect(240,120,100,10,blanco)
	draw.gradrect(240,120,((files.totalspace()-files.freespace())/files.totalspace())*100,10,colorAlpha[valorFondo],negro,colorAlpha[valorFondo],blanco)
	draw.rect(240,120,((files.totalspace()-files.freespace())/files.totalspace())*100,10,negro)
	draw.rect(240,120,100,10,negro)
	screen.print(355,120,ispace.usespaceP,0.7,blanco,colorTXT[valorFonte])
	screen.print(240,260,"Presiona el boton R para obtener un grafico de esta carpeta",0.6,blanco,negro,"center",480)
	if controls.press("circle") then
		break
	end
	if controls.press("r") then
		curDicT = files.list(memoSelect)
		curAux = ""
		table.sort(curDicT, sp)
		shell = false
		slideShellBool = false
		slideShell = 0
		infoGraf(memoSelect)
		bool_fondoTrans = false
		in_explorer = true
		break
	end
	screen.flip()
end