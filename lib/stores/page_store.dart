//store responsavel por gerenciar a pagina atual do app

import 'package:mobx/mobx.dart';
part 'page_store.g.dart';

class PageStore = _PageStore with _$PageStore;

abstract class _PageStore with Store {
  /* vai indicar a pagina que está */
  @observable
  int page = 0;

  @action
  void setPage(int value) => page = value;
}
