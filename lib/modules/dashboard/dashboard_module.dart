import 'package:flutter_modular/flutter_modular.dart';
import 'dashboard_page.dart';

class DashboardModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const DashboardPage());
  }
}
