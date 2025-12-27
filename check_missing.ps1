
$iconDir = "d:\4FUN\bdo\icons"
$htmlPath = "d:\4FUN\bdo\grind_spots.html"
$content = Get-Content $htmlPath -Raw
$matches = [regex]::Matches($content, "id:\s*(\d+)")
$ids = @()
foreach ($match in $matches) {
    $ids += $match.Groups[1].Value
}
$ids = $ids | Select-Object -Unique

foreach ($id in $ids) {
    $path = Join-Path $iconDir "$id.png"
    if (-not (Test-Path $path)) {
        Write-Output $id
    }
}
