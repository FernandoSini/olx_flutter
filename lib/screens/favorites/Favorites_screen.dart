import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_mobx/components/Empty_card.dart';
import 'package:olx_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:olx_mobx/stores/favorite_store.dart';

import 'components/FavoriteTile.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({this.hideDrawer = false});
  final bool hideDrawer;

  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        centerTitle: true,
      ),
      drawer: hideDrawer ? null : CustomDrawer(),
      body: Observer(builder: (_) {
        if (favoriteStore.favoriteList.isEmpty)
          return EmptyCard("Nenhum Anuncio Encontrado");

        return ListView.builder(
          padding: const EdgeInsets.all(2),
          itemCount: favoriteStore.favoriteList.length,
          itemBuilder: (_, index) => FavoriteTile(favoriteStore.favoriteList[index]),
        );
      }),
    );
  }
}
