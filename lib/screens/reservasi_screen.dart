import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservasiConfirmScreen extends StatelessWidget {
  final Map<String, dynamic> reservasiData;

  const ReservasiConfirmScreen({super.key, required this.reservasiData});

  String _generateRefNumber(DateTime dt) {
    return 'RES${DateFormat('yyMMddHHmmss').format(dt)}';
  }

  Widget _buildInfoBox(String label, String value, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 3),
          Row(
            children: [
              if (icon != null) Icon(icon, size: 16, color: Colors.orange),
              if (icon != null) const SizedBox(width: 5),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime confirmationTime = reservasiData['confirmationTime'];
    final String refNumber = _generateRefNumber(confirmationTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservasi Dikonfirmasi'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade200, blurRadius: 15),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Reservasi Berhasil!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Meja Anda telah berhasil dipesan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoBox('Kode Reservasi', refNumber),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildInfoBox(
                          'Tipe Meja',
                          reservasiData['tableType'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoBox(
                          'Waktu Kedatangan',
                          DateFormat('d MMM, HH:mm')
                              .format(reservasiData['selectedDateTime']),
                          icon: Icons.access_time_filled,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildInfoBox(
                          'Jumlah Tamu',
                          '${reservasiData['pax']} Orang',
                          icon: Icons.people,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  _buildInfoBox(
                    'Nama Pemesan',
                    reservasiData['name'],
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 15),
                  _buildInfoBox(
                    'Kontak',
                    reservasiData['phone'],
                    icon: Icons.phone,
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'Mohon tunjukkan kode reservasi ini kepada staf kami saat kedatangan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Divider(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'SELESAI',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
