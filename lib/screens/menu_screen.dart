import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart'; // <<< Pastikan Anda mengimpor CartItem dan CartProvider dari sini
import 'menu_detail_screen.dart'; // Import halaman detail baru

// =========================================================
// DATA DUMMY MENU (PASTIKAN IMAGE PATH SESUAI)
// =========================================================
class MenuItem {
  final String name;
  final String description; 
  final String fullDescription; 
  final double price;
  final String imageUrl; // Pastikan path ini benar!
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
  // =======================
  // Makanan Utama (10)
  // =======================
  MenuItem(
    name: 'Nasi Goreng Spesial',
    description: 'Nasi goreng dengan ayam dan telur',
    fullDescription: 'Nasi goreng istimewa dengan suwiran ayam, telur mata sapi, acar, dan kerupuk.',
    price: 35000,
    // Sumber: Alamy - Nasi goreng (fried rice) is a traditional food of Bali, Indonesia. Topped with a fried egg and dried shallots...
    imageUrl: 'assets/makanan/nasi_goreng.png',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Ayam Geprek Sambal Matah',
    description: 'Ayam goreng tepung renyah',
    fullDescription: 'Ayam goreng crispy digeprek dengan sambal matah segar khas Bali.',
    price: 38000,
    // Sumber: Papa Ayam - Ayam Geprek Sambal Matah. Crispy fried chicken smashed with sambal matah.
    imageUrl: 'assets/makanan/ayam_geprek.png',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Mie Goreng Jawa',
    description: 'Mie goreng khas Jawa',
    fullDescription: 'Mie goreng tradisional dengan kecap manis, irisan ayam, telur, sawi, dan tomat.',
    price: 30000,
    // Sumber: Freepik - Mie goreng jawa PSD
    imageUrl: 'https://www.freepik.com/psd/mie-goreng-jawa',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Sate Ayam',
    description: 'Sate ayam bumbu kacang',
    fullDescription: 'Tusukan sate ayam empuk dengan bumbu kacang kental, disajikan dengan lontong.',
    price: 28000,
    // Sumber: Shutterstock - Sate Ayam Madura
    imageUrl: 'https://www.shutterstock.com/search/sate-ayam-madura',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Soto Ayam',
    description: 'Soto ayam bening',
    fullDescription: 'Kuah kaldu kuning gurih dengan suwiran ayam, telur rebus, soun, dan koya.',
    price: 25000,
    // Sumber: Shutterstock - Soto ayam bening or chicken soup is Indonesian food...
    imageUrl: 'https://www.shutterstock.com/image-photo/soto-ayam-bening-chicken-soup-indonesian-2642548145',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Bakso Malang Komplit',
    description: 'Bakso dengan berbagai isi',
    fullDescription: 'Bakso urat, bakso halus, siomay, pangsit, tahu, dan mie kuning dalam kuah kaldu gurih.',
    price: 27000,
    // Sumber: Liputan6 - Mencicip Bakso Malang Jaya Bersama, Kuliner Bakso Viral di Tangerang (Mengilustrasikan Bakso Malang)
    imageUrl: 'https://www.liputan6.com/regional/read/5834242/mencicip-bakso-malang-jaya-bersama-kuliner-bakso-viral-di-tangerang',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Ikan Bakar',
    description: 'Ikan bakar bumbu kecap',
    fullDescription: 'Ikan segar dibakar dengan bumbu kecap manis pedas.',
    price: 40000,
    // Sumber: IndoGo - Resep Ikan Bakar Kecap Rumahan
    imageUrl: 'https://www.indogo.com.tw/2021/05/28/resep-ikan-bakar-kecap-rumahan-bikinnya-gampang-lezat-tak-tertandingi/',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Ayam Bakar',
    description: 'Ayam bakar manis pedas',
    fullDescription: 'Ayam bakar dengan bumbu kecap, sambal, dan lalapan.',
    price: 35000,
    // Sumber: Getty Images - Ayam bakar kecap or Grilled chicken with soy sauce
    imageUrl: 'https://www.gettyimages.com/detail/photo/ayam-bakar-kecap-or-grilled-chicken-with-soy-sauce-royalty-free-image/2195976542',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Nasi Padang Komplit',
    description: 'Nasi padang lauk lengkap',
    fullDescription: 'Nasi putih dengan rendang, sayur nangka, sambal ijo, dan kerupuk.',
    price: 45000,
    // Sumber: Dreamstime - Nasi Padang with Rendang
    imageUrl: 'https://www.dreamstime.com/photos-images/rendang-padang.html',
    category: 'Makanan Utama',
  ),
  MenuItem(
    name: 'Burger Klasik',
    description: 'Burger beef patty tebal',
    fullDescription: 'Roti bun lembut dengan patty sapi premium, keju cheddar, selada, tomat, dan saus spesial.',
    price: 42000,
    // Sumber: Shutterstock - Burger Klasik
    imageUrl: 'https://www.shutterstock.com/search/hamburger',
    category: 'Makanan Utama',
  ),

  // =======================
  // Minuman (10)
  // =======================
  MenuItem(
    name: 'Es Teh Manis',
    description: 'Teh manis dingin',
    fullDescription: 'Teh hitam asli Indonesia dengan gula, disajikan dingin dengan es batu.',
    price: 8000,
    // Sumber: Shutterstock - Es Teh Manis
    imageUrl: 'https://www.shutterstock.com/search/es-teh-manis',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Es Jeruk Segar',
    description: 'Perasan jeruk segar',
    fullDescription: 'Jus jeruk asli tanpa pemanis buatan, segar dan alami.',
    price: 12000,
    // Sumber: Wikimedia Commons - Es Jeruk
    imageUrl: 'https://commons.wikimedia.org/wiki/File:Es_jeruk.jpg',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Es Kopi Susu Gula Aren',
    description: 'Kopi susu gula aren',
    fullDescription: 'Espresso, susu segar, dan gula aren khas nusantara.',
    price: 20000,
    // Sumber: Shutterstock - Es Kopi Susu Gula Aren
    imageUrl: 'https://www.shutterstock.com/search/kopi-gula-aren',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Teh Tarik',
    description: 'Teh khas Malaysia',
    fullDescription: 'Teh kental dengan susu kental manis, dikocok hingga berbusa.',
    price: 15000,
    // Sumber: iStock - Teh Tarik
    imageUrl: 'https://www.istockphoto.com/photos/teh-tarik', // Ganti dengan URL gambar yang sebenarnya jika ada
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Thai Tea',
    description: 'Teh ala Thailand',
    fullDescription: 'Teh Thailand creamy dengan susu kental manis, disajikan dingin.',
    price: 18000,
    // Sumber: Shutterstock - Thai Tea
    imageUrl: 'https://www.shutterstock.com/search/thai-tea', // Ganti dengan URL gambar yang sebenarnya jika ada
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Milkshake Cokelat',
    description: 'Milkshake rasa cokelat',
    fullDescription: 'Milkshake kental dengan es krim cokelat dan whipped cream.',
    price: 25000,
    // Sumber: Dreamstime - Chocolate milkshake whipped cream
    imageUrl: 'https://www.dreamstime.com/photos-images/chocolate-milkshake-whipped-cream.html',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Jus Buah Segar',
    description: 'Aneka jus buah',
    fullDescription: 'Jus buah segar alami sesuai pilihan (alpukat, mangga, jambu).',
    price: 20000,
    // Sumber: YouTube - Jus Kekinian || Big Alpukat Mangga (Mengilustrasikan jus buah)
    imageUrl: 'https://www.youtube.com/watch?v=WLzky3Bdib4',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Lemon Tea',
    description: 'Teh lemon segar',
    fullDescription: 'Es teh dengan perasan lemon segar.',
    price: 15000,
    // Sumber: iStock - Iced Tea Iced Tea isolated on white background.
    imageUrl: 'https://www.istockphoto.com/photos/lemon-tea',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Es Kelapa Muda',
    description: 'Es kelapa segar',
    fullDescription: 'Air kelapa muda alami dengan daging kelapa lembut.',
    price: 22000,
    // Sumber: Wikimedia Commons - Es Kelapa Muda
    imageUrl: 'https://commons.wikimedia.org/wiki/File:Es_Kelapa_Muda.JPG',
    category: 'Minuman',
  ),
  MenuItem(
    name: 'Air Mineral',
    description: 'Air mineral botol',
    fullDescription: 'Air mineral segar dalam kemasan botol.',
    price: 6000,
    // Sumber: Wikimedia Commons - Botol air mineral
    imageUrl: 'https://commons.wikimedia.org/wiki/File:Botol_air_mineral.jpg',
    category: 'Minuman',
  ),

  // =======================
  // Cemilan (10)
  // =======================
  MenuItem(
    name: 'French Fries',
    description: 'Kentang goreng renyah',
    fullDescription: 'Kentang goreng krispi disajikan dengan saus sambal dan mayones.',
    price: 22000,
    // Sumber: Unsplash - French Fries
    imageUrl: 'https://unsplash.com/s/photos/french-fries',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Tahu Krispi',
    description: 'Tahu goreng crispy',
    fullDescription: 'Tahu goreng renyah dengan bumbu pedas gurih.',
    price: 15000,
    // Sumber: Shutterstock - Tahu Krispi
    imageUrl: 'https://www.shutterstock.com/search/tahu-krispy',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Pisang Goreng Keju',
    description: 'Pisang goreng topping keju',
    fullDescription: 'Pisang goreng crispy dengan taburan keju dan susu kental manis.',
    price: 20000,
    // Sumber: Shutterstock - Pisang Goreng Keju
    imageUrl: 'https://www.shutterstock.com/search/goreng-pisang-cheese',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Singkong Thailand',
    description: 'Singkong keju manis',
    fullDescription: 'Singkong rebus lembut disiram saus santan manis dan keju parut.',
    price: 18000,
    // Sumber: Shutterstock - Singkong Thailand
    imageUrl: 'https://www.shutterstock.com/search/singkong-keju',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Sosis Bakar',
    description: 'Sosis bakar manis pedas',
    fullDescription: 'Sosis jumbo dibakar dengan saus pedas manis.',
    price: 20000,
    // Sumber: Infopublik.id - SOSIS BAKAR JUMBO
    imageUrl: 'https://infopublik.id/galeri/foto/detail/82195?show=',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Cilok Bumbu Kacang',
    description: 'Cilok khas Bandung',
    fullDescription: 'Cilok kenyal disiram bumbu kacang gurih pedas.',
    price: 15000,
    // Sumber: Shutterstock - Cilok Bumbu Kacang
    imageUrl: 'https://www.shutterstock.com/search/cilok-bumbu-kacang',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Cireng Bandung',
    description: 'Cireng isi pedas',
    fullDescription: 'Cireng renyah dengan isi ayam pedas gurih.',
    price: 18000,
    // Sumber: Shutterstock - Cireng Bandung
    imageUrl: 'https://www.shutterstock.com/search/cireng',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Dimsum Ayam',
    description: 'Dimsum kukus ayam',
    fullDescription: 'Dimsum ayam lembut kukus dengan saus chili oil.',
    price: 23000,
    // Sumber: Shutterstock - Dimsum Ayam
    imageUrl: 'https://www.shutterstock.com/search/dimsum-ayam',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Onion Rings',
    description: 'Cincin bawang goreng',
    fullDescription: 'Onion rings krispi dengan adonan tempura ringan.',
    price: 24000,
    // Sumber: Shutterstock - Onion Rings
    imageUrl: 'https://www.shutterstock.com/search/onion-rings',
    category: 'Cemilan',
  ),
  MenuItem(
    name: 'Siomay Bandung',
    description: 'Siomay ikan khas Bandung',
    fullDescription: 'Siomay ikan kukus dengan tahu, kol, kentang, dan bumbu kacang.',
    price: 20000,
    // Sumber: Shutterstock - Siomay Bumbu Kacang
    imageUrl: 'https://www.shutterstock.com/image-photo/siomay-bumbu-kacang-indonesian-steamed-fish-2373382757',
    category: 'Cemilan',
  ),

  // =======================
  // Dessert (10)
  // =======================
  MenuItem(
    name: 'Pudding Cokelat',
    description: 'Puding cokelat lembut',
    fullDescription: 'Puding cokelat dengan vla vanilla.',
    price: 18000,
    // Sumber: Shutterstock - Chocolate Silky Pudding Topped Vaniila Vla
    imageUrl: 'https://www.shutterstock.com/image-photo/chocolate-silky-pudding-topped-vaniila-vla-2659870311',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Es Campur',
    description: 'Es campur segar',
    fullDescription: 'Campuran buah, cincau, tape, kolang-kaling dengan sirup manis.',
    price: 20000,
    // Sumber: Shutterstock - Es Campur
    imageUrl: 'https://www.shutterstock.com/search/es-campur?page=3',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Es Cendol',
    description: 'Es cendol segar',
    fullDescription: 'Cendol hijau, santan, dan gula merah cair, dengan es serut.',
    price: 15000,
    // Sumber: Getty Images - Es Cendol
    imageUrl: 'https://www.gettyimages.com/detail/photo/es-cendol-or-dawet-is-indonesian-traditional-iced-royalty-free-image/2159776422',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Waffle Ice Cream',
    description: 'Waffle hangat + es krim',
    fullDescription: 'Waffle disajikan dengan es krim vanilla dan sirup cokelat.',
    price: 30000,
    // Sumber: Shutterstock - Waffle Ice Cream
    imageUrl: 'https://www.shutterstock.com/search/waffle-ice-cream', // Ganti dengan URL gambar yang sebenarnya jika ada
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Brownies Ice Cream',
    description: 'Brownies hangat + es krim',
    fullDescription: 'Brownies fudgy panas disajikan dengan es krim vanilla.',
    price: 33000,
    // Sumber: Shutterstock - Brownie Sundae
    imageUrl: 'https://www.shutterstock.com/search/brownie-sundae',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Cheesecake Mini',
    description: 'Cheesecake lembut',
    fullDescription: 'Mini cheesecake creamy dengan topping blueberry.',
    price: 32000,
    // Sumber: Shutterstock - Mini Cheesecake
    imageUrl: 'https://www.shutterstock.com/search/mini-cheesecake',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Klepon Tradisional',
    description: 'Kue klepon isi gula merah',
    fullDescription: 'Klepon kenyal isi gula merah cair dengan taburan kelapa parut.',
    price: 12000,
    // Sumber: Shutterstock - Klepon
    imageUrl: 'https://www.shutterstock.com/search/klepon', // Ganti dengan URL gambar yang sebenarnya jika ada
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Roti Bakar Manis',
    description: 'Roti bakar topping cokelat',
    fullDescription: 'Roti bakar lembut dengan topping cokelat lumer.',
    price: 20000,
    // Sumber: Shutterstock - Roti Bakar Cokelat Lumer
    imageUrl: 'https://www.shutterstock.com/search/chocolate-roti?page=4',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Pancake Buah',
    description: 'Pancake dengan topping buah',
    fullDescription: 'Pancake lembut dengan stroberi, blueberry, dan madu.',
    price: 28000,
    // Sumber: iStock - Blueberry Pancakes with Strawberries
    imageUrl: 'https://www.istockphoto.com/photos/blueberry-pancakes-with-strawberries',
    category: 'Dessert',
  ),
  MenuItem(
    name: 'Mochi Ice Cream',
    description: 'Mochi isi es krim',
    fullDescription: 'Kue mochi kenyal berisi es krim dengan berbagai rasa.',
    price: 28000,
    // Sumber: Shutterstock - Mochi Ice Cream Vektor
    imageUrl: 'https://www.shutterstock.com/id/search/mochi-ice-cream?image_type=vector',
    category: 'Dessert',
  ),
];



// List Kategori unik untuk filter
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
    // Ukuran layar untuk penyesuaian responsif
    final screenWidth = MediaQuery.of(context).size.width;

    // Default ke 2 kolom untuk sebagian besar ukuran layar
    int crossAxisCount = 2; 
    // Jika layar sangat lebar (misal desktop), bisa 3 kolom
    if (screenWidth >= 900) { 
      crossAxisCount = 3; 
    } else if (screenWidth < 600) {
      // Untuk layar yang sangat kecil, mungkin tetap 2 kolom,
      // tapi jika Anda ingin 1 kolom di ponsel sangat kecil, ubah ini menjadi 1.
      // Namun, umumnya 2 kolom masih terlihat baik di ponsel.
      crossAxisCount = 2; 
    }


    // Logika Filter Menu (tetap sama)
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
          // Filter Kategori Horizontal (tetap sama)
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: categories.map((category) {
                return _buildCategoryChip(category, category == _selectedCategory);
              }).toList(),
            ),
          ),
          const Divider(height: 1),

          // Daftar Menu GridView (Sekarang akan selalu 2 kolom atau lebih)
          Expanded(
            child: filteredMenu.isEmpty
                ? const Center(child: Text('Menu tidak ditemukan di kategori ini.'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount, // Menggunakan logika responsif di atas
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      // Child aspect ratio: Lebar / Tinggi.
                      // 1 / 1.45 berarti tingginya 1.45 kali lebarnya.
                      // Sesuaikan nilai ini jika kartu terlalu pendek/tinggi.
                      childAspectRatio: (1 / 1.45), 
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

  // Widget untuk Chip Kategori (tetap sama)
  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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

  // Widget Kartu Item Menu (dengan perbaikan gambar dan provider)
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
            // Gambar Hero dengan penanganan error yang lebih baik
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Hero(
                  tag: item.name, 
                  child: Image.asset(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    // Penanganan error jika gambar tidak ditemukan
                    errorBuilder: (context, error, stackTrace) {
                      // Ini akan menampilkan icon error jika path gambar salah
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
              padding: const EdgeInsets.all(10.0),
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
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Akses CartProvider di sini (di dalam onPressed)
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