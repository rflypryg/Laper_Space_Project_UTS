import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaperSpace'),
        elevation: 0,
        backgroundColor: Colors.white, 
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.person), 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(), 
                ),
              );
            },
          ),
        ],
      ),
      
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        children: const [
          WelcomeBanner(),   
          SizedBox(height: 30),
          PromoSectionVertical(),          
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.orange.shade100, 
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            width: 150, 
            height: 150,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.restaurant, size: 100, color: Colors.orange);
            },
          ),
          const SizedBox(height: 8), 
          Text(
            'Selamat Datang di LaperSpace!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),

          const SizedBox(height: 4), 
          Text(
            'Saatnya menikmati hidangan favorit Anda.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 20), 
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange, 
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 4,
            ),
            child: const Text(
              'Lihat Menu',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PromoSectionVertical extends StatelessWidget {
  const PromoSectionVertical({super.key});

  final List<Map<String, dynamic>> promos = const [
    {'title': 'DISKON 25% Semua Makanan Utama', 'code': 'MAKANASIK25', 'color': Colors.redAccent, 'icon': Icons.local_offer},
    {'title': 'Gratis Minuman Dingin', 'code': 'GRATISTEAL', 'color': Colors.teal, 'icon': Icons.local_drink},
    {'title': 'Diskon 50% untuk Pengunjung Baru', 'code': 'NEWLAPER50', 'color': Colors.blue, 'icon': Icons.person_add},
    {'title': 'Promo Keluarga Hemat', 'code': 'FAMILY4', 'color': Colors.green, 'icon': Icons.people},
    {'title': 'Beli 2 Pasta Gratis 1 Dessert', 'code': 'PASTAYES', 'color': Colors.purple, 'icon': Icons.icecream},
    {'title': 'Happy Hour, Diskon 30% Minuman', 'code': 'HH30OFF', 'color': Colors.orange, 'icon': Icons.alarm},
    {'title': 'Bayar Pake App Dapat Cashback 10%', 'code': 'CASHBACK10', 'color': Colors.pink, 'icon': Icons.payment},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kode Promo Spesial Hari Ini', 
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        
        Column(
          children: promos.map((promo) {
            return _buildPromoCardVertical(
              context, 
              promo['title'] as String, 
              promo['code'] as String, 
              promo['color'] as Color, 
              promo['icon'] as IconData
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPromoCardVertical(BuildContext context, String title, String code, Color color, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Icon(icon, size: 40, color: color),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color),
              ),
              child: Text(
                code,
                style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 12),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.copy, color: Colors.grey),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Kode $code berhasil disalin!')),
            );
          },
        ),
        onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Detail promo: $title')),
            );
        },
      ),
    );
  }
}
