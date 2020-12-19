import 'package:flutter/material.dart';
import 'package:olx_mobx/models/Anuncio.dart';

class LocationPanel extends StatelessWidget {
  LocationPanel(this.anuncio);
  final Anuncio anuncio;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 18),
          child: Text(
            "Localização",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text("CEP"),
                  SizedBox(
                    height: 12,
                  ),
                  Text("Municipio"),
                  SizedBox(
                    height: 12,
                  ),
                  Text("Bairro")
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text("${anuncio.address.cep}"),
                    const SizedBox(
                      height: 12,
                    ),
                    Text("${anuncio.address.cidade.nome}"),
                    const SizedBox(
                      height: 12,
                    ),
                    Text("${anuncio.address.district}"),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
