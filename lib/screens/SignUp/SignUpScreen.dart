import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_mobx/components/error_box.dart';
import 'package:olx_mobx/screens/SignUp/components/field_title.dart';
import 'package:olx_mobx/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpStore signUpStore = SignUpStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Observer(builder: (_) {
                      /* vai notificar caso tenha algum erro */
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ErrorBox(
                          message: signUpStore.error,
                        ),
                      );
                    }),
                    FieldTitle(
                      title: "Apelido",
                      subtitle: "Como aparecerá nos anuncios",
                    ),
                    Observer(
                      builder: (_) {
                        return TextField(
                          enabled: !signUpStore.loading,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            hintText: "Exemplo: Luiza F.",
                            errorText: signUpStore.nameError,
                          ),
                          onChanged: signUpStore.setName,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    FieldTitle(
                      title: "Email",
                      subtitle: "Enviaremos um email de confirmação para você",
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signUpStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          hintText: "Exemplo: aaaa@gmail.com",
                          errorText: signUpStore.emailError,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        onChanged: signUpStore.setEmail,
                      );
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(
                      title: "Celular",
                      subtitle: " Proteja a sua conta",
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signUpStore.loading,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            hintText: "Exemplo:(12) 9123-4567",
                            errorText: signUpStore.phoneError),
                        keyboardType: TextInputType.phone,
                        onChanged: signUpStore.setPhone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                      );
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(
                      title: "Senha",
                      subtitle: "Use letras, caracteres especiais e números",
                    ),
                    Observer(builder: (_) {
                      return TextField(
                          enabled: !signUpStore.loading,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            errorText: signUpStore.passError,
                            isDense: true,
                          ),
                          obscureText: true,
                          onChanged: signUpStore.setPass);
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(
                      title: "Confirmar senha",
                      subtitle: "Confirme a sua senha",
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signUpStore.loading,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            isDense: true,
                            errorText: signUpStore.verifyPassError),
                        onChanged: signUpStore.setVerifyPass,
                        obscureText: true,
                      );
                    }),
                    const SizedBox(height: 16),
                    Observer(builder: (_) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        height: 40,
                        child: RaisedButton(
                            disabledColor: Colors.blue[300],
                            color: Colors.lightBlueAccent[100],
                            elevation: 0,
                            child: signUpStore.loading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.black),
                                  )
                                : Text("Cadastrar"),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: signUpStore.signUpPressed),
                      );
                    }),
                    Divider(color: Colors.black),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            const Text("Já tem uma conta? ",
                                style: TextStyle(fontSize: 16)),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blueAccent[700],
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ))
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
