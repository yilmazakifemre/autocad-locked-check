<#
    AutoCAD DWG Dosyası Kimde Açık Gösterici
    -----------------------------------------------------
    Bu script, belirtilen klasördeki .dwl dosyalarını tarar
    ve hangi DWG dosyasının kimde açık olduğunu listeler.

    Kullanım:
      1️⃣ Aşağıdaki $root yolunu kendi klasörüne göre düzenle.
      2️⃣ PowerShell'i Yönetici olarak çalıştır.
      3️⃣ Gerekirse: Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
      4️⃣ Çalıştır:  .\KimdeAcik.ps1
#>

# --- Ayarlar ---
$root = "C:\Users\$env:USERNAME\OneDrive\Projeler\DWG"   # OneDrive DWG klasörünü buraya yaz

Write-Host "`nAutoCAD DWG Dosyası Kimde Açık Gösterici" -ForegroundColor Cyan
Write-Host "Taranan klasör: $root`n" -ForegroundColor DarkGray

# --- .dwl dosyalarını tara ---
$dwlFiles = Get-ChildItem -Path $root -Recurse -Filter *.dwl -ErrorAction SilentlyContinue

if (-not $dwlFiles) {
    Write-Host "Hiç .dwl dosyası bulunamadı. Şu anda kimse DWG dosyası açık değil." -ForegroundColor Yellow
    exit
}

# --- Sonuçları listele ---
Write-Host "Açık DWG Dosyaları:" -ForegroundColor Cyan
Write-Host "--------------------------------------------"

$result = @()

foreach ($file in $dwlFiles) {
    try {
        $content = Get-Content $file.FullName -ErrorAction SilentlyContinue
        $userLine = $content | Select-String -Pattern "UserName=" | ForEach-Object { $_.ToString() }
        $user = "Bilinmiyor"
        if ($userLine -match "UserName=(.*)") {
            $user = $matches[1]
        }
        $dwgName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        Write-Host "$dwgName.dwg --> $user" -ForegroundColor Green
        $result += [PSCustomObject]@{ Dosya = "$dwgName.dwg"; Kullanici = $user }
    } catch {
        Write-Host "Okunamadı: $($file.Name)" -ForegroundColor Red
    }
}

Write-Host "`nİpucu: .dwl dosyası varsa o DWG şu anda açık!" -ForegroundColor DarkGray

# --- CSV çıktısı oluştur ---
$outFile = Join-Path $env:USERPROFILE "Desktop\kimdeacik.csv"
$result | Export-Csv -Path $outFile -NoTypeInformation -Encoding UTF8
Write-Host "`nRapor oluşturuldu: $outFile" -ForegroundColor Cyan
