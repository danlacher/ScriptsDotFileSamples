﻿Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

Clear-Host

# https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/enable-attack-surface-reduction?view=o365-worldwide
# 0 : DISABLE (Disable the ASR rule)
# 1 : BLOCK (Enable the ASR rule)
# 2 : AUDIT (Evaluate how the ASR rule would impact your organization if enabled)
# 6 : WARN (Enable the ASR rule but allow the end-user to bypass the block)

$ASRRules = @{
    'BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550' = "Block executable content from email client and webmail"
    'D4F940AB-401B-4EFC-AADC-AD5F3C50688A' = "Block all Office applications from creating child processes"
    '3B576869-A4EC-4529-8536-B80A7769E899' = "Block Office applications from creating executable content"
    '75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84' = "Block Office applications from injecting code into other processes"
    'D3E037E1-3EB8-44C8-A917-57927947596D' = "Block JavaScript or VBScript from launching downloaded executable content"
    '5BEB7EFE-FD9A-4556-801D-275E5FFC04CC' = "Block execution of potentially obfuscated scripts"
    '92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B' = "Block Win32 API calls from Office macros"
    '01443614-cd74-433a-b99e-2ecdc07bfc25' = "Block executable files from running unless they meet a prevalence, age, or trusted list criterion"
    'c1db55ab-c21a-4637-bb3f-a12568109d35' = "Use advanced protection against ransomware"
    '9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2' = "Block credential stealing from the Windows local security authority subsystem (lsass.exe)"
    'b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4' = "Block untrusted and unsigned processes that run from USB"
    '26190899-1602-49e8-8b27-eb1d0a1ce869' = "Block Office communication application from creating child processes"
    '7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c' = "Block Adobe Reader from creating child processes"
    'e6db77e5-3df2-4cf1-b95a-636979351e5b' = "Block persistence through WMI event subscription"
    'd1e49aac-8f56-4280-b9ba-993a6d77406c' = "Block process creations originating from PSExec and WMI commands"
    '56a863a9-875e-4185-98a7-b882c64b5ce5' = "Block abuse of exploited vulnerable signed drivers"
}

$x = Get-MpPreference

Write-Host "Exclusion Extensions:" 
$x.ExclusionExtension

Write-Host ""
Write-Host "Exclusion Paths:"
$x.ExclusionPath

Write-Host ""
Write-Host "Exclusion Processes:"
$x.ExclusionProcess

Write-Host ""
Write-Host "ASR Exclusion:"
$x.AttackSurfaceReductionOnlyExclusions

Write-Host ""
Write-Host "Schedule Scan Day:"
$x.ScanScheduleDay

Write-Host ""
Write-Host "Attack Surface Reduction: (0 - ALLOW, 1-BLOCK, 2 - AUDIT)"
$count = $x.AttackSurfaceReductionRules_Ids.count - 1
while ( $count -ge 0 )
{
    Write-Host $x.AttackSurfaceReductionRules_Ids[$count] " : " $x.AttackSurfaceReductionRules_Actions[$count] " : " $ASRRules[$x.AttackSurfaceReductionRules_Ids[$count]]
    $count--
}