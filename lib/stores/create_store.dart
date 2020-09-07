import 'package:mobx/mobx.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  /* vamos guardar todos as imagens do anuncio na lista */
  ObservableList imageList = ObservableList();
}
