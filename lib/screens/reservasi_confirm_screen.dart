import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ReservasiConfirmScreen extends StatefulWidget {
  final Map<String, dynamic> reservasiData;

  const ReservasiConfirmScreen({super.key, required this.reservasiData});

  @override
  State<ReservasiConfirmScreen> createState() => _ReservasiConfirmScreenState();
}

class _ReservasiConfirmScreenState extends State<ReservasiConfirmScreen> {
  late String refNumber;

  @override
  void initState() {
    super.initState();
    final DateTime confirmationTime = widget.reservasiData['confirmationTime'] is DateTime
        ? widget.reservasiData['confirmationTime']
        : DateTime.now();
    refNumber = _generateRefNumber(confirmationTime);
  }

  String _generateRefNumber(DateTime dt) {
    return 'RES${DateFormat('yyMMddHHmmss').format(dt)}';
  }

  Widget _buildInfoBox(String label, String value, {IconData? icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: onTap != null ? Colors.blue.shade50 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  if (onTap != null)
                    const Icon(Icons.copy, size: 14, color: Colors.blue),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  if (icon != null) Icon(icon, size: 16, color: Colors.orange),
                  if (icon != null) const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: onTap != null ? Colors.blue.shade700 : Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCopySnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kode Reservasi berhasil disalin!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime selectedDateTime = widget.reservasiData['selectedDateTime'] is DateTime
        ? widget.reservasiData['selectedDateTime']
        : DateTime.now();

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
                    child: Icon(Icons.check_circle_outline, color: Colors.white, size: 40),
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
                        child: _buildInfoBox(
                          'Kode Reservasi',
                          refNumber,
                          icon: Icons.qr_code,
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: refNumber));
                            _showCopySnackbar();
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildInfoBox(
                          'Tipe Meja',
                          widget.reservasiData['tableType'],
                          icon: Icons.table_restaurant,
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
                          DateFormat('d MMM, HH:mm').format(selectedDateTime),
                          icon: Icons.access_time_filled,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildInfoBox(
                          'Jumlah Tamu',
                          '${widget.reservasiData['pax']} Orang',
                          icon: Icons.people,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildInfoBox(
                    'Nama Pemesan',
                    widget.reservasiData['name'],
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 15),
                  _buildInfoBox(
                    'Kontak',
                    widget.reservasiData['phone'],
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
                      Navigator.of(context).popUntil((route) => route.isFirst);
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
