import 'package:mobx/mobx.dart';
import 'package:olx_mobx/models/Address.dart';
import 'package:olx_mobx/models/Category.dart';
import 'package:olx_mobx/stores/cep_store.dart';
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
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get isTitleValid => title.length >= 6;
  String get titleError {
    if (isTitleValid) {
      return null;
    } else if (title.isEmpty) {
      return "Campo Obrigatorio";
    } else {
      return "Titulo muito curto";
    }
  }

  @observable
  String description = "";

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get isDescriptionValid => description.length >= 10;
  String get descriptionError {
    if (isDescriptionValid) {
      return null;
    } else if (description.isEmpty) {
      return "Campo Obrigatorio";
    } else {
      return "Descricao muito curta";
    }
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get isCategoryValid => category != null;
  String get categoryError {
    if (isCategoryValid) {
      return null;
    } else {
      return "Campo Obrigatório";
    }
  }

  CepStore cepStore = CepStore();

  @computed
  Address get address => cepStore.address;
  bool get isAddressValid => address != null;
  String get addressError {
    if (isAddressValid) {
      return null;
    } else {
      return "Campo Obrigatório";
    }
  }

  @observable
  String priceText = "";

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num get price {
    /* tratando um caso o numero tenha virgula, é um bug da biblioteca */
    if (priceText.contains(',')) {
      return num.tryParse(priceText.replaceAll(RegExp('[\.\,]'), '')) / 100;
    } else {
      /* se não vamos retornar só o numero */
      return num.tryParse(priceText);
    }
  }

  bool get isPriceValid => price != null && price <= 9999999;
  String get priceError {
    if (isPriceValid) {
      return null;
    } else if (priceText.isEmpty) {
      return 'Campo Obrigatório';
    } else {
      return "Preco Inválido";
    }
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool value) => hidePhone = value;

/* validando o formulário todo */
  @computed
  bool get isFormValid =>
      imagesValid &&
      isTitleValid &&
      isDescriptionValid &&
      isCategoryValid &&
      isAddressValid &&
      isPriceValid;

  @computed
  Function get sendPressed => isFormValid ? _send : null;

  void _send(){

  }
}
