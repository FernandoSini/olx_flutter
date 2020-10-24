import 'package:olx_mobx/models/Category.dart';
import 'package:olx_mobx/repositories/parse_errors.dart';
import 'package:olx_mobx/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CategoryRepository {
  /* get list irá retornar a lista que está no parse server */
  Future<List<Category>> getList() async {
    /* buscando os dados em ordem alfabética */
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyCategoryDescription);

/* executando a query */
    final response = await queryBuilder.query();

    /* se a query for executada com sucesso ele vai retornar o objeto categorias */
    /* só que não vamos retornar os parse objects e sim os modelos(models) definidos */
    if (response.success) {
      /* transformando os resultados obtidos (em parseobject) para objetos category e adicionando eles em uma lista  */
      /* retornando categorias */
      return response.results
          .map((objeto) => Category.fromParse(objeto))
          .toList();
    } else {
      /* caso dê erro vamos disparar essa excessão */
      throw ParseErrors.getDescription(response.error.code);
    }
  }
}
