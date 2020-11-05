import 'package:mobx/mobx.dart';
import 'package:olx_mobx/repositories/cep_repository.dart';
import 'package:olx_mobx/models/Address.dart';
part 'cep_store.g.dart';

class CepStore = _CepStore with _$CepStore;

abstract class _CepStore with Store {
  _CepStore() {
    /* adicionando uma reacao caso o clearcep for vazio ou diferente de 8*/
    autorun((_) {
      if (clearCep.length != 8) {
        _reset();
      } else {
        /* caso esteja completo vamos procurar no repository */
        _searchCep();
      }
    });
  }

  @observable
  String cep = "";

  @action
  void setCep(String value) => cep = value;

  @computed
  String get clearCep => cep.replaceAll(RegExp("[\&\-\.']"), '');

  @observable
  Address address;

  @observable
  String error;

  @observable
  bool loading = false;

  @action
  Future<void> _searchCep() async {
    loading = true;
    try {
      /* buscando o cep no repository */
      address = await CepRepository().getAddressFromApi(clearCep);
      error = null;
    } catch (e) {
      error = e;
      address = null;
    }
    loading = false;
  }

  @action
  void _reset() {
    /* vai resetar os campos  a partir da mudanca do cep */
    address = null;
    error = null;
  }
}
