import 'package:flutter_modular/flutter_modular.dart';
import 'data/repositories/dashboard_repository.dart';
import 'domain/repositories/i_dashboard_repository.dart';
import 'domain/usecases/get_saldo_usecase.dart';
import 'domain/usecases/get_transacoes_usecase.dart';
import 'presentation/pages/dashboard_page.dart';
import 'presentation/stores/dashboard_store.dart';

class DashboardModule extends Module {
  @override
  void binds(Injector i) {
    // Repository
    i.add<IDashboardRepository>(DashboardRepository.new);

    // UseCases
    i.add(GetSaldoUseCase.new);
    i.add(GetTransacoesUseCase.new);

    // Store
    i.addLazySingleton(DashboardStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const DashboardPage());
  }
}
