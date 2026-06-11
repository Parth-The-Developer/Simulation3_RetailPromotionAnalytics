# Run deploy_all.sql with an absolute ScriptsRoot path for sqlcmd :r includes.
$ProjectRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$ScriptsRoot = Join-Path $ProjectRoot "scripts"
$DeployScript = Join-Path $ScriptsRoot "deployment\deploy_all.sql"

$sqlcmd = Get-Command sqlcmd -ErrorAction SilentlyContinue
if (-not $sqlcmd) {
    Write-Error "sqlcmd not found. Install SQL Server Command Line Tools or run deploy_all.sql in SSMS with SQLCMD Mode."
    exit 1
}

Write-Host "Project root : $ProjectRoot"
Write-Host "Scripts root : $ScriptsRoot"
Write-Host "Deploy script: $DeployScript"

& $sqlcmd.Source -S localhost -E -v ScriptsRoot="$ScriptsRoot" -i $DeployScript
