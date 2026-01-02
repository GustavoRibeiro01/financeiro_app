import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../dashboard/presentation/pages/dashboard_page.dart';
import '../tags/tags_page.dart';
import '../relatorios/relatorios_page.dart';
import '../perfil/perfil_page.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F2E),
      body: Stack(
        children: [
          PageView(
            controller: store.pageController,
            onPageChanged: store.onPageChanged,
            children: [
              DashboardPage(),
              TagsPage(),
              RelatoriosPage(),
              PerfilPage(),
            ],
          ),
          _buildFloatingBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildFloatingBottomNavigationBar() {
    return Observer(
      builder: (_) => Positioned(
        left: 0,
        right: 0,
        bottom: 25,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF252B3B),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(icon: Icons.dashboard_outlined, index: 0),
                _buildNavItem(icon: Icons.local_offer_outlined, index: 1),
                _buildNavItem(icon: Icons.bar_chart_outlined, index: 2),
                _buildNavItem(icon: Icons.person_outline, index: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required int index}) {
    final isSelected = store.currentIndex == index;
    return GestureDetector(
      onTap: () => store.setCurrentIndex(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2196F3) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white54,
          size: 26,
        ),
      ),
    );
  }
}
