
$iconDir = "d:\4FUN\bdo\icons"
$htmlPath = "d:\4FUN\bdo\grind_spots.html"

# Get all target IDs
$content = Get-Content $htmlPath -Raw
$matches = [regex]::Matches($content, "id:\s*(\d+)")
$ids = @()
foreach ($match in $matches) {
    $ids += $match.Groups[1].Value
}
$ids = $ids | Select-Object -Unique

Write-Host "Checking $($ids.Count) IDs..."

foreach ($id in $ids) {
    $dest = Join-Path $iconDir "$id.png"
    if (-not (Test-Path $dest)) {
        Write-Host "Missing icon for ID $id. Fetching from BDO Codex..."
        
        try {
            $pageUrl = "https://bdocodex.com/us/item/$id/"
            # User-Agent is sometimes needed for BDO Codex
            $page = Invoke-WebRequest -Uri $pageUrl -UseBasicParsing -UserAgent "Mozilla/5.0" -ErrorAction Stop
            
            # Regex to find icon src
            # Pattern: <img class="item_icon" src="/items/new_icon/03_etc/07_productmaterial/00056328.png"
            $iconMatch = [regex]::Match($page.Content, 'class="item_icon"\s+src="([^"]+)"')
            
            if ($iconMatch.Success) {
                $relPath = $iconMatch.Groups[1].Value
                $iconUrl = "https://bdocodex.com$relPath"
                
                # Write-Host "   Downloading $iconUrl"
                Invoke-WebRequest -Uri $iconUrl -OutFile $dest -UseBasicParsing -UserAgent "Mozilla/5.0"
                Write-Host "   Saved $id.png"
            } else {
                Write-Warning "   Could not find icon regex match for $id"
            }
        } catch {
            Write-Warning "   Failed to fetch BDO Codex page for $id : $_"
        }
        
        Start-Sleep -Milliseconds 200
    }
}

Write-Host "Recovery check complete."
