import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart'; 
import 'menu_screen.dart'; 

class MenuDetailScreen extends StatelessWidget {
  final MenuItem menuItem;
  const MenuDetailScreen({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(menuItem.name),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Icon(Icons.image_outlined, size: 80, color: Colors.white),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menuItem.name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  
                  // Kategori dan Harga
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(menuItem.category, style: const TextStyle(color: Colors.white)),
                        backgroundColor: Colors.orange,
                      ),
                      Text(
                        'Rp ${menuItem.price.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 30),
                  
                  Text(
                    'Deskripsi Lengkap',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    menuItem.fullDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 40),
                  
                  // Tombol Tambah ke Keranjang
                  ElevatedButton.icon(
                    onPressed: () {
                      cart.addItem(CartItem(name: menuItem.name, price: menuItem.price));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${menuItem.name} ditambahkan ke Keranjang!')),
                      );
                      // Opsional: Kembali ke halaman menu setelah menambahkan
                      Navigator.pop(context); 
                    },
                    icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                    label: const Text('TAMBAH KE KERANJANG', style: TextStyle(fontSize: 18, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}