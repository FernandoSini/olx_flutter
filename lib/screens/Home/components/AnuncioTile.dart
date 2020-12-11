import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:olx_mobx/models/Anuncio.dart';

class AnuncioTile extends StatelessWidget {
  AnuncioTile(this.anuncio);
  final Anuncio anuncio;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              height: 135,
              width: 127,
              child: CachedNetworkImage(
                imageUrl: anuncio.images.first,
              ),
            )
          ],
        ),
      ),
    );
  }
}
