import '../entities/transacao_entity.dart';
import '../repositories/i_dashboard_repository.dart';

class GetTransacoesUseCase {
  final IDashboardRepository repository;

  GetTransacoesUseCase(this.repository);

  Future<List<TransacaoEntity>> call() async {
    return await repository.getTransacoesRecentes();
  }
}
