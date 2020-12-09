import 'package:flutter/material.dart';
import 'package:olx_mobx/screens/filter/components/OrderByField.dart';
import 'package:olx_mobx/stores/filter_store.dart';

class FilterScreen extends StatelessWidget {
  /* store que vai gerenciar o estado da tela de filtros */
  final FilterStore filterStore = FilterStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtrar Buscas"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderByField(filterStore),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
