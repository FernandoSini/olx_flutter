import 'package:mobx/mobx.dart';
import 'package:olx_mobx/models/User.dart';
part 'user_manager_store.g.dart';

/* this store will manage the user data after login */
class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  @observable
  User user;

  @action
  void setUser(User userData) => user = userData;

  @computed
  bool get isLoggedIn => user != null;
}
