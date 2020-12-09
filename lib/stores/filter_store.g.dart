// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterStore on _FilterStoreBase, Store {
  final _$orderByAtom = Atom(name: '_FilterStoreBase.orderBy');

  @override
  OrderBy get orderBy {
    _$orderByAtom.reportRead();
    return super.orderBy;
  }

  @override
  set orderBy(OrderBy value) {
    _$orderByAtom.reportWrite(value, super.orderBy, () {
      super.orderBy = value;
    });
  }

  final _$_FilterStoreBaseActionController =
      ActionController(name: '_FilterStoreBase');

  @override
  void setOrderBy(OrderBy value) {
    final _$actionInfo = _$_FilterStoreBaseActionController.startAction(
        name: '_FilterStoreBase.setOrderBy');
    try {
      return super.setOrderBy(value);
    } finally {
      _$_FilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orderBy: ${orderBy}
    ''';
  }
}
