// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meusanuncios_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeusAnunciosStore on _MeusAnunciosStoreBase, Store {
  Computed<List<Anuncio>> _$activeAdsComputed;

  @override
  List<Anuncio> get activeAds =>
      (_$activeAdsComputed ??= Computed<List<Anuncio>>(() => super.activeAds,
              name: '_MeusAnunciosStoreBase.activeAds'))
          .value;

  final _$allMyAdsAtom = Atom(name: '_MeusAnunciosStoreBase.allMyAds');

  @override
  List<Anuncio> get allMyAds {
    _$allMyAdsAtom.reportRead();
    return super.allMyAds;
  }

  @override
  set allMyAds(List<Anuncio> value) {
    _$allMyAdsAtom.reportWrite(value, super.allMyAds, () {
      super.allMyAds = value;
    });
  }

  final _$errorAtom = Atom(name: '_MeusAnunciosStoreBase.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$_getMeusAnunciosAsyncAction =
      AsyncAction('_MeusAnunciosStoreBase._getMeusAnuncios');

  @override
  Future<void> _getMeusAnuncios() {
    return _$_getMeusAnunciosAsyncAction.run(() => super._getMeusAnuncios());
  }

  @override
  String toString() {
    return '''
allMyAds: ${allMyAds},
error: ${error},
activeAds: ${activeAds}
    ''';
  }
}
