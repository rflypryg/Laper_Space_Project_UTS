import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'models/cart.dart'; 
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/reservasi_screen.dart';
import 'screens/about_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const LaperSpaceApp(),
    ),
  );
}

class LaperSpaceApp extends StatelessWidget {
  const LaperSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaperSpace',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
        ),
        navigationRailTheme: NavigationRailThemeData(
          selectedIconTheme: const IconThemeData(color: Colors.orange),
          selectedLabelTextStyle: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          unselectedLabelTextStyle: const TextStyle(color: Colors.black87),
        )
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/': (context) => const MainNavigationShell(), 
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class NavItemData {
  final String label;
  final IconData icon;
  final Widget screen;

  const NavItemData({
    required this.label,
    required this.icon,
    required this.screen,
  });
}

class MainNavigationShell extends StatefulWidget {
  final int initialIndex;
  const MainNavigationShell({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationShell> createState() => MainNavigationShellState();
}

class MainNavigationShellState extends State<MainNavigationShell> {
  late int _selectedIndex;

  final List<NavItemData> _navItemsData = const [
    NavItemData(label: 'Home', icon: Icons.home, screen: HomeScreen()),
    NavItemData(label: 'Menu', icon: Icons.restaurant_menu, screen: MenuScreen()),
    NavItemData(label: 'Cart', icon: Icons.shopping_cart, screen: CartScreen()), 
    NavItemData(label: 'Reservasi', icon: Icons.table_bar, screen: ReservasiScreen()),
    NavItemData(label: 'Contact', icon: Icons.phone, screen: ContactUsScreen()), 
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  Widget _buildCartIcon(BuildContext context, bool isSelected) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final itemCount = cart.itemCount;
        final color = isSelected ? Colors.orange : Colors.grey;

        return Stack(
          alignment: Alignment.center,
          children: [
            Icon(_navItemsData[2].icon, color: color), // Icon Cart
            if (itemCount > 0)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    itemCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(NavItemData item, int index) {
    if (item.label == 'Cart') {
      return BottomNavigationBarItem(
        icon: _buildCartIcon(context, _selectedIndex == index),
        label: item.label,
      );
    }
    return BottomNavigationBarItem(icon: Icon(item.icon), label: item.label);
  }

  NavigationRailDestination _buildRailDestination(NavItemData item, int index) {
    if (item.label == 'Cart') {
      return NavigationRailDestination(
        icon: _buildCartIcon(context, _selectedIndex == index),
        selectedIcon: _buildCartIcon(context, true), 
        label: Text(item.label),
      );
    }
    return NavigationRailDestination(
      icon: Icon(item.icon),
      selectedIcon: Icon(item.icon, color: Colors.orange),
      label: Text(item.label),
    );
  }


  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    final List<Widget> screens = _navItemsData.map((item) => item.screen).toList();
    final List<BottomNavigationBarItem> bottomNavItems = 
        _navItemsData.asMap().entries.map((entry) => _buildBottomNavItem(entry.value, entry.key)).toList();
    final List<NavigationRailDestination> railDestinations = 
        _navItemsData.asMap().entries.map((entry) => _buildRailDestination(entry.value, entry.key)).toList();

    return Scaffold(
      body: Row(
        children: [
          if (!isMobile)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              labelType: NavigationRailLabelType.selected,
              destinations: railDestinations,
            ),
  
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: screens,
            ),
          ),
        ],
      ),

      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
              items: bottomNavItems,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 12,
            )
          : null,
    );
  }
}
