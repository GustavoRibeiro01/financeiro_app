import '../entities/saldo_entity.dart';
import '../repositories/i_dashboard_repository.dart';

class GetSaldoUseCase {
  final IDashboardRepository repository;

  GetSaldoUseCase(this.repository);

  Future<SaldoEntity> call() async {
    return await repository.getSaldo();
  }
}
