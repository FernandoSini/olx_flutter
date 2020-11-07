import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:olx_mobx/components/error_box.dart';
import 'package:olx_mobx/stores/create_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

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
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            /* fora do widget sempre o margin  */
            margin: const EdgeInsets.symmetric(horizontal: 32),
            /* definindo a borda do card email */
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Observer(
              builder: (_) {
                if (createStore.loading) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Salvando anuncio",
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        )
                      ],
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImagesField(createStore),
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            onChanged: createStore.setTitle,
                            decoration: InputDecoration(
                              labelText: 'Titulo *',
                              labelStyle: labelStyle,
                              contentPadding: contentPadding,
                              errorText: createStore.titleError,
                            ),
                          );
                        },
                      ),
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            onChanged: createStore.setDescription,
                            decoration: InputDecoration(
                                labelText: 'Descrição *',
                                labelStyle: labelStyle,
                                contentPadding: contentPadding,
                                errorText: createStore.descriptionError),
                            maxLines: null,
                          );
                        },
                      ),
                      CategoryField(createStore),
                      CepField(createStore: createStore),
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            onChanged: createStore.setPrice,
                            decoration: InputDecoration(
                              errorText: createStore.priceError,
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
                          );
                        },
                      ),
                      HidePhoneField(createStore: createStore),
                      /* é so para teste Observer(builder: (_) {
                        return ErrorBox(message: createStore.error);
                      }), */
                      Observer(
                        builder: (_) {
                          return SizedBox(
                            height: 50,
                            child: GestureDetector(
                              onTap: createStore.invalidSendPressed,
                              child: RaisedButton(
                                onPressed: createStore.sendPressed,
                                child: Text(
                                  "Enviar",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                textColor: Colors.white,
                                color: Colors.orange,
                                disabledColor: Colors.orange.withAlpha(120),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
