// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EditAccountStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditAccountStore on _EditAccountStoreBase, Store {
  Computed<bool> _$nameIsvalidComputed;

  @override
  bool get nameIsvalid =>
      (_$nameIsvalidComputed ??= Computed<bool>(() => super.nameIsvalid,
              name: '_EditAccountStoreBase.nameIsvalid'))
          .value;
  Computed<bool> _$phoneIsValidComputed;

  @override
  bool get phoneIsValid =>
      (_$phoneIsValidComputed ??= Computed<bool>(() => super.phoneIsValid,
              name: '_EditAccountStoreBase.phoneIsValid'))
          .value;
  Computed<bool> _$passIsValidComputed;

  @override
  bool get passIsValid =>
      (_$passIsValidComputed ??= Computed<bool>(() => super.passIsValid,
              name: '_EditAccountStoreBase.passIsValid'))
          .value;
  Computed<bool> _$isAllRequirementsValidComputed;

  @override
  bool get isAllRequirementsValid => (_$isAllRequirementsValidComputed ??=
          Computed<bool>(() => super.isAllRequirementsValid,
              name: '_EditAccountStoreBase.isAllRequirementsValid'))
      .value;
  Computed<VoidCallback> _$savePressedComputed;

  @override
  VoidCallback get savePressed =>
      (_$savePressedComputed ??= Computed<VoidCallback>(() => super.savePressed,
              name: '_EditAccountStoreBase.savePressed'))
          .value;

  final _$userTypeAtom = Atom(name: '_EditAccountStoreBase.userType');

  @override
  UserType get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(UserType value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
    });
  }

  final _$nameAtom = Atom(name: '_EditAccountStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$phoneAtom = Atom(name: '_EditAccountStoreBase.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$pass1Atom = Atom(name: '_EditAccountStoreBase.pass1');

  @override
  String get pass1 {
    _$pass1Atom.reportRead();
    return super.pass1;
  }

  @override
  set pass1(String value) {
    _$pass1Atom.reportWrite(value, super.pass1, () {
      super.pass1 = value;
    });
  }

  final _$pass2Atom = Atom(name: '_EditAccountStoreBase.pass2');

  @override
  String get pass2 {
    _$pass2Atom.reportRead();
    return super.pass2;
  }

  @override
  set pass2(String value) {
    _$pass2Atom.reportWrite(value, super.pass2, () {
      super.pass2 = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EditAccountStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$_saveDataAsyncAction = AsyncAction('_EditAccountStoreBase._saveData');

  @override
  Future<void> _saveData() {
    return _$_saveDataAsyncAction.run(() => super._saveData());
  }

  final _$_EditAccountStoreBaseActionController =
      ActionController(name: '_EditAccountStoreBase');

  @override
  void setUserType(int value) {
    final _$actionInfo = _$_EditAccountStoreBaseActionController.startAction(
        name: '_EditAccountStoreBase.setUserType');
    try {
      return super.setUserType(value);
    } finally {
      _$_EditAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_EditAccountStoreBaseActionController.startAction(
        name: '_EditAccountStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_EditAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_EditAccountStoreBaseActionController.startAction(
        name: '_EditAccountStoreBase.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_EditAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass1(String value) {
    final _$actionInfo = _$_EditAccountStoreBaseActionController.startAction(
        name: '_EditAccountStoreBase.setPass1');
    try {
      return super.setPass1(value);
    } finally {
      _$_EditAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass2(String value) {
    final _$actionInfo = _$_EditAccountStoreBaseActionController.startAction(
        name: '_EditAccountStoreBase.setPass2');
    try {
      return super.setPass2(value);
    } finally {
      _$_EditAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userType: ${userType},
name: ${name},
phone: ${phone},
pass1: ${pass1},
pass2: ${pass2},
loading: ${loading},
nameIsvalid: ${nameIsvalid},
phoneIsValid: ${phoneIsValid},
passIsValid: ${passIsValid},
isAllRequirementsValid: ${isAllRequirementsValid},
savePressed: ${savePressed}
    ''';
  }
}
