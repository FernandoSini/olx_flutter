import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/repositories/anuncio_repository.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';
part 'meusanuncios_store.g.dart';

class MeusAnunciosStore = _MeusAnunciosStoreBase with _$MeusAnunciosStore;

abstract class _MeusAnunciosStoreBase with Store {
  _MeusAnunciosStoreBase() {
    _getMeusAnuncios();
  }

  /* observando a instancia da lista, e nao as modificacoes, 
  nao vamos adicionar ou remover o item da lista */
  @observable
  List<Anuncio> allMyAds = [];

  /* computed que retorna a lista de ads */
  @computed
  List<Anuncio> get activeAds => allMyAds
      .where((anuncioObject) => anuncioObject.status == AnuncioStatus.ACTIVE)
      .toList();
  List<Anuncio> get pendingAds => allMyAds
      .where((anuncioObject) => anuncioObject.status == AnuncioStatus.PENDING)
      .toList();
  List<Anuncio> get soldAds => allMyAds
      .where((anuncioObject) => anuncioObject.status == AnuncioStatus.SOLD)
      .toList();

  @observable
  String error = "";

  @action

  /* Vai buscar no repositorio as listas de anuncios do meu usuario */
  Future<void> _getMeusAnuncios() async {
    final user = GetIt.I<UserManagerStore>().user;
    try {
      allMyAds = await AnuncioRepository().getMeusAnuncios(user);
    } catch (e) {}
  }
}
