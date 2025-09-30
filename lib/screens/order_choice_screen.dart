import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart'; 
import 'receipt_screen.dart'; 

class OrderChoiceScreen extends StatefulWidget {
  final Map<String, dynamic> summaryData;
  const OrderChoiceScreen({super.key, required this.summaryData});

  @override
  State<OrderChoiceScreen> createState() => _OrderChoiceScreenState();
}

class _OrderChoiceScreenState extends State<OrderChoiceScreen> {
  String _selectedOption = 'Makan di Tempat';
  String _selectedPaymentMethod = 'Cash'; 
  final List<String> _paymentMethods = ['Cash', 'Kartu Debit/Kredit', 'QRIS (Gopay/Dana/OVO)'];

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>(); 
    final List<CartItem> items = widget.summaryData['items'].cast<CartItem>(); 
    final double subtotal = widget.summaryData['subtotal'];
    final double tax = widget.summaryData['tax'];
    final double totalFinal = widget.summaryData['totalFinal'];

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout & Pembayaran')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildOrderDetails(items, subtotal, tax, totalFinal),
            const SizedBox(height: 30),

            const Text(
              'Pilih Metode Pembayaran:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40, 
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _paymentMethods.map((method) => _buildPaymentOption(method)).toList(),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              'Bagaimana Anda ingin menikmati pesanan ini?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            _buildOptionCard('Makan di Tempat (Dine-in)', Icons.restaurant, 'Makan di Tempat'),
            const SizedBox(height: 15),
            _buildOptionCard('Bawa Pulang (Take-away)', Icons.shopping_bag, 'Bawa Pulang'),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.payment, color: Colors.white),
              label: Text('BAYAR Rp ${totalFinal.toStringAsFixed(0)} & CETAK RESI', style: const TextStyle(color: Colors.white, fontSize: 18)),
              onPressed: () {
                final receiptData = {
                  ...widget.summaryData,
                  'orderOption': _selectedOption, 
                  'paymentMethod': _selectedPaymentMethod, 
                  'dateTime': DateTime.now(),
                };
                cart.clearCart();

                Navigator.pushReplacement( 
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiptScreen(receiptData: receiptData),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.green, 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String method) {
    final isSelected = _selectedPaymentMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Chip(
          label: Text(method, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
          backgroundColor: isSelected ? Colors.orange.shade700 : Colors.grey.shade200,
          side: isSelected ? BorderSide.none : BorderSide(color: Colors.grey.shade400, width: 0.5),
        ),
      ),
    );
  }
  Widget _buildOrderDetails(List<CartItem> items, double subtotal, double tax, double totalFinal) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ringkasan Belanja', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(height: 15),

            ...items.map((item) => _buildItemRow(item)).toList(),
            const Divider(height: 15),

            _buildSummaryRow('Subtotal', subtotal),
            _buildSummaryRow('PPN (10%)', tax, isTax: true),
            const Divider(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TOTAL AKHIR:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  'Rp ${totalFinal.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, double amount, {bool isTax = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: isTax ? 14 : 16, color: isTax ? Colors.red : Colors.black87)),
          Text('Rp ${amount.toStringAsFixed(0)}', style: TextStyle(fontSize: isTax ? 14 : 16, fontWeight: isTax ? FontWeight.normal : FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildItemRow(CartItem item) {
    final itemTotal = item.price * item.quantity;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${item.name} (${item.quantity}x)',
              style: TextStyle(color: Colors.grey.shade700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text('Rp ${itemTotal.toStringAsFixed(0)}'),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String title, IconData icon, String value) {
    final isSelected = _selectedOption == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = value;
        });
      },
      child: Card(
        elevation: isSelected ? 8 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? Colors.orange : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: isSelected ? Colors.orange : Colors.grey),
              const SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.orange.shade900 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
