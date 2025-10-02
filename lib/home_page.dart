import 'package:flutter/material.dart';
import 'login_page.dart';
import 'book.dart';
import 'detail_page.dart';

/// Halaman utama aplikasi dengan BottomNavigationBar.
/// - Tab 0 = Home (menampilkan daftar kendaraan dalam bentuk ListView)
/// - Tab 1 = Profile (menampilkan halaman profil user)
class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ---------------------------
  // STATE / DATA YANG DIGUNAKAN
  // ---------------------------

  /// Menyimpan index kendaraan yang disukai.
  /// Digunakan untuk toggle icon ❤️.
  final List<int> _favorite = [];

  /// Controller untuk search bar (input pencarian).
  final TextEditingController _searchController = TextEditingController();

  /// Kata kunci pencarian (diketik user).
  String _searchKeyword = "";

  // ---------------------------
  // FUNGSI PENDUKUNG
  // ---------------------------

  /// Logout dengan konfirmasi.
  /// Jika user menekan "Iya", maka diarahkan kembali ke LoginPage.
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

/// Halaman Sampah (Trash)
/// - Menampilkan kendaraan yang dihapus
/// - Ada tombol Restore untuk mengembalikan kendaraan ke Home
class TrashPage extends StatelessWidget {
  final List<int> trashBin;
  final List vehicleList;
  final Function(int) onRestore;

  const TrashPage({
    super.key,
    required this.trashBin,
    required this.vehicleList,
    required this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sampah"),
        backgroundColor: Colors.orange,
      ),
      body: trashBin.isEmpty
          ? const Center(child: Text("Sampah kosong"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: trashBin.length,
              itemBuilder: (context, i) {
                final vehicleIndex = trashBin[i];
                final vehicle = vehicleList[vehicleIndex];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(vehicle.imageUrls[0]),
                    ),
                    title: Text(vehicle.name),
                    subtitle: Text(vehicle.type),
                    trailing: TextButton(
                      child: const Text("Restore"),
                      onPressed: () {
                        onRestore(vehicleIndex);
                        Navigator.pop(context); // kembali ke Home
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
