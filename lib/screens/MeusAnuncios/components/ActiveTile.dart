import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/helpers/extensions.dart';
import 'package:olx_mobx/screens/Anuncio/AnuncioScreen.dart';
import 'package:olx_mobx/screens/MeusAnuncios/MeusAnuncios.dart';
import 'package:olx_mobx/screens/create/create_screen.dart';
import 'package:olx_mobx/stores/meusanuncios_store.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile(this.anuncio, this.meusAnunciosStore);

  final Anuncio anuncio;
  final MeusAnunciosStore meusAnunciosStore ;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: "Editar", iconData: Icons.edit),
    MenuChoice(index: 1, title: "Vendido", iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: "Excluir", iconData: Icons.delete)
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AnuncioScreen(anuncio),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Container(
          height: 80,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: anuncio.images.isEmpty
                      ? 'https://static.thenounproject.com/png/194055-200.png'
                      : anuncio.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        anuncio.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        anuncio.price.formattedMoney(),
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      Text(
                        "${anuncio.views} views",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  PopupMenuButton<MenuChoice>(
                    onSelected: (choice) {
                      switch (choice.index) {
                        case 0:
                          editarAnuncio(context);
                          break;
                        case 1:
                          break;
                        case 2:
                          break;
                      }
                    },
                    icon: Icon(
                      Icons.more_vert,
                      size: 30,
                      color: Colors.blueAccent[700],
                    ),
                    itemBuilder: (_) {
                      return choices
                          .map(
                            (choice) => PopupMenuItem<MenuChoice>(
                              value: choice,
                              child: Row(
                                children: [
                                  Icon(
                                    choice.iconData,
                                    size: 20,
                                    color: Colors.blueAccent[700],
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    choice.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blueAccent[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editarAnuncio(BuildContext context) async {
    final success = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateScreen(
          anuncio: anuncio,
        ),
      ),
    );
    if (success != null && success) {
      //irá atualizar a tela caso de certo ao editar anuncio
      meusAnunciosStore.refresh();
    }
  }
}

class MenuChoice {
  MenuChoice({this.index, this.title, this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
