import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_mobx/screens/Login/LoginScreen.dart';
import 'package:olx_mobx/stores/page_store.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';

import 'PageTile.dart';

class PageSection extends StatelessWidget {
  /* essa instancia pode ser obtida de qualquer lugar do app */
  final PageStore pageStore = GetIt.I<PageStore>();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  @override
  Widget build(BuildContext context) {
    Future<void> verifyLoginAndSetPage(int page) async {
      //se o usuario estiver logado ele acessa a pagina caso contrario não acessará
      if (userManagerStore.isLoggedIn) {
        pageStore.setPage(page);
      } else {
        final result = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => LoginScreen()));
        //caso o usuario esteja logado ele vai para a pagina
        if (result != null && result) pageStore.setPage(page);
      }
    }

    return Column(
      children: [
        PageTile(
          label: 'Anúncios',
          iconData: Icons.list,
          onTap: () {
            pageStore.setPage(0);
          },
          highlighted: pageStore.page == 0,
        ),
        PageTile(
          label: 'Inserir Anúncio',
          iconData: Icons.edit,
          onTap: () {
            // pageStore.setPage(1);
            verifyLoginAndSetPage(1);
          },
          highlighted: pageStore.page == 1,
        ),
        PageTile(
          label: 'Chat',
          iconData: Icons.chat,
          onTap: () {
            //pageStore.setPage(2);
            verifyLoginAndSetPage(2);
          },
          highlighted: pageStore.page == 2,
        ),
        PageTile(
          label: 'Favoritos',
          iconData: Icons.favorite,
          onTap: () {
            // pageStore.setPage(3);
            verifyLoginAndSetPage(3);
          },
          highlighted: pageStore.page == 3,
        ),
        PageTile(
          label: 'Minha Conta',
          iconData: Icons.person,
          onTap: () {
            //pageStore.setPage(4);
            verifyLoginAndSetPage(4);
          },
          highlighted: pageStore.page == 4,
        ),
      ],
    );
  }
}
