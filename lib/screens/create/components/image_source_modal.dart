import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  ImageSourceModal(this.onImageSelected);
  /* recebendo a imagem */
  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          /* alargando as linhas */
          children: [
            FlatButton(
              child: const Text('Câmera'),
              onPressed: getFromCamera,
            ),
            FlatButton(
              child: const Text('Galeria'),
              onPressed: getFromGallery,
            )
          ],
        ),
        onClosing: () {},
      );
    } else {
      return CupertinoActionSheet(
        title: const Text("Selecionar foto para o anúncio"),
        message: const Text("Escolha a origem da foto"),
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          CupertinoActionSheetAction(
            child: const Text("Câmera"),
            onPressed: getFromCamera,
          ),
          CupertinoActionSheetAction(
            child: const Text("Galeria"),
            onPressed: getFromGallery,
          ),
        ],
      );
    }
  }

  Future<void> getFromCamera() async {
    /* pegando a imagem da camera */
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    /* resolvendo o problema do null quando cancela o processo */
    if (pickedImage == null) {
      return;
    }
    /* passando o caminho da imagem que pegamos */
    final image = File(pickedImage.path);
    /* passando a imagem selecionada */
    imageSelected(image);
  }

  Future<void> getFromGallery() async {
    /* selecionando a imagem da galeria */
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    /* resolvendo o problema do null quando cancela o processo */
    if (pickedImage == null) {
      return;
    }
    /* passando o caminho da imagem que pegamos */
    final image = File(pickedImage.path);
    /* passando a imagem selecionada */
    imageSelected(image);
  }

  Future<void> imageSelected(File image) async {
    /* pegando a imagem e passando para o image cropper para poder cortar/editar */
    final croppedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.blueAccent[700],
        toolbarTitle: "Editar imagem",
      ),
      iosUiSettings: IOSUiSettings(
        title: "Editar imagem",
        cancelButtonTitle: "Cancelar ",
        doneButtonTitle: "Concluir",
      ),
    );
    if (croppedImage != null) {
      onImageSelected(croppedImage);
    }
  }
}
