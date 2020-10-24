import 'package:mobx/mobx.dart';
import 'package:olx_mobx/models/Category.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  /* vamos guardar todos as imagens do anuncio na lista */
  ObservableList imageList = ObservableList();

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;
}
