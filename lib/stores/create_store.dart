import 'package:mobx/mobx.dart';
import 'package:olx_mobx/models/Category.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  /* vamos guardar todos as imagens do anuncio na lista */
  ObservableList imageList = ObservableList();

  @computed /* esse computed vai informar se as imagens são validas */
  bool get imagesValid => imageList.isNotEmpty;
  String get imagesError {
    if (imagesValid)
      return null;
    else
      return 'Insira Imagens';
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool value) => hidePhone = value;
}
