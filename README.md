# String char (Lua) decoder

Proyek ini berisi script Lua yang berfungsi untuk mendecode string yang diencrypt menggunakan nilai ASCII ( string.byte ).

## Cara Penggunaan

1. Pastikan Anda memiliki Lua terinstal di sistem Anda.
2. Salin seluruh kode ke dalam file Lua (misalnya `decoder.lua`).
3. Ubah variabel `code` sesuai dengan kode yang ingin Anda decode.
4. Jalankan script menggunakan perintah `lua decoder.lua`.

## Penjelasan Kode

- `pattern`: Berisi pola regex untuk mendeteksi variabel dan fungsi local.
- `Literals`: Tabel untuk menyimpan variabel dan fungsi yang dideklarasikan.
- `checkLiterals()`: Fungsi untuk mengidentifikasi variabel dan fungsi dalam code.
- `decode()`: Fungsi utama yang melakukan proses decoding.

## Contoh Output

Untuk code contoh yang diberikan, output akan terlihat seperti ini:

```lua
local a = "tea"
local function declaredFunction()
end
print(a) -- "a" ter deklarasi, jadi tidak termasuk string
print("hello")
print(declaredFunction())
```