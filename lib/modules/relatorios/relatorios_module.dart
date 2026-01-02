import 'package:flutter_modular/flutter_modular.dart';
import 'relatorios_page.dart';

class RelatoriosModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const RelatoriosPage());
  }
}
