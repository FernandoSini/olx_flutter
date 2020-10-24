import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:olx_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:olx_mobx/stores/create_store.dart';

import 'category_field.dart';
import 'images_field.dart';

class CreateScreen extends StatelessWidget {
  final CreateStore createStore = CreateStore();
  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.grey,
      fontSize: 18,
    );
    final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Criar Anuncio"),
        centerTitle: true,
      ),
      body: Card(
        clipBehavior: Clip.antiAlias,
        /* fora do widget sempre o margin  */
        margin: const EdgeInsets.symmetric(horizontal: 32),
        /* definindo a borda do card email */
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImagesField(createStore),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Titulo *',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Descrição *',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
              ),
              maxLines: null,
            ),
            CategoryField(createStore),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Preço *',
                labelStyle: labelStyle,
                contentPadding: contentPadding,
                prefixText: 'R\$ ',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter(centavos: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
