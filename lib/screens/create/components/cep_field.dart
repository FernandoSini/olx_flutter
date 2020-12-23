import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_mobx/stores/cep_store.dart';
import 'package:olx_mobx/stores/create_store.dart';

class CepField extends StatelessWidget {
  /* Inicializando o cepstore como createStore.cepstore, ou seja o cepStore será
   pego diretamente da createStore.
   e mais pra frente será usado a mesma tela para editar um anuncio */
  CepField({this.createStore}) : cepStore = createStore.cepStore;
  final CreateStore createStore;
  final CepStore cepStore;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(builder: (_) {
          return TextFormField(
            initialValue: cepStore.cep,
            onChanged: cepStore.setCep,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter()
            ],
            decoration: InputDecoration(
              labelText: 'CEP *',
              errorText: createStore.addressError,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.grey,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
            ),
          );
        }),
        Observer(
          builder: (_) {
            if (cepStore.address == null &&
                cepStore.error == null &&
                !cepStore.loading) {
              return Container();
            } else if (cepStore.address == null && cepStore.error == null) {
              /* indicando que o cep esta completo e carregando. */
              return LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                backgroundColor: Colors.transparent,
              );
            } else if (cepStore.error != null) {
              /* vamos exibir o erro */
              return Container(
                color: Colors.red.withAlpha(100),
                height: 50,
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  cepStore.error,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              /* Endereco foi carregado e deu tudo certo */
              final address = cepStore.address;
              return Container(
                color: Colors.blue.withAlpha(150),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  "Localizacao : ${address.district}, ${address.cidade.nome} - ${address.estado.sigla}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
