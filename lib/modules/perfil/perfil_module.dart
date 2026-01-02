import 'package:flutter_modular/flutter_modular.dart';
import 'perfil_page.dart';

class PerfilModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const PerfilPage());
  }
}
