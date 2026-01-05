import 'package:flutter_modular/flutter_modular.dart';
import '../modules/auth/auth_module.dart';
import '../modules/home/home_module.dart';
import 'guards/auth_guard.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // Registre aqui os binds globais da aplicação
    // Exemplo: i.addSingleton(() => ApiService());
  }

  @override
  void routes(RouteManager r) {
    // Defina as rotas principais aqui
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule(), guards: [AuthGuard()]);

    // Rota inicial redireciona para auth
    r.redirect('/', to: '/auth/');
  }
}
