import 'package:flutter/material.dart';

class MeusAnuncios extends StatefulWidget {
  @override
  _MeusAnunciosState createState() => _MeusAnunciosState();
}

class _MeusAnunciosState extends State<MeusAnuncios>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
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
          indicatorColor: Colors.blueAccent[700],
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
      body: TabBarView(
        controller: tabController,
        children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
