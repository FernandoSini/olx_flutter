import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_mobx/screens/filter/components/SectionTitle.dart';
import 'package:olx_mobx/stores/filter_store.dart';

import 'PriceField.dart';

class PriceRangeField extends StatelessWidget {
  PriceRangeField(this.filterStore);
  final FilterStore filterStore;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Preço'),
        Row(
          children: [
            PriceField(
              label: 'Min',
              onChanged: filterStore.setMinPrice,
              initialValue: filterStore.minPrice,
            ),
            const SizedBox(
              width: 12,
            ),
            PriceField(
              label: 'Max',
              onChanged: filterStore.setMaxPrice,
              initialValue: filterStore.maxPrice,
            ),
          ],
        ),
        Observer(
          builder: (_) {
            if (filterStore.priceError != null) {
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  filterStore.priceError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        )
      ],
    );
  }
}
