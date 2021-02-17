import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/models/Category.dart';
import 'package:olx_mobx/repositories/category_repository.dart';

import 'connectivity_store.dart';
part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  //fazendo com que a tela home seja carregada quando tiver reconexão
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  /* Aqui no category store será armazenado as categories para que quando
   o app seja reiniciado os dados atualizados sejem recuperados */
  _CategoryStore() {
    autorun((_) {
      if (connectivityStore.connected && categoryList.isEmpty) {
        _loadCategories();
      }
    });
  }

  ObservableList<Category> categoryList = ObservableList<Category>();
/* vai trazer uma categoria + uma categoria extra chamada todos */

  @computed
  /* vai pegar a lista de categorias e copiar ela e adicionar uma categoria nova na lista */
  List<Category> get allCategoryList => List.from(categoryList)
    ..insert(0, Category(id: '*', description: 'Todas'));
  @action
  void setCategories(List<Category> categories) {
    categoryList.clear(); /* limpando para não ter categorias duplicadas */
    categoryList.addAll(categories); /* adicionando as categorias na lista */
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryRepository().getList();
      /* definindo categorias */
      setCategories(categories);
    } catch (e) {
      setError(e);
    }
  }
}
