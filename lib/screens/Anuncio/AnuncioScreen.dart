import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:olx_mobx/stores/favorite_store.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';

import 'components/AnunciantePanel.dart';
import 'components/BottomBar.dart';
import 'components/DescriptionPanel.dart';
import 'components/LocationPanel.dart';
import 'components/MainPanel.dart';

class AnuncioScreen extends StatelessWidget {
  AnuncioScreen(this.anuncio);
  final Anuncio anuncio;
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Anúncio"),
        centerTitle: true,
        actions: [
          if (anuncio.status == AnuncioStatus.ACTIVE &&
              userManagerStore.isLoggedIn)
            Observer(builder: (_) {
              //se o favoriteStore contem algum anuncio salvado como favorito
              return IconButton(
                icon: Icon(
                    favoriteStore.favoriteList.any((a) => a.id == anuncio.id)
                        ? Icons.favorite
                        : Icons.favorite_border),
                onPressed: () => favoriteStore.toggleFavorite(anuncio),
              );
            })
        ],
      ),
      body: Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height: 280,
                child: Carousel(
                  images: anuncio.images
                      .map(
                        /* Cached imageprovider evita que fique buscando a imagem no server */
                        (url) => CachedNetworkImageProvider(url),
                      )
                      .toList(),
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.orange,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainPanel(anuncio),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    DescriptionPanel(anuncio),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    LocationPanel(anuncio),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    AnunciantePanel(anuncio),
                    SizedBox(
                      height:
                          anuncio.status == AnuncioStatus.PENDING ? 16 : 120,
                    ),
                  ],
                ),
              ),
            ],
          ),
          BottomBar(anuncio),
        ],
      ),
    );
  }
}
