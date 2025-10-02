import 'package:flutter/material.dart';
import 'package:kuis/main.dart';
import 'login_page.dart';
import 'book.dart';
import 'detail_page.dart';

/// Halaman utama aplikasi (langsung tampil daftar kendaraan + search bar).
class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Menyimpan index kendaraan yang disukai (favorite).
  final List<int> _favorite = [];

  /// Controller untuk search bar (input pencarian).
  final TextEditingController _searchController = TextEditingController();

  /// Kata kunci pencarian (diketik user).
  String _searchKeyword = "";

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tidak"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text("Iya"),
          ),
        ],
      ),
    );
  }

  /// Toggle favorite (like).
  void _toggleFavorite(int vehicleIndex) {
    setState(() {
      if (_favorite.contains(vehicleIndex)) {
        _favorite.remove(vehicleIndex);
      } else {
        _favorite.add(vehicleIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter kendaraan sesuai pencarian
    final filtered = List.generate(bookList.length, (i) => i).where((index) {
      final v = bookList[index];
      final keyword = _searchKeyword.toLowerCase();
      return v.title.toLowerCase().contains(keyword) ||
          v.author.toLowerCase().contains(keyword);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Selamat datang, ${widget.username}"),
        backgroundColor: Colors.orange,
        actions: [
          // Tombol logout
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Cari kendaraan...",
                prefixIcon: const Icon(Icons.search, color: Colors.orange),
                suffixIcon: _searchKeyword.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchKeyword = "";
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => _searchKeyword = value),
            ),
          ),

          // List kendaraan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final BookstoreIndex = filtered[idx];
                final vehicle = bookList[BookstoreIndex];
                final liked = _favorite.contains(BookstoreIndex);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(vehicle.imageUrls[0]),
                      backgroundColor: Colors.orange.shade100,
                    ),
                    title: Text(
                      Bookstore.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(Bookstore.author ?? ''),
                    trailing: IconButton(
                      icon: Icon(
                        liked ? Icons.favorite : Icons.favorite_border,
                        color: liked ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(BookstoreIndex),
                    ),
                    // Klik → buka detail kendaraan
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) =>
                              DetailPage(Bookstore: bookList[BookstoreIndex]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
