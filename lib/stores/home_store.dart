import 'package:olx_mobx/models/Category.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  String search = "";

  @action
  void setSearch(String value) => search = value;

  /* mostrando a categoria selecionada */
  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;
}
