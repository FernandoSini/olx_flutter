import 'package:mobx/mobx.dart';
import 'package:olx_mobx/screens/filter/components/OrderByField.dart';
part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }
class FilterStore = _FilterStoreBase with _$FilterStore;

abstract class _FilterStoreBase with Store {
  @observable
  OrderBy orderBy = OrderBy.DATE;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;
}
