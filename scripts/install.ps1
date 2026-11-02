# Instala as skills do Claude Arsenal no Windows.
# Uso:  powershell -ExecutionPolicy Bypass -File scripts\install.ps1 [-Project] [-Only "dockge,logdeck"] [-Uninstall]
param(
  [switch]$Project,
  [string]$Only = "",
  [switch]$Uninstall
)
$ErrorActionPreference = "Stop"

$Target = if ($Project) { Join-Path (Get-Location) ".claude\skills" } else { Join-Path $HOME ".claude\skills" }
$Src = Join-Path $PSScriptRoot "..\skills" | Resolve-Path

$all = Get-ChildItem -Directory $Src | Select-Object -ExpandProperty Name
$skills = if ($Only) { $Only.Split(",") | ForEach-Object { $_.Trim() } } else { $all }

New-Item -ItemType Directory -Force -Path $Target | Out-Null
$n = 0
foreach ($s in $skills) {
  $from = Join-Path $Src $s
  $dest = Join-Path $Target $s
  if (-not (Test-Path $from)) { Write-Warning "skill inexistente: $s"; continue }
  if ($Uninstall) {
    $md = Join-Path $dest "SKILL.md"
    if ((Test-Path $md) -and (Select-String -Path $md -Pattern "^name: $s$" -Quiet)) { Remove-Item -Recurse -Force $dest; $n++ }
    continue
  }
  if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
  Copy-Item -Recurse $from $dest
  $n++
}
if ($Uninstall) { Write-Host "OK: $n skills removidas de $Target" }
else { Write-Host "OK: $n skills instaladas em $Target. Reinicie o Claude Code e use /arsenal." }
