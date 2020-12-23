import 'package:olx_mobx/models/Address.dart';
import 'package:olx_mobx/models/Category.dart';
import 'package:olx_mobx/models/Cidades.dart';
import 'package:olx_mobx/models/Estados.dart';
import 'package:olx_mobx/models/User.dart';
import 'package:olx_mobx/repositories/table_keys.dart';
import 'package:olx_mobx/repositories/user_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'Address.dart';
import 'Category.dart';
import 'User.dart';

enum AnuncioStatus { PENDING, ACTIVE, SOLD, DELETED }

class Anuncio {
  /* Convertendo um anuncio gerado pelo parse para um objeto anuncio */
  Anuncio.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAnuncioTitle);
    description = object.get<String>(keyAnuncioDescription);
    images = object
        .get<List>(keyAnuncioImagens)
        .map((e) => e.url)
        .toList(); /* mapeando cada imagem/parsefiles para sua url */
    hidePhone = object.get<bool>(keyAnuncioHidePhone);
    createdDate = object.createdAt;
    address = Address(
      district: object.get<String>(keyAnuncioDistrict),
      cidade: Cidade(nome: object.get<String>(keyAnuncioCidade)),
      cep: object.get<String>(keyAnuncioCep),
      estado: Estados(sigla: object.get<String>(keyAnuncioEstado)),
    );
    views = object.get<int>(keyAnuncioViews, defaultValue: 0);
    price = object.get<num>(keyAnuncioPrice);
    user = UserRepository()
        .convertParseToUser(object.get<ParseUser>(keyAnuncioAnunciante));
    category = Category.fromParse(object.get<ParseObject>(keyAnuncioCategory));
    status = AnuncioStatus.values[object.get<int>(keyAnuncioStatus)];
  }
  Anuncio();

  String id;
  List images = [];
  String title;
  String description;
  Category category;
  Address address;
  num price;
  bool hidePhone = false;
  AnuncioStatus status = AnuncioStatus.PENDING;
  DateTime createdDate;

  User user;
  int views;
}
