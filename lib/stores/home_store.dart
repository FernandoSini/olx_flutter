import 'package:get_it/get_it.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/models/Category.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/repositories/anuncio_repository.dart';
import 'package:olx_mobx/stores/connectivity_store.dart';

import 'filter_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  //fazendo com que a tela home seja carregada quando tiver reconexão
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
/* usando o autorun pra monitorar o search category e o filter */
  _HomeStoreBase() {
    autorun((_) async {
      connectivityStore.connected;
      try {
        setLoading(true);
        final newAnuncios = await AnuncioRepository().getHomeAnuncioList(
          filter: filter,
          /* quando qualuqer um dos 3 forem modificados o autorun será rodado e ira buscar uma nova lista de anuncio baseado nos 3 requisitos */
          search: search,
          category: category,
          page: page,
        );
        addNovosAnuncios(newAnuncios);
        /*  listaAnuncios.addAll(
            newAnuncios); //monitorando a lista caso tenha alguma mudanca */
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
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  /* mostrando a categoria selecionada */
  @observable
  Category category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  /*vai aplicar/definir os filtros   */
  @observable
  FilterStore filter = FilterStore();
  /* vamos arrumar um bug que ao alterar o filtro e clicar pra voltar ele esteje com o filtro antigo */
  /* metodo que retorna o filtroStore */
  FilterStore get clonedFilter => filter.clone();

  @action
  void setFilter(FilterStore filterValue) {
    filter = filterValue;
    resetPage();
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  /* vai fazer o loading enquanto busca os dados */
  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  /* paginacao, caso n tenha dados carrega mais dados da outra pagina */
  @observable
  int page = 0;

  /* carregar os anuncios da proxima pagina */
  @action
  void loadNextPage() {
    page++;
  }

  @observable
  bool lastPage = false;

  @action
  void addNovosAnuncios(List<Anuncio> novosAnuncios) {
    print("maconha das brabas ${novosAnuncios.length}");
    /* se o tamanho da lista for menor que 10 siginifica que ja chegou no final, n tem mais item pra adicionar */
    if (novosAnuncios.length < 10) lastPage = true;
    listaAnuncios.addAll(novosAnuncios);
  }

  /* vai permitir adicionar mais um item que será o de loading na hora de carregar a pagina */
  @computed
  int get itemCount =>
      lastPage ? listaAnuncios.length : listaAnuncios.length + 1;

  void resetPage() {
    page = 0;
    listaAnuncios.clear();
    lastPage = false;
  }

/* arrumando um erro entre os loadings pra só chamar o circular indicator quando tiver nada */
  @computed
  bool get showProgress => loading && listaAnuncios.isEmpty;
}
