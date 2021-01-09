import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_mobx/components/Empty_card.dart';
import 'package:olx_mobx/stores/meusanuncios_store.dart';

import 'components/ActiveTile.dart';
import 'components/PendingTile.dart';
import 'components/SoldTile.dart';

class MeusAnuncios extends StatefulWidget {
  /* definindo a pagina inicial */
  MeusAnuncios({this.initialPage = 0});

  final int initialPage;

  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final MeusAnunciosStore meusAnuncios = MeusAnunciosStore();

  @override
  void initState() {
    tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.initialPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Anúncios"),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              child: Text("Ativos"),
            ),
            Tab(
              child: Text("Pendentes"),
            ),
            Tab(
              child: Text("Vendidos"),
            ),
          ],
        ),
      ),
      body: Observer(
        builder: (_) {
          if (meusAnuncios.loading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
          return TabBarView(
            controller: tabController,
            children: [
              /* observando a lista de anuncios ativas caso a lista mude ela possa atualizar */
              Observer(
                builder: (_) {
                  if (meusAnuncios.activeAds.isEmpty) return EmptyCard("Você não possui anúncios ativos");
                  return ListView.builder(
                    itemCount: meusAnuncios.activeAds.length,
                    itemBuilder: (_, index) {
                      return ActiveTile(
                          meusAnuncios.activeAds[index], meusAnuncios);
                    },
                  );
                },
              ),
              /* observando a lista de anuncios pendendtes caso a lista mude ela possa atualizar */
              Observer(
                builder: (_) {
                  if (meusAnuncios.pendingAds.isEmpty) return EmptyCard("Você não possui anúncios pendentes");
                  return ListView.builder(
                    itemCount: meusAnuncios.pendingAds.length,
                    itemBuilder: (_, index) {
                      return PendingTile(meusAnuncios.pendingAds[index]);
                    },
                  );
                },
              ),
              /* observando a lista de anuncios vendidos caso a lista mude ela possa atualizar */
              Observer(
                builder: (_) {
                  if (meusAnuncios.soldAds.isEmpty) return EmptyCard("Você não possui anúncios vendidos");
                  return ListView.builder(
                    itemCount: meusAnuncios.soldAds.length,
                    itemBuilder: (_, index) {
                      return SoldTile(meusAnuncios.soldAds[index], meusAnuncios);
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
