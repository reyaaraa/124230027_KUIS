import 'package:flutter/material.dart';
import 'book.dart';

// DetailPage → halaman untuk menampilkan informasi lengkap
// dari sebuah objek "Vehicle" yang diklik dari HomePage
class DetailPage extends StatelessWidget {
  final Book Bookstore; // data kendaraan yang dikirim dari HomePage

  const DetailPage({super.key, required this.Bookstore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50, // warna latar belakang halaman
      appBar: AppBar(
        title: Text(Bookstore.title), // judul app bar sesuai nama kendaraan
        backgroundColor: Colors.orange, // warna app bar
      ),

      // Agar halaman bisa di-scroll (jika konten lebih tinggi dari layar)
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16), // jarak padding seluruh isi
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // teks rata kiri
          children: [
            // ================================
            // BAGIAN FOTO
            // ================================
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  12,
                ), // sudut foto melengkung
                child: Image.network(
                  Bookstore.imageUrls.isNotEmpty
                      ? Bookstore.imageUrls[0] // tampilkan gambar pertama
                      : '', // jika kosong, kasih string kosong
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover, // isi lebar penuh dengan crop rapi
                  // Jika gambar gagal dimuat, tampilkan ikon error
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ================================
            // NAMA & JENIS
            // ================================
            Center(
              child: Text(
                Bookstore.title, // tampilkan nama kendaraan
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                Bookstore.author, // tampilkan jenis kendaraan
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),

            // Garis pembatas
            const Divider(height: 32),

            // ================================
            // DESKRIPSI
            // ================================
            const Text(
              "Deskripsi", // judul bagian deskripsi
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              Bookstore.description, // tampilkan teks deskripsi kendaraan
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16),

            // ================================
            // SPESIFIKASI (ikon + teks)
            // ================================

            // Mesin
            // Harga
            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  "Harga: ${Bookstore.price}", // tampilkan harga
                  style: const TextStyle(
                    color: Colors.red, // warna merah biar menonjol
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
