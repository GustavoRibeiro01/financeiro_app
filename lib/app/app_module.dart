import 'package:flutter_modular/flutter_modular.dart';
import '../modules/home/home_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // Registre aqui os binds globais da aplicação
    // Exemplo: i.addSingleton(() => ApiService());
  }

  @override
  void routes(RouteManager r) {
    // Defina as rotas principais aqui
    r.module('/', module: HomeModule());

    // Exemplo de outros módulos:
    // r.module('/auth', module: AuthModule());
  }
}
