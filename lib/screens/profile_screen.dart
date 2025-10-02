import 'package:flutter/material.dart'; //package
import 'home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String userName = 'Ahmad Rizki';
    const String userHandle = '@rizkifoodie';
    const String userBio =
        'Pecinta kuliner nusantara 🍜 | Food blogger | Selalu mencari hidden gems makanan enak di sekitar Jakarta!';
    const String userLocation = 'Jakarta Selatan, Indonesia';
    const String userWebsite = 'rizkifoodie.blog';
    const String userJoined = 'Januari 2023';

    const int totalOrders = 89;
    const int totalReviews = 45;
    const double totalPoints = 2.1;

    const int currentPoints = 2150;
    const int nextLevelPoints = 5000;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          },
        ),
        title: const Text('Profil'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 35,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.check_circle,
                                    color: Colors.blue, size: 18),
                              ],
                            ),
                            Text(
                              userHandle,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(userBio),
                  const SizedBox(height: 10),

                  _buildDetailRow(Icons.location_on_outlined, userLocation),
                  _buildDetailRow(Icons.link, userWebsite, isLink: true),
                  _buildDetailRow(
                      Icons.calendar_today_outlined, 'Bergabung $userJoined'),

                  const SizedBox(height: 25),

                  // hanya tombol Bagikan
                  Row(
                    children: [
                      Expanded(
                        child: _buildProfileButton('Bagikan', Icons.share,
                            onTap: () {}),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(thickness: 1, height: 1),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn(totalOrders.toString(), 'Pesanan'),
                  _buildStatColumn(totalReviews.toString(), 'Review'),
                  _buildStatColumn('${totalPoints.toString()}K', 'Poin'),
                ],
              ),
            ),

            const Divider(thickness: 1, height: 1),

            _buildMemberProgress(context, currentPoints, nextLevelPoints),

            const Divider(thickness: 1, height: 1),

            _buildMenuTile(context, Icons.history, 'Riwayat Pesanan',
                onTap: () {}),
            _buildMenuTile(
                context, Icons.restaurant_menu_outlined, 'Restoran Favorit',
                onTap: () {}),
            _buildMenuTile(
                context, Icons.location_on_outlined, 'Alamat Pengiriman',
                onTap: () {}),
            _buildMenuTile(
                context, Icons.credit_card_outlined, 'Metode Pembayaran',
                onTap: () {}),
            _buildMenuTile(context, Icons.star_border, 'Review & Rating',
                onTap: () {}),
            _buildMenuTile(
                context, Icons.redeem_outlined, 'Promo & Voucher',
                onTap: () {}),
            _buildMenuTile(
                context, Icons.settings_outlined, 'Pengaturan',
                onTap: () {}),
            _buildMenuTile(context, Icons.help_outline, 'Bantuan',
                onTap: () {}),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isLink ? Colors.blue : Colors.grey.shade600,
              decoration: isLink ? TextDecoration.underline : TextDecoration.none,
              fontWeight: isLink ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton(String text, IconData icon,
      {bool isPrimary = false, required VoidCallback onTap}) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.black : Colors.white,
          foregroundColor: isPrimary ? Colors.white : Colors.black,
          side: const BorderSide(color: Colors.black, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildMemberProgress(
      BuildContext context, int currentPoints, int nextLevelPoints) {
    final double progress = currentPoints / nextLevelPoints;
    final int pointsRemaining = nextLevelPoints - currentPoints;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade700, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.emoji_events, color: Colors.white, size: 24),
                    SizedBox(width: 8),
                    Text('Member',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Gold',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Poin Kamu', style: TextStyle(color: Colors.white70)),
                Text(currentPoints.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress > 1.0 ? 1.0 : progress,
              backgroundColor: Colors.white38,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              borderRadius: BorderRadius.circular(10),
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text(
              '${pointsRemaining.toString()} poin lagi untuk naik level',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallActionButton(Icons.toll_outlined, 'Tukar Poin', () {}),
                _buildSmallActionButton(
                    Icons.arrow_forward, 'Lihat reward →', () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallActionButton(
      IconData icon, String text, VoidCallback onTap) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white, size: 18),
      label: Text(text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      style: TextButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
    );
  }

  Widget _buildMenuTile(BuildContext context, IconData icon, String title,
      {required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: Icon(icon, color: Colors.black87, size: 28),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
        const Divider(height: 0, indent: 20, endIndent: 20),
      ],
    );
  }
}
