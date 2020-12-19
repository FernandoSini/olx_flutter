import 'package:flutter/material.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:readmore/readmore.dart';

class DescriptionPanel extends StatelessWidget {
  DescriptionPanel(this.anuncio);
  final Anuncio anuncio;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Text(
            anuncio.description,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: ReadMoreText(
            anuncio.description,
            trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText: "Ver descrição completa",
            trimExpandedText: "...menos",
            colorClickableText: Colors.blueAccent[700],
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,),
          ),
        ),
      ],
    );
  }
}
