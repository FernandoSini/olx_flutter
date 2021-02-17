import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/stores/connectivity_store.dart';

class OfflineScreen extends StatefulWidget {
  @override
  _OfflineScreenState createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  //tratando caso tenha voltado a conexão
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //monitorando quando a conexão voltar
    //quando a conexão tiver voltado ele vai voltar pra tela

    when((_) => connectivityStore.connected, () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    //willpopScope + automaticallyImply leading vao evitar o gesto de voltar
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text('XLO'),
          centerTitle: true,
          //evita o botao em cima do lado do title
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Text(
                  "Without connection with internet!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Icon(
              Icons.cloud_off,
              color: Colors.white,
              size: 150,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                "Please, check it out the connection with internet to keep using our services or app",
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
