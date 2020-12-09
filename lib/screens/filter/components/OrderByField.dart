import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_mobx/screens/filter/components/SectionTitle.dart';
import 'package:olx_mobx/stores/filter_store.dart';

class OrderByField extends StatelessWidget {
  OrderByField(this.filterStore);
  final FilterStore filterStore;
  @override
  Widget build(BuildContext context) {
    /* o option esta relacionado ao tipo de ordem que ele ira fazer  */
    Widget buildOption(String title, OrderBy option) {
      return GestureDetector(
        onTap: () {
          /* alterar a cor dos botoes ao clicar */
          filterStore.setOrderBy(option);
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: filterStore.orderBy == option
                  ? Colors.blueAccent[700]
                  : Colors.transparent,
              border: Border.all(
                  color: filterStore.orderBy == option
                      ? Colors.blueAccent[700]
                      : Colors.grey)),
          child: Text(
            title,
            style: TextStyle(
              color:
                  filterStore.orderBy == option ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle("Ordernar por"),
        Observer(builder: (_) {
          return Row(
            children: [
              buildOption("Data", OrderBy.DATE),
              const SizedBox(
                width: 12,
              ),
              buildOption("Preço", OrderBy.PRICE),
            ],
          );
        }),
      ],
    );
  }
}
