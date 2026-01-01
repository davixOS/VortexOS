-- 1. TU LINK CODIFICADO (Esto no parece un link a simple vista)
-- Este es tu link de GitHub pasado por un codificador simple
local SecretSource = "aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2Rhdml4T1MvRkZINFgtTU9CSUxFL21haW4vbWFpbi5sdWE="

-- 2. FUNCIÓN DE DESCODIFICADO (Para que el executor lo entienda)
local function Decode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d%d%d%d%d%d', function(x)
        local n = 0
        for i = 1, 8 do n = n + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0) end
        return string.char(n)
    end))
end

-- 3. EL LOADER PROTEGIDO
local function LoadFFH4X(key)
    local CorrectKey = "FFH4X-2026" -- Tu llave
    
    if key == CorrectKey then
        -- Descodificamos el link solo en el momento de usarlo
        local HiddenLink = Decode(SecretSource)
        
        -- Ejecución protegida
        local success, err = pcall(function()
            loadstring(game:HttpGet(HiddenLink))()
        end)
        
        if not success then
            warn("Error al cargar el núcleo: " .. err)
        end
    else
        print("Llave invalida.")
    end
end

-- Ejemplo de uso:
LoadFFH4X("FFH4X-2026")
