import 'package:olx_mobx/models/Address.dart';
import 'package:olx_mobx/models/Category.dart';
import 'package:olx_mobx/models/User.dart';
import 'Address.dart';
import 'Category.dart';
import 'User.dart';

enum AnuncioStatus { PENDING, ACTIVE, SOLD, DELETED }

class Anuncio {
  String id;
  List images;
  String title;
  String description;
  Category category;
  Address address;
  num price;
  bool hidePhone;
  AnuncioStatus status = AnuncioStatus.PENDING;
  DateTime createdDate;

  User user;
  int views;
}
