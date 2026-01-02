import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../dashboard/dashboard_page.dart';
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
  final HomeStore store = HomeStore();

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F2E),
      body: PageView(
        controller: store.pageController,
        onPageChanged: store.onPageChanged,
        children: [DashboardPage(), TagsPage(), RelatoriosPage(), PerfilPage()],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Observer(
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF252B3B),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: store.currentIndex,
          onTap: store.setCurrentIndex,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Visão Geral',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Tags',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Relatórios',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}
