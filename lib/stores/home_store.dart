import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/models/Category.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/repositories/anuncio_repository.dart';

import 'filter_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
/* usando o autorun pra monitorar o search category e o filter */
  _HomeStoreBase() {
    autorun((_) async {
      try {
        setLoading(true);
        final newAnuncios = await AnuncioRepository().getHomeAnuncioList(
          filter: filter,
          /* quando qualuqer um dos 3 forem modificados o autorun será rodado e ira buscar uma nova lista de anuncio baseado nos 3 requisitos */
          search: search,
          category: category,
        );
        listaAnuncios.clear();
        listaAnuncios.addAll(
            newAnuncios); //monitorando a lista caso tenha alguma mudanca
        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e.toString());
      }
    });
  }
  /* Lista observavel de anuncios,  */
  ObservableList<Anuncio> listaAnuncios = ObservableList<Anuncio>();

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

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  /* vai fazer o loading enquanto busca os dados */
  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;
}
