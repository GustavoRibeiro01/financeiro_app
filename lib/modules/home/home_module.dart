import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';
import 'home_store.dart';
import '../dashboard/dashboard_module.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [DashboardModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton(HomeStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage());
  }
}
