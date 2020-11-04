import 'package:dio/dio.dart';
import 'package:olx_mobx/models/Address.dart';
import 'package:olx_mobx/models/Cidades.dart';
import 'package:olx_mobx/repositories/ibge_repository.dart';

class CepRepository {
  Future<Address> getAddressFromApi(String cep) async {
    if (cep == null || cep.isEmpty) {
      return Future.error("Cep Inválido0");
    }

    /* limpando os dados caso esteja de preenchido de 0 a 9 */

    final clearCep = cep; /* .replaceAll(RegExp("[ˆ0-9]"), ''); */
    if (clearCep.length != 8) {
      return Future.error("Cep Inválido1");
    }

    final endpoint = "https://viacep.com.br/ws/$clearCep/json";

    try {
      /* o dado que vai ser retornado vai ser um map */
      final response = await Dio().get<Map>(endpoint);

      /* se o cep for inválido mas conter os 8 numeros então vamos retornar um erro */
      if (response.data.containsKey('erro') && response.data['erro']) {
        return Future.error("Cep Inválido2");
      }

      /*  obtendo a lista de estados*/
      final estadoList = await IBGERepository().getEstadosfromApi();

      return Address(
        cep: response.data["cep"],
        district: response.data["bairro"],
        cidade: Cidade(
          nome: response.data["localidade"],
        ),
        estado: estadoList
            .firstWhere((element) => element.sigla == response.data["uf"]),
      );
    } catch (e) {
      return Future.error('Falha ao Buscar Cep');
    }
  }
}
