import 'package:olx_mobx/models/Category.dart';
import 'package:mobx/mobx.dart';

import 'filter_store.dart';
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

  /*vai aplicar/definir os filtros   */
  @observable
  FilterStore filter = FilterStore();
  /* vamos arrumar um bug que ao alterar o filtro e clicar pra voltar ele esteje com o filtro antigo */
  /* metodo que retorna o filtroStore */
  FilterStore get clonedFilter => filter.clone();

  @action
  void setFilter(FilterStore filterValue) => filter = filterValue;
}
