--[[
 * Danzeff
 * Autor: chimecho
]]--
keys_sel = image.load("Danzeff/keys_sel.png")
keys_may_sel = image.load("Danzeff/keys_may_sel.png")

nums_sel = image.load("Danzeff/nums_sel.png")
nums_may_sel = image.load("Danzeff/nums_may_sel.png")

danz={}
danz[1]={{image.load("Danzeff/keys.png"),{}},{image.load("Danzeff/keys_may.png"),{}}}
danz[2]={{image.load("Danzeff/nums.png"),{}},{image.load("Danzeff/nums_may.png"),{}}}

for j=1,3 do
	danz[1][1][2][j]={}
	danz[1][2][2][j]={}
	danz[2][1][2][j]={}
	danz[2][2][2][j]={}
	for i=1,3 do
		danz[1][1][2][j][i]=image.create(35,35)
		danz[1][1][2][j][i]:blit(0,0,keys_sel,(i-1)*35,(j-1)*35,35,35)
		danz[1][2][2][j][i]=image.create(35,35)
		danz[1][2][2][j][i]:blit(0,0,keys_may_sel,(i-1)*35,(j-1)*35,35,35)
		danz[2][1][2][j][i]=image.create(35,35)
		danz[2][1][2][j][i]:blit(0,0,nums_sel,(i-1)*35,(j-1)*35,35,35)
		danz[2][2][2][j][i]=image.create(35,35)
		danz[2][2][2][j][i]:blit(0,0,nums_may_sel,(i-1)*35,(j-1)*35,35,35)
	end
end

keys_sel:free()
keys_may_sel:free()

nums_sel:free()
nums_may_sel:free()

estado=1
may=1

teclas={}
teclas[1]=",acb.dfe!gih-jlkªmn ?oqp(rts:uwv)xzy"
teclas[2]='^ACB@DFE*GIH_JLKªMN "OQP=RTS;UWV/XZY'
teclas[3]="ºº1ººº2ººº3ººº4ºªº5 ºº6ººº7ººº8ººº90"
teclas[4]=",().\"<>'-[]_!{}?ªºº +\\/=:@#;~$%`*^&|"

letras={}
letras[1]={{},{}}
letras[2]={{},{}}

pos=0
for j=1,3 do
letras[1][1][j]={}
letras[1][2][j]={}
letras[2][1][j]={}
letras[2][2][j]={}
	for i=1,3 do
		letras[1][1][j][i]={}
		letras[1][2][j][i]={}
		letras[2][1][j][i]={}
		letras[2][2][j][i]={}
		for p=1,4 do
			letras[1][1][j][i][p]=string.sub(teclas[1],p+(pos*4),p+(pos*4))
			letras[1][2][j][i][p]=string.sub(teclas[2],p+(pos*4),p+(pos*4))
			letras[2][1][j][i][p]=string.sub(teclas[3],p+(pos*4),p+(pos*4))
			letras[2][2][j][i][p]=string.sub(teclas[4],p+(pos*4),p+(pos*4))
		end
	pos=pos+1
	end
end

buffer=""
cur_stat=1
function danzeff(x,y,max_l,v)
	local cap = screen.toimage()
	buffer = v
	if valorTeclado == 3 then
		tipomouse = "digital"
	else
		tipomouse = "analogo"
	end
	while true do
		if not max_l then max_l = 0 end
		local block={x=2,y=2}
		local let=""
		controls.read()
		cap:blit(0,0)
		draw.gradrect(0,0,480,272,colorAlpha[1],colorAlpha[1],negro,negro)
		draw.rect(50,45,360,20,blanco)
		if controls.l() and controls.r() then
			buffer=""
		end
		if controls.l() then
			may=2
		else
			may=1
		end
		if controls.press("r") then
			if estado==1 then
				estado=2
			else
				estado=1
			end
		end
		if tipomouse=="analogo" then
			if controls.analogy()<=-60 then
				block.y=1
			elseif controls.analogy()>=60 then
				block.y=3
			end

			if controls.analogx()<=-60 then
				block.x=1
			elseif controls.analogx()>=60 then
				block.x=3
			end
		elseif tipomouse=="digital" then
			if controls.up() then
				block.y=1
			elseif controls.down() then
				block.y=3
			end
			
			if controls.left() then
				block.x=1
			elseif controls.right() then
				block.x=3
			end
		end
		if controls.press("triangle") then
			let=letras[estado][may][block.y][block.x][1]
		elseif controls.press("square") then
			let=letras[estado][may][block.y][block.x][2]
		elseif controls.press("circle") then
			let=letras[estado][may][block.y][block.x][3]
		elseif controls.press("cross") then
			let=letras[estado][may][block.y][block.x][4]
		end
		if let=="ª" then
			buffer=string.sub(buffer,1,string.len(buffer)-1)
		elseif let~="º" then
			buffer=buffer..let
		end

		if max_l~=0 then
			if string.len(buffer)>max_l then
				buffer=string.sub(buffer,1,max_l)
			end
		end
		screen.print(51,50,buffer.."|")
		danz[estado][may][1]:blit(x,y)
		danz[estado][may][2][block.y][block.x]:blit(x+((block.x-1)*35),y+((block.y-1)*35))
		screen.flip()
		if controls.press("start") then
			cap:free()
			break
		end
		if controls.press("select") then
			cap:free()
			break
		end
	end
	if controls.press("select") then
	else
		controls.read()
		return buffer
	end
end