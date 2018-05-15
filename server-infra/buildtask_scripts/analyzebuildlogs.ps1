# This script will analyze build log files

param
(
    [Parameter(Mandatory=$true)]
    [String] $BuildLogFile
)

# Calculate build time
$logContent = get-content $BuildLogFile
$start = $logContent | Select-Object -first 1
$end =  $logContent | Select-Object -last 1
$BuildContainerTime = (Get-Date -Date $end) - (Get-Date -Date $start)
Write-Host "##vso[task.setvariable variable=BuildContainerTime]$BuildContainerTime"

$content = Get-Content "result.txt"

$buildStatus = "danger"
if ($content -eq "success") {
    $buildStatus = "good"
}

Write-Host "##vso[task.setvariable variable=BuildStatus]$buildStatus"