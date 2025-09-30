import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String userName = 'John Doe';
    const String userEmail = 'johndoe@lapitespace.com';
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              userName,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              userEmail,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey.shade600),
            ),
            
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
            _buildProfileTile(context, Icons.edit, 'Edit Profil', () {
              _showSnackBar(context, 'Fitur Edit Profil sedang dikembangkan.');
            }),
            _buildProfileTile(context, Icons.history, 'Riwayat Pesanan', () {
              _showSnackBar(context, 'Fitur Riwayat Pesanan sedang dikembangkan.');
            }),
            _buildProfileTile(context, Icons.settings, 'Pengaturan Aplikasi', () {
              _showSnackBar(context, 'Fitur Pengaturan sedang dikembangkan.');
            }),
            
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                _showSnackBar(context, 'Anda berhasil Logout!');
                Navigator.of(context).pop(); 
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('Logout', style: TextStyle(fontSize: 18, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
  
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
