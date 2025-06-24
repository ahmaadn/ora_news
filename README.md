# Ora News

## Anggota Kelompok 7

  - Ahmad Nur Sahid (2206042)
  - Deden Ruli Cahyadi (2206054)
-----

## Tentang Proyek

Ora News adalah aplikasi berita yang dibangun menggunakan Flutter. Aplikasi ini memungkinkan pengguna untuk menjelajahi, membaca, dan mencari berita dari berbagai kategori. Pengguna yang terautentikasi juga dapat mempublikasikan dan mengelola artikel berita mereka sendiri.

Aplikasi ini dirancang dengan arsitektur yang bersih, memisahkan antara logika bisnis, layanan data, dan antarmuka pengguna (UI) untuk memastikan skalabilitas dan kemudahan dalam pemeliharaan.

## ✨ Fitur-fitur Utama

Berikut adalah beberapa fitur utama yang tersedia dalam aplikasi Ora News:

### Autentikasi Pengguna

  - **Splash Screen & Onboarding**: Pengenalan aplikasi bagi pengguna baru.
  - **Login & Registrasi**: Sistem autentikasi untuk pengguna baru dan yang sudah ada.
  - **Lupa Password**: Fitur untuk mereset password melalui email.
  - **Manajemen Sesi**: Menggunakan token untuk menjaga sesi login pengguna.

### Penjelajahan Berita

  - **Halaman Utama (Home)**: Menampilkan berita utama (headlines), sorotan (highlights), dan berita yang sedang tren.
  - **Berita Berdasarkan Kategori**: Pengguna dapat memfilter berita berdasarkan kategori yang tersedia.
  - **Detail Berita**: Halaman khusus untuk membaca konten lengkap dari sebuah artikel berita.
  - **Pencarian Berita**: Fitur untuk mencari berita berdasarkan kata kunci.
  - **Riwayat Pencarian**: Menyimpan dan menampilkan riwayat pencarian terakhir pengguna.

### Manajemen Berita oleh Pengguna

  - **Buat Berita**: Pengguna yang sudah login dapat membuat dan mempublikasikan artikel berita baru.
  - **Update Berita**: Pengguna dapat mengedit artikel berita yang telah mereka publikasikan.
  - **Hapus Berita**: Pengguna dapat menghapus artikel berita mereka.
  - **Daftar Berita Saya**: Halaman khusus yang menampilkan semua berita yang telah dipublikasikan oleh pengguna.
  - **Upload Gambar**: Pengguna dapat mengunggah gambar untuk artikel berita mereka dari penyimpanan lokal atau melalui URL.

### Profil Pengguna

  - **Halaman Profil**: Menampilkan informasi pengguna dan memungkinkan pembaruan data seperti nama, email, dan password.
  - **Logout**: Mengakhiri sesi pengguna saat ini.

## 📂 Struktur Folder

Proyek ini mengikuti struktur folder standar Flutter yang dilengkapi dengan pemisahan berdasarkan fitur untuk direktori `lib`.

```
ora_news/
├── android/            # File spesifik untuk platform Android
├── ios/                # File spesifik untuk platform iOS
├── lib/                # Direktori utama kode Dart
│   ├── app/            # Konfigurasi global, routing, tema, dan utilitas
│   │   ├── config/
│   │   ├── constants/
│   │   └── utils/
│   ├── data/           # Layer data, termasuk model, API service, dan provider
│   │   ├── api/
│   │   ├── models/
│   │   └── provider/
│   ├── views/          # Layer UI, dipisahkan berdasarkan fitur
│   │   ├── features/
│   │   │   ├── auth/
│   │   │   ├── discover/
│   │   │   ├── home/
│   │   │   ├── introduction/
│   │   │   ├── main/
│   │   │   ├── news/
│   │   │   └── profile/
│   │   └── widgets/    # Widget yang dapat digunakan kembali
│   └── main.dart       # Titik masuk utama aplikasi
├── linux/              # File spesifik untuk platform Linux
├── macos/              # File spesifik untuk platform macOS
├── test/               # Tes untuk aplikasi
├── web/                # File spesifik untuk platform Web
├── windows/            # File spesifik untuk platform Windows
└── pubspec.yaml        # Konfigurasi dependensi dan aset proyek
```

### Penjelasan Direktori `lib`

  - `app/`: Berisi semua konfigurasi tingkat aplikasi seperti routing (`app_route.dart`), tema (`app_theme.dart`), warna (`app_color.dart`), dan utilitas umum (`app_date_formatter.dart`).
  - `data/`: Bertanggung jawab atas semua hal yang berkaitan dengan data.
      - `api/`: Mengelola komunikasi dengan API backend (misalnya, `auth_service.dart`, `news_service.dart`).
      - `models/`: Berisi kelas model Dart untuk data seperti `NewsArticle` dan `User`.
      - `provider/`: Berisi state management menggunakan Provider (misalnya, `auth_provider.dart`, `news_public_provider.dart`).
  - `views/`: Berisi semua komponen UI.
      - `features/`: Halaman-halaman (screens) yang dikelompokkan berdasarkan fiturnya (contoh: `home`, `auth`, `profile`).
      - `widgets/`: Widget kustom yang digunakan di berbagai bagian aplikasi (contoh: `news_card.dart`, `custom_button.dart`).
  - `main.dart`: Titik masuk aplikasi tempat inisialisasi Provider dan `MaterialApp` dilakukan.

## 🚀 Cara Menjalankan Aplikasi

Untuk menjalankan proyek ini di lingkungan lokal Anda, ikuti langkah-langkah berikut:

### Prasyarat

  - Pastikan Anda telah menginstal **Flutter SDK** di komputer Anda. Untuk panduan instalasi, silakan merujuk ke [dokumentasi resmi Flutter](https://docs.flutter.dev/get-started/install).
  - Emulator Android, Simulator iOS, atau perangkat fisik yang terhubung.
  - Clone repositori backend dan jalankan terlebih dahulu.

### Langkah-langkah Instalasi

1.  **Clone Repositori**

    ```bash
    git clone https://github.com/ahmaadn/ora_news.git
    cd ora_news
    ```

2.  **Instal Dependensi**

    Jalankan perintah berikut di terminal untuk mengunduh semua paket yang diperlukan:

    ```bash
    flutter pub get
    ```

3.  **Jalankan Aplikasi**

    Pastikan perangkat atau emulator Anda berjalan, lalu jalankan perintah berikut:

    ```bash
    flutter run
    ```

Aplikasi akan di-build dan diinstal di perangkat target Anda.

## 🌐 Backend

Aplikasi ini memerlukan backend untuk berfungsi. Backend yang digunakan untuk proyek ini tersedia di repositori berikut:

[**ora-news-backend**](https://github.com/ahmaadn/ora-news-backend)

Pastikan server backend berjalan sebelum menjalankan aplikasi mobile ini untuk memastikan konektivitas API yang lancar. Konfigurasi endpoint API dapat ditemukan di `lib/app/constants/api_constants.dart`.
