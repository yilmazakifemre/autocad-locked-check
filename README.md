# AutoCAD DWG Kimde Açık Gösterici

Bu PowerShell scripti, OneDrive içinde ortak kullanılan AutoCAD `.dwg` dosyalarının 
hangi kullanıcı tarafından açık olduğunu otomatik olarak gösterir.

## 🧩 Özellikler
- `.dwl` ve `.dwl2` dosyalarını tarar  
- Kullanıcı adını okur  
- Sonuçları ekrana ve `kimdeacik.csv` dosyasına yazar

## ⚙️ Kurulum
1. Bu repo’yu klonla veya `KimdeAcik.ps1` dosyasını indir.
2. `$root` değişkenini kendi DWG klasörüne göre düzenle.
3. PowerShell'i yönetici olarak aç ve bir kez çalıştır:
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
