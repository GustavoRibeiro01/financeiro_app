class TransacaoEntity {
  final String id;
  final String titulo;
  final String categoria;
  final double valor;
  final bool isDespesa;
  final String icone;
  final DateTime data;

  TransacaoEntity({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.valor,
    required this.isDespesa,
    required this.icone,
    required this.data,
  });
}
