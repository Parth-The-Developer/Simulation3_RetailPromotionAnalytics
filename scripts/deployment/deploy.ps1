# Run deploy_all.sql with an absolute ScriptsRoot path for sqlcmd :r includes.
$ProjectRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$ScriptsRoot = Join-Path $ProjectRoot "scripts"
$DeployScript = Join-Path $ScriptsRoot "deployment\deploy_all.sql"

Write-Host "Project root : $ProjectRoot"
Write-Host "Scripts root : $ScriptsRoot"
Write-Host "Deploy script: $DeployScript"

sqlcmd -S localhost -E -v ScriptsRoot="$ScriptsRoot" -i $DeployScript
