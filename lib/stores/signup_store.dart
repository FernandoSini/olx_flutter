import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/helpers/extensions.dart';
import 'package:olx_mobx/models/User.dart';
import 'package:olx_mobx/repositories/user_repository.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';
part 'signup_store.g.dart';

class SignUpStore = _SignUpStore with _$SignUpStore;

abstract class _SignUpStore with Store {
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
  String phone;

  @action
  void setPhone(String phoneValue) => phone = phoneValue;

/* monitorando o telefone, e caso tenha erro vai exibir uma mensagem */
  @computed
  bool get phoneValid =>
      phone != null &&
      phone.length >= 14; /* validando/verificando se o campo é valido */
  String get phoneError {
    if (phone == null || phoneValid) {
      return null;
    } else if (phone.isEmpty) {
      return 'Field needed';
    } else {
      return "Phone inválid";
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

  @observable
  String verifyPass;

  @action
  void setVerifyPass(String passVerifyValue) => verifyPass = passVerifyValue;

/* monitorando o password, e caso tenha erro vai exibir uma mensagem */
  @computed
  bool get passVerificationValid =>
      verifyPass != null &&
      verifyPass == pass; /* validando/verificando se o campo é valido */
  String get verifyPassError {
    if (verifyPass == null || passVerificationValid) {
      return null;
    } else if (verifyPass.isEmpty) {
      return 'Field needed';
    } else {
      return "Password inválid";
    }
  }

/* verifiying if the form is valid to able the button to click */
  @computed
  bool get isFormValid =>
      nameValid && emailValid && passValid && passVerificationValid;

/* verifiying if the form is valid and it is not loading, will call the signUp function*/
  @computed
  Function get signUpPressed => (isFormValid && !loading) ? _signUp : null;

  @observable
  bool loading = false;
  @action
  void setLoading(bool loadingValue) => loading = loadingValue;

  @observable
  String error;

  @action
  Future<void> _signUp() async {
    loading = true;
    /* deixando um tempo de duração de criacao da conta */

    /* criando uma instancia nova do userRpository */
    final user = User(name: name, email: email, phone: phone, password: pass);

    try {
      final userData = await UserRepository().signUp(user);
      /* Pegando a instancia do user via get It, salvando os dados do usuario dentro do manager store */
      GetIt.I<UserManagerStore>().setUser(userData);
    } catch (e) {
      error = e;
    }

    loading = false;
  }
}
