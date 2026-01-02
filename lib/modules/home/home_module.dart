import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';
import 'home_store.dart';
import '../dashboard/dashboard_store.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(HomeStore.new);
    i.addLazySingleton(DashboardStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage());
  }
}
