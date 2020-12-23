import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/stores/home_store.dart';
part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }
const VENDOR_TYPE_PARTICULAR = 1 << 0;
//1 DESLOCADO EM 0 como é binario então vc deixa o 0 como normal conforme o binario
const VENDOR_TYPE_PROFESSIONAL = 1 << 1; //aqui é deslocado 1 vez
class FilterStore = _FilterStoreBase with _$FilterStore;

abstract class _FilterStoreBase with Store {
  _FilterStoreBase({
    this.orderBy = OrderBy.DATE,
    this.minPrice,
    this.maxPrice,
    this.vendorType = VENDOR_TYPE_PARTICULAR,
  });
  @observable
  OrderBy orderBy;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @observable
  int minPrice;

  @action
  void setMinPrice(int minValue) => minPrice = minValue;

  @observable
  int maxPrice;

  @action
  void setMaxPrice(int maxValue) => maxPrice = maxValue;

  /* validado caso o valor minimo seja
   igual ao preco minimo ou maximo, nao pode passar os valores */
  @computed
  String get priceError =>
      minPrice != null && maxPrice != null && maxPrice < minPrice
          ? "Faixa de preço inválida!"
          : null;

  @observable
  int vendorType;

  @action
  void selectVendorType(int value) =>
      vendorType = value; // só permite que um seja selecionado
  void setVendorType(int type) =>
      vendorType = vendorType | type; /* permite selecionar mais de 1 */
  void resetVendorType(int type) => vendorType =
      vendorType & ~type; //reset vendor type vai desabilitar só 1 das opções
  @computed
  bool get isTypeParticular => (vendorType & VENDOR_TYPE_PARTICULAR) != 0;
  @computed
  bool get isTypeProfessional => (vendorType & VENDOR_TYPE_PROFESSIONAL) != 0;

  /*validando se são validos os dados*/
  @computed
  bool get isFormValid => priceError == null;

  void save() {
    GetIt.I<HomeStore>().setFilter(this);
  }

  /* clonando a instancia do filterStore para ser buscada e evitar ficar com a o novo filtro ao voltar */
  FilterStore clone() {
    return FilterStore(
      orderBy: orderBy,
      minPrice: minPrice,
      maxPrice: maxPrice,
      vendorType: vendorType,
    );
  }
}
