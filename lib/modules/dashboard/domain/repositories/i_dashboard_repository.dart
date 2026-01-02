import '../entities/saldo_entity.dart';
import '../entities/transacao_entity.dart';

abstract class IDashboardRepository {
  Future<SaldoEntity> getSaldo();
  Future<List<TransacaoEntity>> getTransacoesRecentes();
  Future<void> atualizarSaldo(SaldoEntity saldo);
}
