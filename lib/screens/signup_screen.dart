import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun Baru')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Buat Akun LaperSpace', style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder(), prefixIcon: Icon(Icons.badge)),
                    ),
                    const SizedBox(height: 15),
                    const TextField(
                      decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(), prefixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(height: 15),
                    const TextField(
                      decoration: InputDecoration(labelText: 'Nomor Telepon', border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone)),
                    ),
                    const SizedBox(height: 15),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Kata Sandi', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock)),
                    ),
                    const SizedBox(height: 15),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Konfirmasi Sandi', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock_reset)),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // Logika pendaftaran dan navigasi
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('DAFTAR', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: const Text('Sudah punya akun? Masuk.'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}