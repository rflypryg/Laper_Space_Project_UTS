import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import 'menu_detail_screen.dart';

class MenuItem {
  final String name;
  final String description;
  final String fullDescription;
  final double price;
  final String imageUrl;
  final String category;

  MenuItem({
    required this.name,
    required this.description,
    required this.fullDescription,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

final List<MenuItem> fullMenu = [

  MenuItem(
    name: 'Nasi Goreng Spesial',
    description: 'Nasi goreng dengan ayam dan telur',
    fullDescription: 'Nasi goreng istimewa dengan suwiran ayam, telur mata sapi, acar, dan kerupuk.',
    price: 35000,
    imageUrl: 'assets/makanan/nasi_goreng.jpg',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Ayam Geprek Sambal Matah',
    description: 'Ayam goreng tepung renyah',
    fullDescription: 'Ayam goreng crispy digeprek dengan sambal matah segar khas Bali.',
    price: 38000,
    imageUrl: 'assets/makanan/ayam_geprek.jpg',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Mie Goreng Jawa',
    description: 'Mie goreng khas Jawa',
    fullDescription: 'Mie goreng tradisional dengan kecap manis, irisan ayam, telur, sawi, dan tomat.',
    price: 30000,
    imageUrl: 'assets/makanan/mie_goreng.jpg',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Sate Ayam',
    description: 'Sate ayam bumbu kacang',
    fullDescription: 'Tusukan sate ayam empuk dengan bumbu kacang kental, disajikan dengan lontong.',
    price: 28000,
    imageUrl: 'assets/makanan/sate_ayam.jpg',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Soto Ayam',
    description: 'Soto ayam bening',
    fullDescription: 'Kuah kaldu kuning gurih dengan suwiran ayam, telur rebus, soun, dan koya.',
    price: 25000,
    imageUrl: 'assets/makanan/soto_ayam.jpg',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Bakso Malang Komplit',
    description: 'Bakso dengan berbagai isi',
    fullDescription: 'Bakso urat, bakso halus, siomay, pangsit, tahu, dan mie kuning dalam kuah kaldu gurih.',
    price: 27000,
    imageUrl: 'assets/makanan/bakso_malang.jpg',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Ikan Bakar',
    description: 'Ikan bakar bumbu kecap',
    fullDescription: 'Ikan segar dibakar dengan bumbu kecap manis pedas.',
    price: 40000,
    imageUrl: 'assets/makanan/ikan_bakar.jpg',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Ayam Bakar',
    description: 'Ayam bakar manis pedas',
    fullDescription: 'Ayam bakar dengan bumbu kecap, sambal, dan lalapan.',
    price: 35000,
    imageUrl: 'assets/makanan/ayam_bakar.jpg',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Nasi Padang Komplit',
    description: 'Nasi padang lauk lengkap',
    fullDescription: 'Nasi putih dengan rendang, sayur nangka, sambal ijo, dan kerupuk.',
    price: 45000,
    imageUrl: 'assets/makanan/nasi_padang.jpg',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Burger Klasik',
    description: 'Burger beef patty tebal',
    fullDescription: 'Roti bun lembut dengan patty sapi premium, keju cheddar, selada, tomat, dan saus spesial.',
    price: 42000,
    imageUrl: 'assets/makanan/burger.jpg',
    category: 'Makanan Utama',
  ),

  MenuItem(
    name: 'Es Teh Manis',
    description: 'Teh manis dingin',
    fullDescription: 'Teh hitam asli Indonesia dengan gula, disajikan dingin dengan es batu.',
    price: 8000,
    imageUrl: 'assets/minuman/teh_manis.jpg',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Es Jeruk Segar',
    description: 'Perasan jeruk segar',
    fullDescription: 'Jus jeruk asli tanpa pemanis buatan, segar dan alami.',
    price: 12000,
    imageUrl: 'assets/minuman/es_jeruk.jpg',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Es Kopi Susu Gula Aren',
    description: 'Kopi susu gula aren',
    fullDescription: 'Espresso, susu segar, dan gula aren khas nusantara.',
    price: 20000,
    imageUrl: 'assets/minuman/kopi_susu.jpg',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Teh Tarik',
    description: 'Teh khas Malaysia',
    fullDescription: 'Teh kental dengan susu kental manis, dikocok hingga berbusa.',
    price: 15000,
    imageUrl: 'assets/minuman/teh_tarik.jpg',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Thai Tea',
    description: 'Teh ala Thailand',
    fullDescription: 'Teh Thailand creamy dengan susu kental manis, disajikan dingin.',
    price: 18000,
    imageUrl: 'assets/minuman/thai_tea.jpg',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Milkshake Cokelat',
    description: 'Milkshake rasa cokelat',
    fullDescription: 'Milkshake kental dengan es krim cokelat dan whipped cream.',
    price: 25000,
    imageUrl: 'assets/minuman/milkshake_coklat.jpg',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Jus Buah Segar',
    description: 'Aneka jus buah',
    fullDescription: 'Jus buah segar alami sesuai pilihan (alpukat, mangga, jambu).',
    price: 20000,
    imageUrl: 'assets/minuman/jus_buah.jpg',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Lemon Tea',
    description: 'Teh lemon segar',
    fullDescription: 'Es teh dengan perasan lemon segar.',
    price: 15000,
    imageUrl: 'assets/minuman/lemon_tea.webp',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Es Kelapa Muda',
    description: 'Es kelapa segar',
    fullDescription: 'Air kelapa muda alami dengan daging kelapa lembut.',
    price: 22000,
    imageUrl: 'assets/minuman/es_kelapa.jpg',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Air Mineral',
    description: 'Air mineral botol',
    fullDescription: 'Air mineral segar dalam kemasan botol.',
    price: 6000,
    imageUrl: 'assets/minuman/air_mineral.jpg',
    category: 'Minuman',
  ),

  MenuItem(
    name: 'French Fries',
    description: 'Kentang goreng renyah',
    fullDescription: 'Kentang goreng krispi disajikan dengan saus sambal dan mayones.',
    price: 22000,
    imageUrl: 'assets/cemilan/french_fries.jpg',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Tahu Krispi',
    description: 'Tahu goreng crispy',
    fullDescription: 'Tahu goreng renyah dengan bumbu pedas gurih.',
    price: 15000,
    imageUrl: 'assets/cemilan/tahu_krispi.jpg',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Pisang Goreng Keju',
    description: 'Pisang goreng topping keju',
    fullDescription: 'Pisang goreng crispy dengan taburan keju dan susu kental manis.',
    price: 20000,
    imageUrl: 'assets/cemilan/pisang_goreng.jpg',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Singkong Thailand',
    description: 'Singkong keju manis',
    fullDescription: 'Singkong rebus lembut disiram saus santan manis dan keju parut.',
    price: 18000,
    imageUrl: 'assets/cemilan/singkong.jpg',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Sosis Bakar',
    description: 'Sosis bakar manis pedas',
    fullDescription: 'Sosis jumbo dibakar dengan saus pedas manis.',
    price: 20000,
    imageUrl: 'assets/cemilan/sosis_bakar.jpg',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Cilok Bumbu Kacang',
    description: 'Cilok khas Bandung',
    fullDescription: 'Cilok kenyal disiram bumbu kacang gurih pedas.',
    price: 15000,
    imageUrl: 'assets/cemilan/cilok.jpg',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Cireng Bandung',
    description: 'Cireng isi pedas',
    fullDescription: 'Cireng renyah dengan isi ayam pedas gurih.',
    price: 18000,
    imageUrl: 'assets/cemilan/cireng.jpg',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Dimsum Ayam',
    description: 'Dimsum kukus ayam',
    fullDescription: 'Dimsum ayam lembut kukus dengan saus chili oil.',
    price: 23000,
    imageUrl: 'assets/cemilan/dimsum.jpg',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Onion Rings',
    description: 'Cincin bawang goreng',
    fullDescription: 'Onion rings krispi dengan adonan tempura ringan.',
    price: 24000,
    imageUrl: 'assets/cemilan/onion_rings.jpg',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Siomay Bandung',
    description: 'Siomay ikan khas Bandung',
    fullDescription: 'Siomay ikan kukus dengan tahu, kol, kentang, dan bumbu kacang.',
    price: 20000,
    imageUrl: 'assets/cemilan/siomay.jpg',
    category: 'Cemilan',
  ),

  MenuItem(
    name: 'Pudding Cokelat',
    description: 'Puding cokelat lembut',
    fullDescription: 'Puding cokelat dengan vla vanilla.',
    price: 18000,
    imageUrl: 'assets/dessert/puding.jpg',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Es Campur',
    description: 'Es campur segar',
    fullDescription: 'Campuran buah, cincau, tape, kolang-kaling dengan sirup manis.',
    price: 20000,
    imageUrl: 'assets/dessert/es_campur.jpg',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Es Cendol',
    description: 'Es cendol segar',
    fullDescription: 'Cendol hijau, santan, dan gula merah cair, dengan es serut.',
    price: 15000,
    imageUrl: 'assets/dessert/es_cendol.jpg',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Waffle Ice Cream',
    description: 'Waffle hangat + es krim',
    fullDescription: 'Waffle disajikan dengan es krim vanilla dan sirup cokelat.',
    price: 30000,
    imageUrl: 'assets/dessert/waffel.jpg',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Brownies Ice Cream',
    description: 'Brownies hangat + es krim',
    fullDescription: 'Brownies fudgy panas disajikan dengan es krim vanilla.',
    price: 33000,
    imageUrl: 'assets/dessert/brownies.jpg',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Cheesecake Mini',
    description: 'Cheesecake lembut',
    fullDescription: 'Mini cheesecake creamy dengan topping blueberry.',
    price: 32000,
    imageUrl: 'assets/dessert/cheesecake.jpg',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Klepon Tradisional',
    description: 'Kue klepon isi gula merah',
    fullDescription: 'Klepon kenyal isi gula merah cair dengan taburan kelapa parut.',
    price: 12000,
    imageUrl: 'assets/dessert/klepon.jpg',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Roti Bakar Manis',
    description: 'Roti bakar topping cokelat',
    fullDescription: 'Roti bakar lembut dengan topping cokelat lumer.',
    price: 20000,
    imageUrl: 'assets/dessert/roti_bakar.jpg',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Pancake Buah',
    description: 'Pancake dengan topping buah',
    fullDescription: 'Pancake lembut dengan stroberi, blueberry, dan madu.',
    price: 28000,
    imageUrl: 'assets/dessert/pancake.jpg',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Mochi Ice Cream',
    description: 'Mochi isi es krim',
    fullDescription: 'Kue mochi kenyal berisi es krim dengan berbagai rasa.',
    price: 28000,
    imageUrl: 'assets/dessert/mochi.jpg',
    category: 'Dessert',
  ),
];

final List<String> categories = ['Semua', 'Makanan Utama', 'Minuman', 'Cemilan', 'Dessert'];

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth >= 900 ? 3 : 2;

    final filteredMenu = _selectedCategory == 'Semua'
        ? fullMenu
        : fullMenu.where((item) => item.category == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu LaperSpace'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: categories.map((category) {
                return _buildCategoryChip(category, category == _selectedCategory);
              }).toList(),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: filteredMenu.isEmpty
                ? const Center(child: Text('Menu tidak ditemukan di kategori ini.'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1 / 1.45,
                    ),
                    itemCount: filteredMenu.length,
                    itemBuilder: (context, index) {
                      final item = filteredMenu[index];
                      return _buildMenuItemCard(context, item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ActionChip(
        label: Text(label),
        onPressed: () {
          setState(() {
            _selectedCategory = label;
          });
        },
        backgroundColor: isSelected ? Colors.orange.shade100 : Colors.grey.shade200,
        labelStyle: TextStyle(
          color: isSelected ? Colors.orange.shade800 : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildMenuItemCard(BuildContext context, MenuItem item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuDetailScreen(menuItem: item),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Hero(
                  tag: item.name,
                  child: Image.asset(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp ${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final cart = Provider.of<CartProvider>(context, listen: false);
                          cart.addItem(CartItem(name: item.name, price: item.price));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${item.name} ditambahkan ke Keranjang!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 20),
                      ),
                    ],
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
