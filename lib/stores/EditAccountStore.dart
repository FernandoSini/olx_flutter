import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/models/User.dart';
import 'package:olx_mobx/repositories/user_repository.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';

part 'EditAccountStore.g.dart';

class EditAccountStore = _EditAccountStoreBase with _$EditAccountStore;

abstract class _EditAccountStoreBase with Store {
  _EditAccountStoreBase() {
    //deixando os dados do usuário já carregados
     user = userManagerStore.user;

    userType = user.type;
     name = user.name;
     print(name);
    phone = user.phone;
  }

  User user;

  //deixando os dados do usuário já carregados
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @observable
  UserType userType;

  @action
  void setUserType(int value) => userType = UserType.values[value];

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameIsvalid => name != null && name.length >= 6;

  String get nameError =>
      nameIsvalid || name == null ? null : "Campo obrigatório";

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneIsValid => phone != null && phone.length >= 14;

  String get phoneError =>
      phoneIsValid || phone == null ? null : "Campo Obrigatório";

  @observable
  String pass1 = '';

  @action
  void setPass1(String value) => pass1 = value;

  @observable
  String pass2 = '';

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get passIsValid =>
      pass1 == pass2 && (pass1.length >= 6 || pass1.isEmpty);

  String get passError {
    if (pass1.isNotEmpty && pass1.length < 6) {
      return "Senha muito Curta!";
    } else if (pass1 != pass2) {
      return "Senhas não batem";
    } else {
      return null;
    }
  }

  @computed
  bool get isAllRequirementsValid => nameIsvalid && phoneIsValid && passIsValid;

  @observable
  bool loading = false;

  @computed
  VoidCallback get savePressed =>
      (isAllRequirementsValid && !loading) ? _saveData : null;

  @action
  Future<void> _saveData() async {
    loading = true;
    //pegando os dados atualizados
    print("caindo no teste da maconha" + name);

    user.name = name;
    user.phone = phone;
    user.type = userType;
    //salvando a senha caso tenha alterado a senha
    if (pass1.isNotEmpty) {
      user.password = pass1;
    } else {
      user.password = null;
    }
    try {
      await UserRepository().saveUpdatedUser(user);
      userManagerStore.setUser(user);
    } catch (e) {
      print(e);
    }
    loading = false;
  }
}
