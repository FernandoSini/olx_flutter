import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_mobx/repositories/category_repository.dart';
import 'package:olx_mobx/repositories/cep_repository.dart';
import 'package:olx_mobx/repositories/ibge_repository.dart';
import 'package:olx_mobx/stores/category_store.dart';
import 'package:olx_mobx/stores/page_store.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'screens/base/BaseScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _inicializarParse();
  setupLocators();
  runApp(MyApp());

  CepRepository().getAddressFromApi('04148050').then((value) => print(value));
}

Future<void> _inicializarParse() async {
  await Parse().initialize('CtMlLVBee2oUMMHGVBpzoSvY4L7J04zphBy8zWfM',
      'https://parseapi.back4app.com/',
      clientKey: 'kNyMNOxK7MxuGnxStVSY5aoz0wKQ3ZpIIO32e7bP',
      autoSendSessionId: true,
      /* evita ficar perguntando quem é no app salva sessão */
      debug: true);
}

/* função que irá localizar os servicos do app como page store */
void setupLocators() {
  /* Só pode ter um get_it no projeto, singleton é um objeto que só pode existir uma vez no projeto */
  GetIt.I.registerSingleton(PageStore());
  /* com isso o UserManageStore que é responsavel por manipular os dados do usuário podem ser acessados de qualquer parte do app */
  /* ou seja os dados do usuário podem ser acessados de qualquer parte do app*/
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'olx_mobx',
      theme: ThemeData(
          primaryColor: Colors.blueAccent[700],
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.blueAccent[700],
          cursorColor: Colors.black,
          appBarTheme: AppBarTheme(
            elevation: 0,
          )),
      home: BaseScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
