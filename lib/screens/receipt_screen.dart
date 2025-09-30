import 'package:flutter/material.dart';
import '../models/cart.dart'; 
import 'package:intl/intl.dart'; 

final currencyFormatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

class ReceiptScreen extends StatelessWidget {
  final Map<String, dynamic> receiptData;
  
  const ReceiptScreen({super.key, required this.receiptData});

  String _generateRefNumber(DateTime dt) {
    return 'LPR${DateFormat('yyMMddHHmmss').format(dt)}'; 
  }
  String _formatPaymentTime(DateTime dt) {
    return DateFormat('d MMM yyyy, HH:mm').format(dt);
  }

  Widget _buildSummaryBox(String label, double amount, {Color amountColor = Colors.black87}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
          Text(
            currencyFormatter.format(amount), 
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: amountColor),
          ),
        ],
      ),
    );
  }
  Widget _buildOrderItemsList(List<CartItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Daftar Item Dipesan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
            const Text('Qty', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(width: 15),
            const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        const Divider(height: 5),
        ...items.map((item) {
          final itemTotal = item.price * item.quantity;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${item.quantity}x',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 15),
                Text(
                  currencyFormatter.format(itemTotal),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil Data
    final List<CartItem> items = receiptData['items'].cast<CartItem>(); 
    final double subtotal = receiptData['subtotal'];
    final double tax = receiptData['tax'];
    final double totalFinal = receiptData['totalFinal'];
    final String orderOption = receiptData['orderOption'];
    final String paymentMethod = receiptData['paymentMethod'];
    final DateTime dateTime = receiptData['dateTime'];
    final String refNumber = _generateRefNumber(dateTime);


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined), 
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 15)],
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.check, color: Colors.white, size: 40),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Payment Success!',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      Text(
                        'Pesanan Anda berhasil dikonfirmasi dan dibayar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 25),

                      const Text('Total Pembayaran', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text(
                        currencyFormatter.format(totalFinal),
                        style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: Colors.black87),
                      ),
                      const SizedBox(height: 20),

                      _buildDetailRowCard(
                        refNumber, 
                        _formatPaymentTime(dateTime), 
                        paymentMethod, 
                        orderOption,
                      ),
                      const SizedBox(height: 25),

                      Row(
                        children: [
                            Expanded(child: _buildSummaryBox('Subtotal Item', subtotal)),
                            const SizedBox(width: 15),
                            Expanded(child: _buildSummaryBox('PPN (10%)', tax, amountColor: Colors.red)),
                        ],
                      ),
                      const SizedBox(height: 25),

                      _buildOrderItemsList(items),
                      const Divider(height: 30),

                      TextButton.icon(
                        icon: const Icon(Icons.download, color: Colors.blue),
                        label: const Text('Get PDF Receipt', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Fitur download sedang dikembangkan!')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst); 
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: Colors.purple.shade900, 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('DONE', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildDetailRowCard(String refNumber, String paymentTime, String method, String option) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildInfoBox('Ref Number', refNumber)),
            const SizedBox(width: 15),
            Expanded(child: _buildInfoBox('Payment Time', paymentTime)),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: _buildInfoBox('Payment Method', method)),
            const SizedBox(width: 15),
            Expanded(child: _buildInfoBox('Order Option', option)),
          ],
        ),
      ],
    );
  }
  Widget _buildInfoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
