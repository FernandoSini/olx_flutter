import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:olx_mobx/repositories/favorite_repository.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';
part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStoreBase with _$FavoriteStore;

abstract class _FavoriteStoreBase with Store {
  //resolvendo o problema do id nulo
  _FavoriteStoreBase() {
    //quando o usuario estiver logado ele vai buscar a lista de favoritos
    //e quando o usuario sair e entrar um outro usuario ele vai trigar a lista de favoritos do outro usuario
    reaction((_) => userManagerStore.isLoggedIn, (_) {
      _getFavoriteList();
    });
  }
  //store responsavel por gerenciar/favoritar/desfavoritar um anuncio
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  ObservableList<Anuncio> favoriteList = ObservableList<Anuncio>();

  @action
  Future<void> _getFavoriteList() async {
    try {
      favoriteList.clear();
      final favorites =
          await FavoriteRepository().getFavoriteAnuncios(userManagerStore.user);
      favoriteList.addAll(favorites);
    } catch (e) {
      print(e);
    }
  }

  //salvando usuario como favorito
  @action
  Future<void> toggleFavorite(Anuncio anuncio) async {
    try {
      //se a lista de anuncios favoritos contem o anuncio
      //com o mesmo id ele vai deletar o id, caso contrario adiciona e favorita
      if (favoriteList.any((a) => a.id == anuncio.id)) {
        favoriteList.removeWhere((element) => element.id == anuncio.id);
        await FavoriteRepository()
            .delete(anuncio: anuncio, user: userManagerStore.user);
      } else {
        favoriteList.add(anuncio);
        await FavoriteRepository()
            .save(anuncio: anuncio, user: userManagerStore.user);
      }
    } catch (e) {
      print(e);
    }
  }
}
