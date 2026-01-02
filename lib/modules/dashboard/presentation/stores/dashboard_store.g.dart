// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardStore on DashboardStoreBase, Store {
  Computed<double>? _$saldoTotalComputed;

  @override
  double get saldoTotal => (_$saldoTotalComputed ??= Computed<double>(
    () => super.saldoTotal,
    name: 'DashboardStoreBase.saldoTotal',
  )).value;
  Computed<double>? _$metaMensalComputed;

  @override
  double get metaMensal => (_$metaMensalComputed ??= Computed<double>(
    () => super.metaMensal,
    name: 'DashboardStoreBase.metaMensal',
  )).value;
  Computed<double>? _$entradasComputed;

  @override
  double get entradas => (_$entradasComputed ??= Computed<double>(
    () => super.entradas,
    name: 'DashboardStoreBase.entradas',
  )).value;
  Computed<double>? _$saidasComputed;

  @override
  double get saidas => (_$saidasComputed ??= Computed<double>(
    () => super.saidas,
    name: 'DashboardStoreBase.saidas',
  )).value;
  Computed<double>? _$percentualMetaComputed;

  @override
  double get percentualMeta => (_$percentualMetaComputed ??= Computed<double>(
    () => super.percentualMeta,
    name: 'DashboardStoreBase.percentualMeta',
  )).value;

  late final _$saldoVisivelAtom = Atom(
    name: 'DashboardStoreBase.saldoVisivel',
    context: context,
  );

  @override
  bool get saldoVisivel {
    _$saldoVisivelAtom.reportRead();
    return super.saldoVisivel;
  }

  @override
  set saldoVisivel(bool value) {
    _$saldoVisivelAtom.reportWrite(value, super.saldoVisivel, () {
      super.saldoVisivel = value;
    });
  }

  late final _$saldoAtom = Atom(
    name: 'DashboardStoreBase.saldo',
    context: context,
  );

  @override
  SaldoEntity? get saldo {
    _$saldoAtom.reportRead();
    return super.saldo;
  }

  @override
  set saldo(SaldoEntity? value) {
    _$saldoAtom.reportWrite(value, super.saldo, () {
      super.saldo = value;
    });
  }

  late final _$transacoesAtom = Atom(
    name: 'DashboardStoreBase.transacoes',
    context: context,
  );

  @override
  ObservableList<TransacaoEntity> get transacoes {
    _$transacoesAtom.reportRead();
    return super.transacoes;
  }

  @override
  set transacoes(ObservableList<TransacaoEntity> value) {
    _$transacoesAtom.reportWrite(value, super.transacoes, () {
      super.transacoes = value;
    });
  }

  late final _$carregandoAtom = Atom(
    name: 'DashboardStoreBase.carregando',
    context: context,
  );

  @override
  bool get carregando {
    _$carregandoAtom.reportRead();
    return super.carregando;
  }

  @override
  set carregando(bool value) {
    _$carregandoAtom.reportWrite(value, super.carregando, () {
      super.carregando = value;
    });
  }

  late final _$carregarDadosAsyncAction = AsyncAction(
    'DashboardStoreBase.carregarDados',
    context: context,
  );

  @override
  Future<void> carregarDados() {
    return _$carregarDadosAsyncAction.run(() => super.carregarDados());
  }

  late final _$DashboardStoreBaseActionController = ActionController(
    name: 'DashboardStoreBase',
    context: context,
  );

  @override
  void toggleSaldoVisibilidade() {
    final _$actionInfo = _$DashboardStoreBaseActionController.startAction(
      name: 'DashboardStoreBase.toggleSaldoVisibilidade',
    );
    try {
      return super.toggleSaldoVisibilidade();
    } finally {
      _$DashboardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
saldoVisivel: ${saldoVisivel},
saldo: ${saldo},
transacoes: ${transacoes},
carregando: ${carregando},
saldoTotal: ${saldoTotal},
metaMensal: ${metaMensal},
entradas: ${entradas},
saidas: ${saidas},
percentualMeta: ${percentualMeta}
    ''';
  }
}
