import 'package:mobx/mobx.dart';

part 'dashboard_store.g.dart';

class DashboardStore = _DashboardStoreBase with _$DashboardStore;

abstract class _DashboardStoreBase with Store {
  @observable
  bool saldoVisivel = false;

  @observable
  double saldoTotal = 8429.50;

  @observable
  double metaMensal = 13000.00;

  @observable
  double entradas = 4250.00;

  @observable
  double saidas = 1820.50;

  @computed
  double get percentualMeta => (saldoTotal / metaMensal) * 100;

  @action
  void toggleSaldoVisibilidade() {
    saldoVisivel = !saldoVisivel;
  }
}
