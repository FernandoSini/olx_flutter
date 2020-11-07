import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/repositories/parse_errors.dart';
import 'package:olx_mobx/repositories/table_keys.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class AnuncioRepository {
  Future<Anuncio> save(Anuncio anuncio) async {
    try {
      final parseImages = await saveImages(anuncio.images);

      /* vamos vincular o anuncio ao user */
      final parseUser = await ParseUser.currentUser()
        ..set(keyUserId, anuncio.user.id);

      /* criando o objeto anuncio presente na tabela Anuncio */
      final anuncioObject = ParseObject(keyAnuncioTable);
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
        return Anuncio.fromParse(response.result);
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
}
