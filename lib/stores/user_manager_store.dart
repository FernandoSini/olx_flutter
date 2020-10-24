import 'package:mobx/mobx.dart';
import 'package:olx_mobx/models/User.dart';
import 'package:olx_mobx/repositories/user_repository.dart';
part 'user_manager_store.g.dart';

/* this store will manage the user data after login */
class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  _UserManagerStore() {
    _getCurrentUser();
  }

  @observable
  User user;

  @action
  void setUser(User userData) => user = userData;

  @computed
  bool get isLoggedIn => user != null;

  Future<void> _getCurrentUser() async {
    var user = await UserRepository().currentUser();
    /* if has user logged in, we ill set user */
    setUser(user);
  }
}
