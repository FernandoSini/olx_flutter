import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:olx_mobx/components/error_box.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/screens/MeusAnuncios/MeusAnuncios.dart';
import 'package:olx_mobx/stores/create_store.dart';
import 'package:olx_mobx/stores/page_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatefulWidget {
  /* opicional se n receber o anuncio quer dizer que esta criando novo anuncio */
  CreateScreen({this.anuncio});
  final Anuncio anuncio;

  @override
  _CreateScreenState createState() => _CreateScreenState(anuncio);
}

class _CreateScreenState extends State<CreateScreen> {
  /* o anuncio sera passado automaticamente pro store, 
  caso seja opicional o anuncio sera nulo entao temos que passar o novo objeto anuncio */
  _CreateScreenState(Anuncio anuncio)
      /*  */
      : editing = anuncio != null,
        createStore = CreateStore(anuncio ?? Anuncio());
  final CreateStore createStore;
  bool editing;

  @override
  void initState() {
    super.initState();
    when((_) => createStore.savedAnuncio /* != null */, () {
      /* Caso o usúario esteja editando anuncio entao ele vai para a pagina 1 */
      if (editing) {
        /* indicando que o anuncio foi salvo com sucesso */
        Navigator.of(context).pop(true);
      } else {
        //quando o saved store for true, o a pagina será 0
        /* observar a reacao do saved anuncio e realizar uma acao quando tiver 
      uma modificacao ,
       o when é trigado uma vez e n precisa dar dispose*/
        GetIt.I<PageStore>().setPage(0);
        /* ao criar um novo anuncio vamos tambem ir pra tela de anuncio pendente de aprovacao */
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MeusAnuncios(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.grey,
      fontSize: 18,
    );
    final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);
    return Scaffold(
      drawer: editing ? null : CustomDrawer(),
      appBar: AppBar(
        title: Text(editing ? "Editar Anúncio" : "Criar Anúncio"),
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
                            initialValue: createStore.title,
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
                            initialValue: createStore.description,
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
                            initialValue: createStore.priceText,
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
                      /* Observer(builder: (_){
                        return ErrorBox(message: createStore.error,);
                      },), */
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
