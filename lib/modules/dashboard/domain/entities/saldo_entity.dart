class SaldoEntity {
  final double saldoTotal;
  final double metaMensal;
  final double entradas;
  final double saidas;

  SaldoEntity({
    required this.saldoTotal,
    required this.metaMensal,
    required this.entradas,
    required this.saidas,
  });

  double get percentualMeta => (saldoTotal / metaMensal) * 100;
}
