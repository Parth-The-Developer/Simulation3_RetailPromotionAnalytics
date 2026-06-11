# Run deploy_all.sql from the project root so :r paths resolve correctly.
$ProjectRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$DeployScript = Join-Path $ProjectRoot "scripts\deployment\deploy_all.sql"

Set-Location $ProjectRoot
Write-Host "Project root: $ProjectRoot"
Write-Host "Running: $DeployScript"

sqlcmd -S localhost -E -i $DeployScript
