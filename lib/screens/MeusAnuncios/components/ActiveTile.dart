import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/helpers/extensions.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile(this.anuncio);
  final Anuncio anuncio;
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
