import 'package:mobx/mobx.dart';
import '../../domain/entities/saldo_entity.dart';
import '../../domain/entities/transacao_entity.dart';
import '../../domain/usecases/get_saldo_usecase.dart';
import '../../domain/usecases/get_transacoes_usecase.dart';

part 'dashboard_store.g.dart';

class DashboardStore = DashboardStoreBase with _$DashboardStore;

abstract class DashboardStoreBase with Store {
  final GetSaldoUseCase _getSaldoUseCase;
  final GetTransacoesUseCase _getTransacoesUseCase;

  DashboardStoreBase(this._getSaldoUseCase, this._getTransacoesUseCase) {
    carregarDados();
  }

  @observable
  bool saldoVisivel = false;

  @observable
  SaldoEntity? saldo;

  @observable
  ObservableList<TransacaoEntity> transacoes =
      ObservableList<TransacaoEntity>();

  @observable
  bool carregando = false;

  @computed
  double get saldoTotal => saldo?.saldoTotal ?? 0.0;

  @computed
  double get metaMensal => saldo?.metaMensal ?? 0.0;

  @computed
  double get entradas => saldo?.entradas ?? 0.0;

  @computed
  double get saidas => saldo?.saidas ?? 0.0;

  @computed
  double get percentualMeta => saldo?.percentualMeta ?? 0.0;

  @action
  void toggleSaldoVisibilidade() {
    saldoVisivel = !saldoVisivel;
  }

  @action
  Future<void> carregarDados() async {
    carregando = true;
    try {
      saldo = await _getSaldoUseCase();
      transacoes.clear();
      transacoes.addAll(await _getTransacoesUseCase());
    } finally {
      carregando = false;
    }
  }
}
