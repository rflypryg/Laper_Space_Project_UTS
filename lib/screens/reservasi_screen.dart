// lib/screens/reservasi_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'reservasi_confirm_screen.dart'; // Import layar konfirmasi

class ReservasiScreen extends StatefulWidget {
  const ReservasiScreen({super.key});

  @override
  State<ReservasiScreen> createState() => _ReservasiScreenState();
}

class _ReservasiScreenState extends State<ReservasiScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Data Form
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _paxController = TextEditingController();
  
  // Pilihan Tanggal dan Waktu
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _selectedTableType = 'Reguler'; 
  final List<String> _tableTypes = ['Reguler', 'VIP (Tambahan Rp50k)', 'Outdoor'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _paxController.dispose();
    super.dispose();
  }

  // =========================================================
  // LOGIKA PICKER TANGGAL & WAKTU
  // =========================================================

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // =========================================================
  // LOGIKA SUBMIT
  // =========================================================

  void _submitReservation() {
    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedTime != null) {
      // Gabungkan tanggal dan waktu
      final DateTime selectedDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final reservasiData = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'pax': int.parse(_paxController.text),
        'tableType': _selectedTableType,
        'selectedDateTime': selectedDateTime,
        'confirmationTime': DateTime.now(), // Waktu konfirmasi
      };

      // Tampilkan SnackBar sukses (opsional)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reservasi sedang diproses...')),
      );

      // Navigasi ke Layar Konfirmasi Reservasi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReservasiConfirmScreen(reservasiData: reservasiData),
        ),
      );
    } else if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon lengkapi tanggal dan waktu reservasi.')),
      );
    }
  }


  // =========================================================
  // WIDGET UTAMA
  // =========================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservasi Meja')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Isi detail untuk memesan meja Anda.', style: TextStyle(fontSize: 16, color: Colors.black87)),
              const SizedBox(height: 20),

              // Nama Pemesan
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap Pemesan',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Nomor Telepon
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon (Aktif)',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Jumlah Tamu (Pax)
              TextFormField(
                controller: _paxController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Orang (Pax)',
                  prefixIcon: Icon(Icons.group),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Masukkan jumlah orang yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // PILIHAN TANGGAL & WAKTU
              const Text('Waktu Reservasi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              Row(
                children: [
                  // Picker Tanggal
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Tanggal',
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _selectedDate == null 
                            ? 'Pilih Tanggal'
                            : DateFormat('d MMMM yyyy').format(_selectedDate!),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  
                  // Picker Waktu
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectTime(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Waktu',
                          prefixIcon: Icon(Icons.schedule),
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          _selectedTime == null 
                            ? 'Pilih Waktu'
                            : _selectedTime!.format(context),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // PILIHAN TIPE MEJA
              const Text('Tipe Meja:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              
              Wrap(
                spacing: 8.0,
                children: _tableTypes.map((type) => _buildTableTypeChip(type)).toList(),
              ),
              const SizedBox(height: 40),

              // Tombol Konfirmasi Reservasi
              ElevatedButton.icon(
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: const Text('KONFIRMASI RESERVASI', style: TextStyle(color: Colors.white, fontSize: 18)),
                onPressed: _submitReservation,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: Colors.teal, 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET PEMBANTU: Chip Pilihan Tipe Meja
  Widget _buildTableTypeChip(String type) {
    final isSelected = _selectedTableType == type;
    return ChoiceChip(
      label: Text(type),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) {
          setState(() {
            _selectedTableType = type;
          });
        }
      },
      selectedColor: Colors.orange.shade700,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}