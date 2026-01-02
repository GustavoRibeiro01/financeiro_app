import '../../domain/entities/saldo_entity.dart';
import '../../domain/entities/transacao_entity.dart';
import '../../domain/repositories/i_dashboard_repository.dart';

class DashboardRepository implements IDashboardRepository {
  @override
  Future<SaldoEntity> getSaldo() async {
    // Simulando busca de dados (futuramente pode vir de API ou banco local)
    await Future.delayed(const Duration(milliseconds: 300));
    
    return SaldoEntity(
      saldoTotal: 8429.50,
      metaMensal: 13000.00,
      entradas: 4250.00,
      saidas: 1820.50,
    );
  }

  @override
  Future<List<TransacaoEntity>> getTransacoesRecentes() async {
    // Simulando busca de dados
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      TransacaoEntity(
        id: '1',
        titulo: 'Supermercado',
        categoria: 'Alimentação',
        valor: 236.80,
        isDespesa: true,
        icone: 'shopping_cart',
        data: DateTime.now().subtract(const Duration(days: 1)),
      ),
      TransacaoEntity(
        id: '2',
        titulo: 'Netflix',
        categoria: 'Entretenimento',
        valor: 39.90,
        isDespesa: true,
        icone: 'movie',
        data: DateTime.now().subtract(const Duration(days: 2)),
      ),
      TransacaoEntity(
        id: '3',
        titulo: 'Salário',
        categoria: 'Receita',
        valor: 4250.00,
        isDespesa: false,
        icone: 'attach_money',
        data: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }

  @override
  Future<void> atualizarSaldo(SaldoEntity saldo) async {
    // Implementação futura para atualizar saldo
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
