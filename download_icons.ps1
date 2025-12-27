
# Create icons directory
$iconDir = "d:\4FUN\bdo\icons"
if (-not (Test-Path $iconDir)) {
    New-Item -ItemType Directory -Path $iconDir | Out-Null
    Write-Host "Created icons directory: $iconDir"
}

# Read IDs from HTML file using Regex
$htmlPath = "d:\4FUN\bdo\grind_spots.html"
$content = Get-Content $htmlPath -Raw
$matches = [regex]::Matches($content, "id:\s*(\d+)")

$ids = @{}
foreach ($match in $matches) {
    $id = $match.Groups[1].Value
    if (-not $ids.ContainsKey($id)) {
        $ids[$id] = $true
    }
}

Write-Host "Found $($ids.Count) unique IDs."

# Download Icons
$count = 0
foreach ($id in $ids.Keys) {
    $url = "https://api.blackdesertmarket.com/item/$id/icon"
    $dest = Join-Path $iconDir "$id.png"
    
    if (-not (Test-Path $dest)) {
        try {
            # Write-Host "Downloading $id..."
            Invoke-WebRequest -Uri $url -OutFile $dest -ErrorAction Stop
        } catch {
            Write-Warning "Failed to download icon for ID $id : $_"
        }
        Start-Sleep -Milliseconds 50 # Be polite to API
    }
    
    $count++
    if ($count % 10 -eq 0) {
        Write-Host "Processed $count / $($ids.Count) items..."
    }
}

Write-Host "Done! Icons saved to $iconDir"
