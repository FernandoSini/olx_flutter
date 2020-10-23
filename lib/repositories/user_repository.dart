/*  aqui no user repository vamos vincular tudo o que for relacionado ao usuario como login, logout, salvar info atualizadas, poderemos usar isso em outras apis ou backends*/

import 'package:olx_mobx/models/User.dart';
import 'package:olx_mobx/repositories/parse_errors.dart';
import 'package:olx_mobx/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserRepository {
  /* creating a user */
  Future<User> signUp(User user) async {
    /* creating a user on parse */
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index);

    final response = await parseUser.signUp();

    /* tratando a resposta */
    if (response.success) {
      return convertParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> currentUser() async {
    /* getting user data (from user logged) */
    final parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      /* verifiyng if session token is valid we ill get the user from server */
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      /* verifiyng if is valid, we will get the userData, else we ill logout the user from app/server */
      if (response.success) {
        return convertParseToUser(response.result);
      } else {
        await parseUser.logout();
      }
    }
    return null;
  }

/* convertendo ao usuario para ser retornado */
  User convertParseToUser(ParseUser parseUser) {
    return User(
        id: parseUser.objectId,
        name: parseUser.get(keyUserName),
        email: parseUser.get(keyUserEmail),
        phone: parseUser.get(keyUserPhone),
        type: UserType.values[parseUser.get(keyUserType)],
        createdAt: parseUser.get(keyUserCreatedAt));
  }

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();
    /* if login was successefully  we ill return user*/
    if (response.success) {
      return convertParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }
}
