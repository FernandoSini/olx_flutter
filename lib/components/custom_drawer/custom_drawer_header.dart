import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_mobx/screens/Login/LoginScreen.dart';
import 'package:olx_mobx/stores/page_store.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';

class CustomDrawerHeader extends StatelessWidget {
/* buscando a instancia/dados do usuario que foi armazenado no get It */
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();

        if (userManagerStore.isLoggedIn) {
          GetIt.I<PageStore>().setPage(4);
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => LoginScreen()));
        }
      },
      child: Container(
        color: Colors.blueAccent[700],
        height: 95,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(Icons.person, color: Colors.white, size: 35),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userManagerStore.isLoggedIn
                          ? userManagerStore.user.name
                          : 'Acesse sua conta.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      userManagerStore.isLoggedIn
                          ? userManagerStore.user.email
                          : "Clique Aqui!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
