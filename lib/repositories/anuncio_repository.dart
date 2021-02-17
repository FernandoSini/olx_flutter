import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/models/Category.dart';
import 'package:olx_mobx/models/User.dart';
import 'package:olx_mobx/repositories/parse_errors.dart';
import 'package:olx_mobx/repositories/table_keys.dart';
import 'package:olx_mobx/stores/filter_store.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class AnuncioRepository {
  Future<List<Anuncio>> getHomeAnuncioList(
      {FilterStore filter, String search, Category category, int page}) async {
    //tratando o erro da conexão
    try {
      final queryBuilder =
          QueryBuilder<ParseObject>(ParseObject(keyAnuncioTable));
      /* trazendo os anuncios ativos */
      queryBuilder.whereEqualTo(keyAnuncioStatus, AnuncioStatus.ACTIVE.index);

      /* exibindo um limite de quantidade anuncios */
      queryBuilder.setLimit(10);
      /* pegando as paginas e aplicando na query, 
      pulando uma quantidade de itens que é o numero da pagina * a quantidade de itens */
      queryBuilder.setAmountToSkip(page * 10);

      /* devemos incluir os objetos que queremos/ de nosso interesse */
      queryBuilder.includeObject([keyAnuncioAnunciante, keyAnuncioCategory]);

      /* verificando se o search não é nulo ou vazio */
      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyAnuncioTitle, search,
            caseSensitive: false);
      }
      /* filtrando por categoria, onde o id da categoria seja o igual a categoria da busca */
      if (category != null && category.id != '*') {
        queryBuilder.whereEqualTo(
          keyAnuncioCategory,
          (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
              .toPointer(),
        );
      }
      /* ordenando a partir dos dados do filtro */
      switch (filter.orderBy) {
        case OrderBy.PRICE:
          /* ordenando pelo preco em ordem crescente */
          queryBuilder.orderByAscending(keyAnuncioPrice);
          break;
        case OrderBy.DATE:
        /* ordenando por data */
        default:
          queryBuilder.orderByDescending(keyAnuncioCreatedAt);
          break;
      }
      /* filtro pelo preco */
      if (filter.minPrice != null && filter.minPrice > 0) {
        queryBuilder.whereGreaterThanOrEqualsTo(
            keyAnuncioPrice, filter.minPrice);
      }
      if (filter.maxPrice != null && filter.maxPrice > 0) {
        queryBuilder.whereLessThanOrEqualTo(keyAnuncioPrice, filter.maxPrice);
      }
      /* GARANTIR SE UM DOS DOIS ESTÁ SELECIONADO NO MINIMO, E NO MAXIMO OS 2 ESTAO SELECIONADOS */
      if (filter.vendorType != null &&
          filter.vendorType > 0 &&
          filter.vendorType <
              VENDOR_TYPE_PROFESSIONAL | VENDOR_TYPE_PARTICULAR) {
        /* TEMOS QUE FAZER UMA SUBQUERY DENTRO DOS USUARIOS 
        PARA BUSCAR OS USUARIOS(QUE SAO PROFISSIONAIS OU PARITCULARS)
        PARA FAZER UM MATCH ENTRE VENDEDOR E O COMPRADOR, 
        OU SEJA TEMOS QUE FAZER UMA QUERY PARA ACESSAR O PONTEIRO PRA VERIFICAR O TIPO DE USUARIO*/

        final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());
        if (filter.vendorType == VENDOR_TYPE_PARTICULAR) {
          /* so mostre vendedor do tipo particular */
          userQuery.whereEqualTo(keyUserType, UserType.PARTICULAR.index);
        }
        if (filter.vendorType == VENDOR_TYPE_PROFESSIONAL) {
          userQuery.whereEqualTo(keyUserType, UserType.PROFESSIONAL.index);
        }
        queryBuilder.whereMatchesQuery(keyAnuncioAnunciante, userQuery);
      }

      final response = await queryBuilder.query();
      if (response.success && response.results != null) {
        return response.results
            .map((anuncioObject) => Anuncio.fromParse(anuncioObject))
            .toList();
      } else if (response.success && response.results == null) {
        /* caso a seja nulo vamos retornar uma lista vazia, 
        pois ele pode procurar um anuncio que não de match com a lista*/
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error("Connection error!");
    }
  }

  Future<void> save(Anuncio anuncio) async {
    try {
      final parseImages = await saveImages(anuncio.images);

      /* vamos vincular o anuncio ao user */
      final parseUser = await ParseUser.currentUser()
        ..set(keyUserId, anuncio.user.id);

      /* criando o objeto anuncio presente na tabela Anuncio */
      final anuncioObject = ParseObject(keyAnuncioTable);

      //caso esteja(salvando um anuncio existente) editando um anuncio,defina o object id como o id do anuncio editado;
      if (anuncio.id != null) anuncioObject.objectId = anuncio.id;

      /* alterando a permissao de edicao do objeto */
      final parseAcl = ParseACL(owner: parseUser);
      /* permitindo que qualquer um leia os dados do anuncio */
      parseAcl.setPublicReadAccess(allowed: true);
      /* mas não permitindo alterar os dados */
      parseAcl.setPublicWriteAccess(allowed: false);
      anuncioObject.setACL(parseAcl);

      anuncioObject.set<String>(keyAnuncioTitle, anuncio.title);
      anuncioObject.set<String>(keyAnuncioDescription, anuncio.description);
      anuncioObject.set<bool>(keyAnuncioHidePhone, anuncio.hidePhone);
      anuncioObject.set<num>(keyAnuncioPrice, anuncio.price);
      anuncioObject.set<int>(keyAnuncioStatus, anuncio.status.index);

      anuncioObject.set<String>(keyAnuncioDistrict, anuncio.address.district);
      anuncioObject.set<String>(keyAnuncioCidade, anuncio.address.cidade.nome);
      anuncioObject.set<String>(keyAnuncioEstado, anuncio.address.estado.sigla);
      anuncioObject.set<String>(keyAnuncioCep, anuncio.address.cep);

      anuncioObject.set<List<ParseFile>>(keyAnuncioImagens, parseImages);

      anuncioObject.set<ParseUser>(keyAnuncioAnunciante, parseUser);
      anuncioObject.set<ParseObject>(
          keyAnuncioCategory,
          ParseObject(keyCategoryTable)
            ..set(keyCategoryId, anuncio.category.id));
      final response = await anuncioObject.save();
      if (response.success) {
        return; //Anuncio.fromParse(response.result);
      } else {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error("Falha ao salvar anuncio");
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    /* aqui vamos tratar quando for colocar uma nova imagem
     na lista/ editar o anuncio com uma nova imagem  pra evitar misturar de file com url*/
    final parseImages = <ParseFile>[];
    try {
      for (final image in images) {
        if (image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          /* salvando a imagem no banco */
          final response = await parseFile.save();
          /* caso de erro no upload */
          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error.code));
          }
          parseImages.add(parseFile);
        } else {
          /* caso a imagem seja uma url salva no parse nos vamos informar o caminho da imagem */
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    } catch (e) {
      return Future.error("Falha ao salvar os dados");
    }
  }

  Future<List<Anuncio>> getMeusAnuncios(User user) async {
    /* fazendo referencia para buscar um usuario no banco a partir do id */
    final currentUser = ParseUser('', '', '')..set(keyUserId, user.id);

    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyAnuncioTable));

    queryBuilder.setLimit(100);
    queryBuilder.orderByDescending(keyAnuncioCreatedAt);
    /* onde o anunciante é um pointer para o usuario que quer buscar os anuncios */
    queryBuilder.whereEqualTo(keyAnuncioAnunciante, currentUser.toPointer());
    queryBuilder.includeObject([keyAnuncioCategory, keyAnuncioAnunciante]);

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return response.results
          .map((anuncioObject) => Anuncio.fromParse(anuncioObject))
          .toList();
    } else if (response.success && response.results == null) {
      /* caso a seja nulo vamos retornar uma lista vazia, 
      pois ele pode procurar um anuncio que não de match com a lista*/
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<void> sold(Anuncio anuncio) async {
    //pegando a referencia do objeto que será marcado como vendido
    final parseObject = ParseObject(keyAnuncioTable)
      ..set(keyAnuncioid, anuncio.id);
    parseObject.set(keyAnuncioStatus, AnuncioStatus.SOLD.index);

    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  //VAMOS DELETAR NO CASO SUMIR PRA TODO MUNDO E SÓ NOS ADMIM PODEMOS VER
  Future<void> delete(Anuncio anuncio) async {
    //pegando a referencia do objeto que será marcado como vendido
    final parseObject = ParseObject(keyAnuncioTable)
      ..set(keyAnuncioid, anuncio.id);
    parseObject.set(keyAnuncioStatus, AnuncioStatus.DELETED.index);

    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }
}
