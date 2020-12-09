import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_mobx/screens/filter/components/OrderByField.dart';
import 'package:olx_mobx/stores/filter_store.dart';
import 'package:olx_mobx/stores/home_store.dart';

import 'components/VendorTypeField.dart';
import 'components/price_range_field.dart';

class FilterScreen extends StatelessWidget {
  /* store que vai gerenciar o estado da tela de filtros, 
  o get it é usado pra definir os dados que já serão pré carregados/definidos */
  final FilterStore filterStore = GetIt.I<HomeStore>().clonedFilter;
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderByField(filterStore),
                PriceRangeField(filterStore),
                VendorTypeField(filterStore),
                Observer(
                  builder: (_) {
                    return Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: RaisedButton(
                        textColor: Colors.white,
                        disabledColor: Colors.orange.withAlpha(120),
                        color: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          "Filtrar",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: filterStore.isFormValid
                            ? () {
                                filterStore.save();
                                Navigator.of(context).pop();
                              }
                            : null,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
