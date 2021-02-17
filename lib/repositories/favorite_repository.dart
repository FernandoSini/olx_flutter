import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/models/User.dart';
import 'package:olx_mobx/repositories/parse_errors.dart';
import 'package:olx_mobx/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class FavoriteRepository {
  Future<List<Anuncio>> getAnuncios(User user) async {
    //buscando todos os favoritos desse usuário na tabela de favoritos

    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyFavoritesTable));
    //fazendo a query dentro da tabela de favoritos e trazendo todos os favoritos desse usuario
    queryBuilder.whereEqualTo(keyFavoritesOwner, user.id);

    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      //pegando objeto anuncio dos favoritos e convertendo para um anuncio
      return response.results
          .map((objetoParse) =>
              Anuncio.fromParse(objetoParse.get(keyFavoritesAnuncio)))
          .toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> save({Anuncio anuncio, User user}) async {
    //objeto que será salvo na tabela Favorites
    final favoriteObject = ParseObject(keyFavoritesTable);
    //salvando um id do dono do favorito
    favoriteObject.set<String>(keyFavoritesOwner, user.id);
    //criando um relacionamento para anuncios,buscando o anuncio em si
    favoriteObject.set<ParseObject>(keyFavoritesAnuncio,
        ParseObject(keyAnuncioTable)..set(keyAnuncioid, anuncio.id));

    final response = await favoriteObject.save();

    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> delete({Anuncio anuncio, User user}) async {
    try {
      //buscando todos os favoritos desse usuário
      final queryBuilder =
          QueryBuilder<ParseObject>(ParseObject(keyFavoritesTable));
      //buscando os anuncios favoritos relacionados ao usuario
      queryBuilder.whereEqualTo(keyFavoritesOwner, user.id);
      //e que contenha o ponteiro para os anuncios favoritados
      queryBuilder.whereEqualTo(keyFavoritesAnuncio,
          ParseObject(keyAnuncioTable)..set(keyAnuncioid, anuncio.id));

      //trazendo todos os favoritos relacionados a query
      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        //para cada anuncio vamos deletar o anuncio/procurando o anuncio favoritado e removendo da lista
        for (final f in response.results as List<ParseObject>) {
          await f.delete();
        }
      }
    } catch (e) {
      return Future.error("Falha ao deletar anuncio");
    }
  }
}
