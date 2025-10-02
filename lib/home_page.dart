import 'package:flutter/material.dart';
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
  final List<int> _favorite = [];
  final TextEditingController _searchController = TextEditingController();
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

  void _toggleFavorite(int bookIndex) {
    setState(() {
      if (_favorite.contains(bookIndex)) {
        _favorite.remove(bookIndex);
      } else {
        _favorite.add(bookIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = List.generate(bookList.length, (i) => i).where((index) {
      final v = bookList[index];
      final keyword = _searchKeyword.toLowerCase();
      return v.title.toLowerCase().contains(keyword) ||
          v.author.toLowerCase().contains(keyword);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Store"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade100,
            child: Text(
              "Selamat datang, ${widget.username} 👋",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Cari Buku...",
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                suffixIcon: _searchKeyword.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchKeyword = "");
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filtered.length,
              itemBuilder: (context, idx) {
                final bookIndex = filtered[idx];
                final book = bookList[bookIndex];
                final liked = _favorite.contains(bookIndex);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(book.imageUrls.first),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    title: Text(
                      book.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(book.author),
                    trailing: IconButton(
                      icon: Icon(
                        liked ? Icons.favorite : Icons.favorite_border,
                        color: liked ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(bookIndex),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => DetailPage(book: book),
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
}
