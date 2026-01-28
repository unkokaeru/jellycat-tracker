import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'features/catalog/presentation/pages/catalog_page.dart';
import 'features/collection/presentation/pages/my_collection_page.dart';
import 'features/wishlist/presentation/pages/wishlist_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: JellycatTrackerApp(),
    ),
  );
}

/// Root application widget
class JellycatTrackerApp extends StatelessWidget {
  const JellycatTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const MainNavigationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Main navigation page with bottom navigation bar
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    CatalogPage(),
    MyCollectionPage(),
    WishlistPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: AppStrings.navCatalog,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: AppStrings.navCollection,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: AppStrings.navWishlist,
          ),
        ],
      ),
    );
  }
}
