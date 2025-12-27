
$iconDir = "d:\4FUN\bdo\icons"
$map = @{
    "721002" = "https://bdocodex.com/items/new_icon/03_etc/00721002.webp"
    "56334" = "https://bdocodex.com/items/new_icon/03_etc/04_dropitem/00065335.webp"
    "56284" = "https://bdocodex.com/items/new_icon/03_etc/03_quest_item/00067340.webp"
    "821246" = "https://bdocodex.com/items/new_icon/03_etc/07_productmaterial/00821246.webp"
    "821253" = "https://bdocodex.com/items/new_icon/03_etc/07_productmaterial/00821253.webp"
    "15286" = "https://bdocodex.com/items/new_icon/03_etc/11_enchant_material/00015286_1.webp"
    "821319" = "https://bdocodex.com/items/new_icon/03_etc/07_productmaterial/00821254.webp"
    "15290" = "https://bdocodex.com/items/new_icon/03_etc/11_enchant_material/00015287_1.webp"
    "821254" = "https://bdocodex.com/items/new_icon/03_etc/07_productmaterial/00821319.webp"
    "15287" = "https://bdocodex.com/items/new_icon/03_etc/11_enchant_material/00015290_1.webp"
}

foreach ($key in $map.Keys) {
    $url = $map[$key]
    $dest = Join-Path $iconDir "$key.png"
    Write-Host "Downloading $key from $url..."
    Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing -UserAgent "Mozilla/5.0"
}
Write-Host "Batch recovery complete."
