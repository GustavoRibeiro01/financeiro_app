# Estrutura Recomendada para Módulos

## 📁 Estrutura de Pastas

Para manter o projeto organizado, siga esta estrutura para cada módulo:

\`\`\`
lib/
└── modules/
    └── [nome_do_modulo]/
        ├── [nome_do_modulo]_module.dart       # Configuração do módulo
        ├── [nome_do_modulo]_page.dart         # Página principal
        ├── [nome_do_modulo]_controller.dart   # Lógica de negócio
        ├── widgets/                            # Widgets específicos do módulo
        │   └── custom_widget.dart
        ├── models/                             # Modelos de dados
        │   └── [nome]_model.dart
        └── repositories/                       # Repositórios (opcional)
            └── [nome]_repository.dart
\`\`\`

## 🎯 Exemplo: Módulo de Transações

\`\`\`
lib/
└── modules/
    └── transactions/
        ├── transactions_module.dart
        ├── transactions_page.dart
        ├── transaction_controller.dart
        ├── widgets/
        │   ├── transaction_card.dart
        │   └── transaction_filter.dart
        ├── models/
        │   └── transaction_model.dart
        └── repositories/
            └── transaction_repository.dart
\`\`\`

### transactions_module.dart
\`\`\`dart
import 'package:flutter_modular/flutter_modular.dart';
import 'transaction_controller.dart';
import 'transactions_page.dart';
import 'repositories/transaction_repository.dart';

class TransactionsModule extends Module {
  @override
  void binds(Injector i) {
    // Repositories
    i.addSingleton(() => TransactionRepository());
    
    // Controllers
    i.add(() => TransactionController(i.get()));
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const TransactionsPage());
    r.child('/details/:id', child: (context) => const TransactionDetailsPage());
    r.child('/add', child: (context) => const AddTransactionPage());
  }
}
\`\`\`

### transaction_model.dart
\`\`\`dart
class TransactionModel {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionType type;

  TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      date: DateTime.parse(json['date']),
      type: json['type'] == 'income' 
          ? TransactionType.income 
          : TransactionType.expense,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type == TransactionType.income ? 'income' : 'expense',
    };
  }
}

enum TransactionType { income, expense }
\`\`\`

### transaction_repository.dart
\`\`\`dart
import '../models/transaction_model.dart';

class TransactionRepository {
  // Simulando uma fonte de dados
  final List<TransactionModel> _transactions = [];

  Future<List<TransactionModel>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _transactions;
  }

  Future<TransactionModel?> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _transactions.firstWhere((t) => t.id == id);
  }

  Future<void> add(TransactionModel transaction) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _transactions.add(transaction);
  }

  Future<void> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _transactions.removeWhere((t) => t.id == id);
  }

  Future<void> update(TransactionModel transaction) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      _transactions[index] = transaction;
    }
  }
}
\`\`\`

### transaction_controller.dart
\`\`\`dart
import 'package:flutter/material.dart';
import 'models/transaction_model.dart';
import 'repositories/transaction_repository.dart';

class TransactionController extends ChangeNotifier {
  final TransactionRepository _repository;

  TransactionController(this._repository);

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadTransactions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _transactions = await _repository.getAll();
    } catch (e) {
      _error = 'Erro ao carregar transações: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await _repository.add(transaction);
      await loadTransactions();
    } catch (e) {
      _error = 'Erro ao adicionar transação: $e';
      notifyListeners();
    }
  }

  Future<void> deleteTransaction(String id) async {
    try {
      await _repository.delete(id);
      await loadTransactions();
    } catch (e) {
      _error = 'Erro ao deletar transação: $e';
      notifyListeners();
    }
  }

  double get totalIncome {
    return _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double get balance => totalIncome - totalExpense;
}
\`\`\`

### transactions_page.dart
\`\`\`dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'transaction_controller.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final controller = Modular.get<TransactionController>();

  @override
  void initState() {
    super.initState();
    controller.loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transações'),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return Center(child: Text(controller.error!));
          }

          return Column(
            children: [
              // Card com saldo
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Saldo: R\$ ${controller.balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text('Receitas'),
                              Text(
                                'R\$ ${controller.totalIncome.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Despesas'),
                              Text(
                                'R\$ ${controller.totalExpense.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Lista de transações
              Expanded(
                child: ListView.builder(
                  itemCount: controller.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = controller.transactions[index];
                    return ListTile(
                      title: Text(transaction.description),
                      subtitle: Text(
                        transaction.date.toString().split(' ')[0],
                      ),
                      trailing: Text(
                        'R\$ ${transaction.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: transaction.type == TransactionType.income
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Modular.to.pushNamed(
                          '/transactions/details/${transaction.id}',
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/transactions/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
\`\`\`

## 🔄 Registrando o Módulo no AppModule

Adicione o módulo de transações no \`app_module.dart\`:

\`\`\`dart
import 'package:flutter_modular/flutter_modular.dart';
import '../modules/home/home_module.dart';
import '../modules/transactions/transactions_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // Binds globais
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: HomeModule());
    r.module('/transactions', module: TransactionsModule());
  }
}
\`\`\`

## 🎨 Boas Práticas

1. **Separação de Responsabilidades**: Cada arquivo tem uma responsabilidade única
2. **Injeção de Dependências**: Use DI para facilitar testes e manutenção
3. **Nomenclatura Consistente**: Mantenha padrões de nomenclatura
4. **Organização por Features**: Cada módulo é independente
5. **Reutilização**: Componentes comuns vão em \`lib/shared/\`

## 📂 Estrutura Completa Sugerida

\`\`\`
lib/
├── main.dart
├── app/
│   ├── app_module.dart
│   └── app_widget.dart
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── shared/
│   ├── widgets/
│   ├── models/
│   └── services/
└── modules/
    ├── home/
    ├── auth/
    ├── transactions/
    ├── categories/
    └── reports/
\`\`\`
