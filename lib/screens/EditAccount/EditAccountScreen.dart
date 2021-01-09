import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditAccountScreen extends StatelessWidget {
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
                  LayoutBuilder(
                    builder: (_, constraints) {
                      return ToggleSwitch(
                        minWidth: constraints.biggest.width/2.01,
                        labels: ["Particular", "Professional"],
                        cornerRadius: 20,
                        activeBgColor: Colors.blueAccent[700],
                        inactiveBgColor: Colors.grey,
                        activeFgColor: Colors.white,
                        inactiveFgColor: Colors.white,
                        onToggle: (i) {},
                        initialLabelIndex: 0,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: "Nome*"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: "Telefone*",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: "Nova Senha",
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: "Confirmar nova senha",
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 40,
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.orange,
                      textColor: Colors.white,
                      elevation: 0,
                      child: Text("Salvar"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
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
