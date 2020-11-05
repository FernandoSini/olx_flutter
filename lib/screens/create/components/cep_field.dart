import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_mobx/stores/cep_store.dart';

class CepField extends StatelessWidget {
  final CepStore cepStore = CepStore();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onChanged: cepStore.setCep,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            //CepInputFormatter()
          ],
          decoration: InputDecoration(
            labelText: 'CEP *',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.grey,
              fontSize: 16,
            ),
            contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
          ),
        ),
        Observer(
          builder: (_) {
            if (cepStore.address == null &&
                cepStore.error == null &&
                !cepStore.loading) {
              return Container();
            } else if (cepStore.address == null && cepStore.error == null) {
              /* indicando que o cep esta completo e carregando. */
              return LinearProgressIndicator();
            } else if (cepStore.error != null) {
              /* vamos exibir o erro */
              return Container(
                color: Colors.red.withAlpha(100),
                height: 50,
                padding: const EdgeInsets.all(8),
                child: Text(
                  cepStore.error,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              );
            } else {
              /* Endereco foi carregado e deu tudo certo */
              final address = cepStore.address;
              return Container(
                color: Colors.blue.withAlpha(150),
                padding: const EdgeInsets.all(8),
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
