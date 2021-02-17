import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mobx/mobx.dart';
part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStoreBase with _$ConnectivityStore;

abstract class _ConnectivityStoreBase with Store {
  //verificando a conectividade do app, caso tenha conexao com algum server ele vai considerar online se n offline
  _ConnectivityStoreBase() {
    _setupListener();
  }

  _setupListener() {
    //mudando o tempo de verificar a conexão
    DataConnectionChecker().checkInterval = Duration(seconds: 5);
    //toda vez que tiver uma modificacao do evento/status ele irá passar o dado do evento
    DataConnectionChecker().onStatusChange.listen((event) {
      //as duas formas são iguais e gerarão o mesmo resultado só que a de cima usa 1 linha só
      setConnected(event == DataConnectionStatus.connected);
      // if (event == DataConnectionStatus.connected) {
      //   setConnected(true);
      // }
    });
  }

  @observable
  bool connected = true;

  @action
  void setConnected(bool value) => connected = value;
}
