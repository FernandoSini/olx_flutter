import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_mobx/stores/page_store.dart';

class CreateAnuncioButton extends StatefulWidget {
  CreateAnuncioButton(this.scrollController);
  final ScrollController scrollController;
  @override
  _CreateAnuncioButtonState createState() => _CreateAnuncioButtonState();
}

class _CreateAnuncioButtonState extends State<CreateAnuncioButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  /* animacao do botao com valores em double */
  Animation<double> buttonAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    buttonAnimation = Tween<double>(begin: 0, end: 70).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.4,
          0.6,
        ), /* intervalo de tempo das animacoes apartir da duracao definida */
      ),
    );
    /* toda vez que ele der scroll pra cima ou pra baixo vai ser escutado pelo listener */
    widget.scrollController.addListener(scrollChanged);
  }

  void scrollChanged() {
    /* pegando o contexto do scroll */

    final scrollContext = widget.scrollController.position;
    if (scrollContext.userScrollDirection == ScrollDirection.forward) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: buttonAnimation,
      builder: (_, __) {
        return FractionallySizedBox(
          /* especifica uma porcentagem da largura e do espaco disponivel para ser settado */
          widthFactor: 0.6,
          child: Container(
            height: 50,
            margin: EdgeInsets.only(bottom: buttonAnimation.value),
            child: RaisedButton(
              color: Colors.orange,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      "Anunciar agora",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              onPressed: () {
                GetIt.I<PageStore>().setPage(1);
              },
            ),
          ),
        );
      },
    );
  }
}
