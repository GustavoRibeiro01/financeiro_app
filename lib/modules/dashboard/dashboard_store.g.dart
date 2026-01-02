// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DashboardStore on _DashboardStoreBase, Store {
  Computed<double>? _$percentualMetaComputed;

  @override
  double get percentualMeta => (_$percentualMetaComputed ??= Computed<double>(
    () => super.percentualMeta,
    name: '_DashboardStoreBase.percentualMeta',
  )).value;

  late final _$saldoVisivelAtom = Atom(
    name: '_DashboardStoreBase.saldoVisivel',
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

  late final _$saldoTotalAtom = Atom(
    name: '_DashboardStoreBase.saldoTotal',
    context: context,
  );

  @override
  double get saldoTotal {
    _$saldoTotalAtom.reportRead();
    return super.saldoTotal;
  }

  @override
  set saldoTotal(double value) {
    _$saldoTotalAtom.reportWrite(value, super.saldoTotal, () {
      super.saldoTotal = value;
    });
  }

  late final _$metaMensalAtom = Atom(
    name: '_DashboardStoreBase.metaMensal',
    context: context,
  );

  @override
  double get metaMensal {
    _$metaMensalAtom.reportRead();
    return super.metaMensal;
  }

  @override
  set metaMensal(double value) {
    _$metaMensalAtom.reportWrite(value, super.metaMensal, () {
      super.metaMensal = value;
    });
  }

  late final _$entradasAtom = Atom(
    name: '_DashboardStoreBase.entradas',
    context: context,
  );

  @override
  double get entradas {
    _$entradasAtom.reportRead();
    return super.entradas;
  }

  @override
  set entradas(double value) {
    _$entradasAtom.reportWrite(value, super.entradas, () {
      super.entradas = value;
    });
  }

  late final _$saidasAtom = Atom(
    name: '_DashboardStoreBase.saidas',
    context: context,
  );

  @override
  double get saidas {
    _$saidasAtom.reportRead();
    return super.saidas;
  }

  @override
  set saidas(double value) {
    _$saidasAtom.reportWrite(value, super.saidas, () {
      super.saidas = value;
    });
  }

  late final _$_DashboardStoreBaseActionController = ActionController(
    name: '_DashboardStoreBase',
    context: context,
  );

  @override
  void toggleSaldoVisibilidade() {
    final _$actionInfo = _$_DashboardStoreBaseActionController.startAction(
      name: '_DashboardStoreBase.toggleSaldoVisibilidade',
    );
    try {
      return super.toggleSaldoVisibilidade();
    } finally {
      _$_DashboardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
saldoVisivel: ${saldoVisivel},
saldoTotal: ${saldoTotal},
metaMensal: ${metaMensal},
entradas: ${entradas},
saidas: ${saidas},
percentualMeta: ${percentualMeta}
    ''';
  }
}
