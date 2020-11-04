import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CepField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CepInputFormatter()
      ],
      decoration: InputDecoration(
        labelText: 'CEP *',
        labelStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.grey,
          fontSize: 16,
        ),
        contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
      ),
    );
  }
}
