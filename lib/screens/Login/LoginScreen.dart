import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/components/error_box.dart';
import 'package:olx_mobx/screens/SignUp/SignUpScreen.dart';
import 'package:olx_mobx/stores/login_store.dart';
import 'package:olx_mobx/stores/user_manager_store.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();
    when((_)=> userManagerStore.user != null, (){
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Card(
              /* fora do widget sempre o margin  */
              margin: const EdgeInsets.symmetric(horizontal: 32),
              /* definindo a borda do card email */
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                /* dentro do widget sempre o padding */
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Observer(builder: (_) {
                      return ErrorBox(
                        message: loginStore.error,
                      );
                    }),
                    Text(
                      'Acessar com Email:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[900],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                      child: Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Observer(builder: (_) {
                      return TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabled: !loginStore.loading,
                            errorText: loginStore.emailError,
                            isDense: true,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: loginStore.setEmail);
                    }),
                    const SizedBox(height: 16),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Senha:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              'Esqueceu a sua senha? ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blueAccent[700],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabled: !loginStore.loading,
                          errorText: loginStore.passError,
                          isDense: true,
                        ),
                        onChanged: loginStore.setPass,
                        obscureText: true,
                      );
                    }),
                    const SizedBox(height: 16),
                    Observer(builder: (_) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        height: 40,
                        child: RaisedButton(
                          color: Colors.lightBlueAccent[100],
                          elevation: 0,
                          disabledColor: Colors.lightBlueAccent[300],
                          child: loginStore.loading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.black))
                              : Text("login"),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: loginStore.loginPressed,
                        ),
                      );
                    }),
                    Divider(color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Wrap(
                        /*  wrap serve para se o texto não couber o texto na linha toda ele joga pra linha de baixo  */
                        children: [
                          const Text("Não tem uma conta? ",
                              style: TextStyle(fontSize: 16)),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Cadastre-se',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blueAccent[700],
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
