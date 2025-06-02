local function readBytes(file,pos,count)
    file:Seek(pos)
    return {file:Read(count):byte(1,count)}
end

local oggCache = {}
local file_Open = file.Open
local math_min = math.min
local function OGGSoundDuration(sndPath)
    local file = file_Open("sound/" .. sndPath, "rb", "GAME")
    if !file then return 0 end

    local size = file:Size()
    local head = file:Read(math_min(2048,size))
    local rate = -1
    for i = 1,#head -14 do
        if head:sub(i,i +5) == "vorbis" then
            local b = {head:byte(i +11,i +14)}
            rate = b[1] +b[2] *256 +b[3] *256^2 +b[4] *256^3
            break
        end
    end

    local length = -1
    local tailReadSize = math_min(32768,size)
    file:Seek(size -tailReadSize)
    local tail = file:Read(tailReadSize)
    for i = #tail -15,1,-1 do
        if tail:sub(i,i +3) == "OggS" then
            local b = {tail:byte(i +6,i +9)}
            length = b[1] +b[2] *256 +b[3] *256^2 +b[4] *256^3
            break
        end
    end

    file:Close()

    if length > 0 && rate > 0 then
		local dur = length /rate
		oggCache[sndPath] = dur
		print("Sound: " .. sndPath .. " | Duration: " .. dur .. " seconds")
        return dur
    end
    return 0
end

local oldSoundDuration = SoundDuration
local string_StartsWith = string.StartsWith
local string_EndsWith = string.EndsWith
local string_lower = string.lower
function SoundDuration(sndPath)
    if !sndPath then return 0 end
	if oggCache[sndPath] then return oggCache[sndPath] end
    if string_EndsWith(string_lower(sndPath), ".ogg") then
        if string_StartsWith(sndPath, "^") or string_StartsWith(sndPath, "#") then
            sndPath = sndPath:sub(2)
            if oggCache[sndPath] then return oggCache[sndPath] end
        end
        return OGGSoundDuration(sndPath)
    end
    return oldSoundDuration(sndPath)
end