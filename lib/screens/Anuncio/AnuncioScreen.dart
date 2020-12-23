import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'components/AnunciantePanel.dart';
import 'components/BottomBar.dart';
import 'components/DescriptionPanel.dart';
import 'components/LocationPanel.dart';
import 'components/MainPanel.dart';

class AnuncioScreen extends StatelessWidget {
  AnuncioScreen(this.anuncio);
  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Anúncio"),
        centerTitle: true,
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
