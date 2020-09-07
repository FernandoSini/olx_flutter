import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:olx_mobx/screens/Home/HomeScreen.dart';
import 'package:olx_mobx/screens/create/create_screen.dart';
import 'package:olx_mobx/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  /* essa instancia pode ser obtida de qualquer lugar do app */
  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  void initState() {
    super.initState();
    /* colocando uma reaction para observar a pageStore (quando ela muda de estado) */
    //ou seja toda vez que a pagina for alterada ele vai chamar a função da direita/efeito quando há mudança no valor do observable
    reaction((_) => pageStore.page,
        (page) => pageController.jumpToPage(page) /* recebando a pagina atual */
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          CreateScreen(),
          Container(color: Colors.yellow),
          Container(color: Colors.purple),
          Container(color: Colors.brown),
        ],
      ),
    );
  }
}
