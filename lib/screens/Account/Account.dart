import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:olx_mobx/screens/EditAccount/EditAccountScreen.dart';
import 'package:olx_mobx/screens/MeusAnuncios/MeusAnuncios.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Conta"),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          margin: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            GetIt.I<UserManagerStore>().user.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueAccent[700],
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            GetIt.I<UserManagerStore>().user.email,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FlatButton(
                        child: Text(
                          "Editar",
                        ),
                        textColor: Colors.blueAccent[700],
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => EditAccountScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Meus Anúncios",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent[700],
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MeusAnuncios(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  "Favoritos",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent[700],
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
