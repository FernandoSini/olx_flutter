import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_mobx/stores/EditAccountStore.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditAccountScreen extends StatelessWidget {
  final EditAccountStore editAccountStore = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
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
                  Observer(
                    builder: (_) {
                      return IgnorePointer(
                        //vai ignorar o toque no toggle enquanto tiver o loading
                        ignoring: editAccountStore.loading,
                        child: LayoutBuilder(
                          builder: (_, constraints) {
                            return ToggleSwitch(
                              minWidth: constraints.biggest.width / 2.01,
                              labels: ["Particular", "Professional"],
                              cornerRadius: 20,
                              activeBgColor: Colors.blueAccent[700],
                              inactiveBgColor: Colors.grey,
                              activeFgColor: Colors.white,
                              inactiveFgColor: Colors.white,
                              onToggle: editAccountStore.setUserType,
                              initialLabelIndex:
                                  editAccountStore.userType.index,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          labelText: "Nome*",
                          errorText: editAccountStore.nameError,
                        ),
                        enabled: !editAccountStore.loading,
                        initialValue: editAccountStore.name,
                        onChanged: editAccountStore.setName,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        initialValue: editAccountStore.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          labelText: "Telefone*",
                          errorText: editAccountStore.phoneError,
                        ),
                        enabled: !editAccountStore.loading,
                        onChanged: editAccountStore.setPhone,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          labelText: "Nova Senha",
                        ),
                        onChanged: editAccountStore.setPass1,
                        enabled: !editAccountStore.loading,
                        obscureText: true,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Observer(
                    builder: (_) {
                      return TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                          labelText: "Confirmar nova senha",
                          errorText: editAccountStore.passError,
                        ),
                        enabled: !editAccountStore.loading,
                        onChanged: editAccountStore.setPass2,
                        obscureText: true,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Observer(
                    builder: (_) {
                      return SizedBox(
                        height: 40,
                        child: RaisedButton(
                          onPressed: editAccountStore.savePressed,
                          color: Colors.orange,
                          textColor: Colors.white,
                          elevation: 0,
                          disabledColor: Colors.orange.withAlpha(100),
                          child: editAccountStore.loading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text("Salvar"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 40,
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.red,
                      textColor: Colors.white,
                      elevation: 0,
                      child: Text("Sair"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
