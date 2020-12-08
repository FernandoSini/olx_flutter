import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:olx_mobx/screens/Home/components/TopBar.dart';
import 'package:olx_mobx/stores/home_store.dart';

import 'components/SearchDialog.dart';

class HomeScreen extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();
/* metodo que vai abrir a caixa de pesquisa */
  openSearch(BuildContext context) async {
    /* vamos abrir um dialogo que vai exibir um campo de pesquisa */
    final search = await showDialog(
      context: context,
      builder: (_) => SearchDialog(
        currentSearch:
            homeStore.search, /* deixando a barra de pesquisa já preenchida */
      ),
    );
    if (search != null) {
      homeStore.setSearch(search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Observer(
            builder: (_) {
              if (homeStore.search.isEmpty) {
                return Container(
                  height: 0,
                  width: 0,
                );
              } else {
                return GestureDetector(
                  /* constraints vai definir qual o tamanho minimo e o maximo podem ter */
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        width: constraints.biggest.width,
                        child: Text(homeStore.search),
                      );
                    },
                  ),
                  onTap: () => openSearch(context),
                );
              }
            },
          ),
          actions: [
            Observer(
              builder: (_) {
                if (homeStore.search.isEmpty) {
                  return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      openSearch(context);
                    },
                  );
                } else {
                  return IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      homeStore.setSearch('');
                    },
                  );
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TopBar(),
          ],
        ),
      ),
    );
  }
}
