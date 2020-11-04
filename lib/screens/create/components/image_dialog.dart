import 'package:flutter/material.dart';

/* quando ele clicar na foto vai aparecer um dialog com a opção de excluir a foto */

class ImageDialog extends StatelessWidget {
  ImageDialog({@required this.image, @required this.onDelete});
  final dynamic image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.file(image),
          FlatButton(
            child: const Text('Excluir'),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
              onDelete();
            },
          ),
        ],
      ),
    );
  }
}
