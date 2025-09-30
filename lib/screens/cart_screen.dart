import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart'; 
import 'order_choice_screen.dart'; 

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Keranjang Belanja')),
          body: Column(
            children: [
              Expanded(
                child: cart.items.isEmpty
                    ? Center(
                        child: Text(
                            'Keranjang kosong. Yuk, pesan makanan!',
                            style: Theme.of(context).textTheme.titleMedium),
                      )
                    : ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          return CartItemWidget(item: cart.items[index]);
                        },
                      ),
              ),
              
              if (cart.items.isNotEmpty)
                MinimalCheckoutSummary(cart: cart), 
            ],
          ),
        );
      },
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.fastfood, size: 40, color: Colors.orange),
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Rp ${item.price.toStringAsFixed(0)} x ${item.quantity}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, size: 18),
              onPressed: () => cart.updateQuantity(item.name, item.quantity - 1),
            ),
            Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add, size: 18),
              onPressed: () => cart.updateQuantity(item.name, item.quantity + 1),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
              onPressed: () => cart.removeItem(item.name),
            ),
          ],
        ),
      ),
    );
  }
}

class MinimalCheckoutSummary extends StatelessWidget {
  final CartProvider cart;
  const MinimalCheckoutSummary({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    const double taxRate = 0.10; 
    final double subtotal = cart.totalAmount;
    final double tax = subtotal * taxRate;
    final double totalFinal = subtotal + tax; 

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Harga Item:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                'Rp ${subtotal.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 15),
          
          // Tombol Lanjut ke Opsi Pesanan
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            label: const Text('Lanjut ke Checkout & Pembayaran', style: TextStyle(color: Colors.white, fontSize: 16)),
            onPressed: () {
              final summaryData = {
                'items': cart.items,
                'subtotal': subtotal,
                'tax': tax,
                'totalFinal': totalFinal,
                'paymentMethod': 'Cash', // Default atau Biarkan kosong, nanti dipilih di OrderChoiceScreen
              };
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderChoiceScreen(summaryData: summaryData),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
