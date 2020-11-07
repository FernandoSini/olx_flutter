import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/models/Address.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/models/Category.dart';
import 'package:olx_mobx/repositories/anuncio_repository.dart';
import 'package:olx_mobx/stores/cep_store.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  /* vamos guardar todos as imagens do anuncio na lista */
  ObservableList imageList = ObservableList();

  @computed /* esse computed vai informar se as imagens são validas */
  bool get imagesValid => imageList.isNotEmpty;
  String get imagesError {
    if (!showErrors || imagesValid)
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
    if (!showErrors || isTitleValid) {
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
    if (!showErrors || isDescriptionValid) {
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
    if (!showErrors || isCategoryValid) {
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
    if (!showErrors || isAddressValid) {
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
    if (!showErrors || isPriceValid) {
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

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @observable
  Anuncio savedAnuncio;

  @action
  Future<void> _send() async {
    final anuncio = Anuncio();

    anuncio.title = title;
    anuncio.description = description;
    anuncio.category = category;
    anuncio.price = price;
    anuncio.hidePhone = hidePhone;
    anuncio.images = imageList;
    anuncio.address = address;
    anuncio.user = GetIt.I<UserManagerStore>().user;

    /*  /* forcaondo o erro do errorbox  testando somente*/
    error = 'Falha ao salvar';
    return; */

    loading = true;

    try {
       savedAnuncio = await AnuncioRepository().save(anuncio);
    } catch (e) {
      error = e;
    }
    loading = false;
  }
}
