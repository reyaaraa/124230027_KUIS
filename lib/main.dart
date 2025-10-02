import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const Bookstore());
}

class Bookstore extends StatelessWidget {
  static String title = 'Bookstore';

  const Bookstore({super.key});

  static String? get author => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookstore',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
