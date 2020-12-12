import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/helpers/extensions.dart';

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
                imageUrl: anuncio.images.isEmpty
                    ? 'https://static.thenounproject.com/png/194055-200.png'
                    : anuncio.images.first,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      anuncio.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${anuncio.price.formattedMoney()}',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${anuncio.createdDate.formattedDate()} - '
                      '${anuncio.address.cidade.nome} -'
                      '${anuncio.address.estado.sigla}',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
