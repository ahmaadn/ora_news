import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_typography.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Fungsi ini dipanggil saat item di BottomNavigationBar ditekan
  void _onItemTapped(int index) {
    widget.navigationShell.goBranch(
      index,
      // Jika kita kembali ke tab yang sudah aktif, jangan reset state-nya
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTypography.caption.copyWith(
          fontWeight: AppTypography.semiBold,
        ),
        unselectedLabelStyle: AppTypography.caption,
        currentIndex: widget.navigationShell.currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
