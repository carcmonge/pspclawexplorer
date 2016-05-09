--[[ 

ID3 Lib v1.5
by Yongobongo

Description: A LUA library that allows users to easily grab ID3 data from MP3 files.

id3.getV1(mp3) - Returns ID3 V1 tags in an array.
id3.getV2(mp3,tag) - Returns the ID3 V2 tag specified.
id3.getArt(mp3, w, h) - Returns an image of album art, in PNG format.

]]--

id3 = {}

function id3.getV1(mp3)
local name,artist,album,track,genre,year,comment = ""
local fbuf = io.open(mp3,"r")
fbuf:seek("end",-128)
local tag = fbuf:read(3)
if tag == "TAG" then
	fbuf:seek("end",-125)
	name = fbuf:read(30)
	fbuf:seek("end",-95)
	artist = fbuf:read(30)
	fbuf:seek("end",-65)
	album = fbuf:read(30)
	fbuf:seek("end",-35)
	year = fbuf:read(4)
	fbuf:seek("end",-31)
	comment = fbuf:read(28)
	fbuf:seek("end",-2)
	track = fbuf:read(1)
	fbuf:seek("end",-1)
	genre = fbuf:read(1)
	
	for i = 1, string.len(name) do
		if string.byte(string.sub(name,-1)) == 0 or string.byte(string.sub(name,-1)) == 32 then
			name = string.sub(name,1,-2)
		end
	end
	for i = 1, string.len(artist) do
		if string.byte(string.sub(artist,-1)) == 0 or string.byte(string.sub(artist,-1)) == 32 then
			artist = string.sub(artist,1,-2)
		end
	end
	for i = 1, string.len(album) do
		if string.byte(string.sub(album,-1)) == 0 or string.byte(string.sub(album,-1)) == 32 then
			album = string.sub(album,1,-2)
		end
	end
end
	fbuf:close()
	return { name = name, artist = artist, album = album, track = track, genre = genre, year = year, comment = comment }
end

function id3.getV2(mp3,tag)
local fbuf = io.open(mp3,"r")
local ttag = ""
fbuf:seek("set")
local fdata = fbuf:read(100000)
local fndid = string.find(fdata, tag)

if fndid then
	ttag = string.sub(fdata, fndid + 11, fndid + 9 + string.byte(string.sub(fdata, fndid+7, fndid+7)))
	ttag = string.gsub(ttag, "\0", "")
	fbuf:close()
end

return ttag
end

function id3.getArt(mp3)
	local fbuf = io.open(mp3,"r")
	fbuf:seek("set")
	local fdata = fbuf:read(100000)
	local fndid = string.find(fdata, "APIC")
	local none_found = image.create(128,128,color.new(255,255,255))

	if fndid then
		local beg = string.sub(fdata,fndid)
		local beg_pos = string.find(beg, "JFIF")-6
		
		if beg_pos then
			beg = string.sub(beg,beg_pos)
			local fin = string.find(beg, string.char(255)..string.char(217))
			
			if fin then
				fin = fin + 1
				
				img = string.sub(beg,1,fin)
				
				fbuf:close()
				
				file = io.open("buffer.jpg","w")
				file:write(img)
				file:close()
				os.message("D:")
				done,imagen       = pcall(image.load,"buffer.jpg")
				os.message(":D")
				if done then
					return imagen
				end
			else
				return "none found"
			end
		else
			local beg_pos = string.find(beg, "‰PNG")
			
			if beg_pos then
				beg = string.sub(beg,beg_pos)
				local fin = string.find(beg,IEND)+7
				
				img = string.sub(beg,1,fin)
				
				fbuf:close()
				done,imagen       = pcall(image.loadfrommemory,img)
				if done then
					return imagen
				end
			else
				return "none found"
			end
		end
	else
		return "none found"
	end
end