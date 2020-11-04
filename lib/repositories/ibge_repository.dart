import 'package:dio/dio.dart';
import 'package:olx_mobx/models/Cidades.dart';
import 'package:olx_mobx/models/Estados.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class IBGERepository {
  /* Repositorio responsavel por cuidar dos dados e manipular os dados da api do ibge */

  /* Buscando os estados */
  Future<List<Estados>> getEstadosfromApi() async {
    final preferences = await SharedPreferences.getInstance();

    /* caso tenha dados em cache ele vai ler eles */
    if (preferences.containsKey("Lista_Estados")) {
      print('found cache');
      /* buscando a lista gravada e decodificando ela */
      final jsonListaEstados = json.decode(preferences.get("Lista_Estados"));
      return jsonListaEstados
          .map<Estados>((jsonData) => Estados.fromJson(jsonData))
          .toList()
            /* comparando a com b para fazer em ordem alfabetica */
            ..sort(
                (Estados a, Estados b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    }

    print("not found on cache");

    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final response = await Dio().get<List>(endpoint);

      /* salvando a lista codificada  /* salvando os dados em cache */*/
      preferences.setString("Lista_Estados", json.encode(response.data));

      return response.data
          .map<Estados>((jsonData) => Estados.fromJson(jsonData))
          .toList()
            /* comparando a com b para fazer em ordem alfabetica */
            ..sort(
                (a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    } on DioError {
      return Future.error('Falha ao obter lista de estados');
    }
  }

  /* Buscando a cidade  */

  Future<List<Cidade>> getCityfromApi(Estados estados) async {
    try {
      final String endpoint =
          'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${estados.id}/municipios';
      final response = await Dio().get<List>(endpoint);

      return response.data
          .map<Cidade>((jsonData) => Cidade.fromJson(jsonData))
          .toList()
            /* comparando a com b para fazer em ordem alfabetica */
            ..sort(
                (a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    } on DioError {
      return Future.error('Falha Ao obter a lista de Cidades');
    }
  }
}
