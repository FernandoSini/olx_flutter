import 'package:flutter/material.dart';
import 'package:olx_mobx/models/Anuncio.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatelessWidget {
  BottomBar(this.anuncio);
  final Anuncio anuncio;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 26),
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: Colors.orange,
            ),
            child: Row(
              children: [
                if (!anuncio.hidePhone)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        /* pegando o telefone do usuario e limpando o telefone do usuario */
                        final phone =
                            anuncio.user.phone.replaceAll(RegExp('[^0-9]'), "");
                        print(phone.toString());
                        launch(
                            'tel:$phone'); /* no iphone tem que testar no aparelho mesmo e não no emulador */
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        child: Text(
                          "Ligar",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.black45),
                        ),
                      ),
                      height: 25,
                      child: Text(
                        "Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(249, 249, 249, 1),
              border: Border(
                top: BorderSide(
                  color: Colors.grey[400],
                ),
              ),
            ),
            height: 40,
            alignment: Alignment.center,
            child: Text(
              "${anuncio.user.name} (anunciante)",
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          )
        ],
      ),
    );
  }
}
