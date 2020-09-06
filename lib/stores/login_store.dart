import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/helpers/extensions.dart';
import 'package:olx_mobx/repositories/user_repository.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String name;

  @action
  void setName(String nameValue) => name = nameValue;

/* monitorando o nome, e caso tenha erro vai exibir uma mensagem */
  @computed
  bool get nameValid =>
      name != null &&
      name.length > 6; /* validando/verificando se o campo é valido */
  String get nameError {
    if (name == null || nameValid) {
      return null;
    } else if (name.isEmpty) {
      return 'Campo Obrigatório';
    } else {
      return "Nome muito curto";
    }
  }

  @observable
  String email;

  @action
  void setEmail(String emailValue) => email = emailValue;

/* monitorando o email, e caso tenha erro vai exibir uma mensagem */
  @computed
  bool get emailValid =>
      email != null &&
      email.isEmailValid(); /* validando/verificando se o campo é valido */
  String get emailError {
    if (email == null || emailValid) {
      return null;
    } else if (email.isEmpty) {
      return 'Campo Obrigatório';
    } else {
      return "Email inválid";
    }
  }

  @observable
  String pass;

  @action
  void setPass(String passValue) => pass = passValue;

/* monitorando o password, e caso tenha erro vai exibir uma mensagem */
  @computed
  bool get passValid =>
      pass != null &&
      pass.length >= 6; /* validando/verificando se o campo é valido */
  String get passError {
    if (pass == null || passValid) {
      return null;
    } else if (pass.isEmpty) {
      return 'Field needed';
    } else {
      return "Password inválid";
    }
  }

  @computed
  Function get loginPressed =>
      emailValid && passValid && !loading ? _login : null;

  @observable
  bool loading = false;

  @observable
  String error;

  @action
  Future<void> _login() async {
    loading = true;

    try {
      final user = await UserRepository().loginWithEmail(email, pass);
      /* Pegando a instancia do user via get It, salvando os dados do usuario dentro do manager store */
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      /* caso dê erro vamos retornar uma mensagem no front */
      error = e;
      print(e);
    }

    loading = false;
  }
}
