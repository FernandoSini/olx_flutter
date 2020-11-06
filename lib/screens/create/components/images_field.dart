import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_mobx/screens/create/components/image_source_modal.dart';
import 'package:olx_mobx/stores/create_store.dart';

import 'image_dialog.dart';

class ImagesField extends StatelessWidget {
  ImagesField(this.createStore);

  final CreateStore createStore;
  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      /* vamos retornar a imagem cortada mesmo sendo void */
      createStore.imageList.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          height: 120,
          child: Observer(builder: (_) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: createStore.imageList.length < 5
                  ? createStore.imageList.length + 1
                  : 5,
              itemBuilder: (_, index) {
                /* fazendo com que o ultimo circulo seja o botão de adicionar imagem, de resto irá exibir as imagens */
                if (index == createStore.imageList.length) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    child: GestureDetector(
                      onTap: () {
                        if (Platform.isAndroid) {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => ImageSourceModal(onImageSelected),
                          );
                        } else {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => ImageSourceModal(onImageSelected),
                          );
                        }
                      },
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(8, 16, index == 4 ? 8 : 0, 16),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => ImageDialog(
                            image: createStore.imageList[index],
                            onDelete: () =>
                                createStore.imageList.removeAt(index),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            FileImage(createStore.imageList[index]),
                      ),
                    ),
                  );
                }
              },
            );
          }),
        ),
        Observer(
          builder: (_) {
            if (createStore.imagesError != null) {
              return Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.red),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                child: Text(
                  createStore.imagesError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              );
            } else {
              return Container(
                
              );
            }
          },
        )
      ],
    );
  }
}
