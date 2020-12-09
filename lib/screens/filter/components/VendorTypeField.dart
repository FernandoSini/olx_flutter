import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:olx_mobx/screens/filter/components/SectionTitle.dart';
import 'package:olx_mobx/stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  VendorTypeField(this.filterStore);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle("Tipo de Anunciante"),
        Observer(
          builder: (_) {
            return Wrap(
              runSpacing: 4,
              children: [
                GestureDetector(
                  onTap: () {
                    if (filterStore.isTypeParticular) {
                      /* caso os dois estejam habilitados */
                      if (filterStore.isTypeProfessional) {
                        filterStore.resetVendorType(VENDOR_TYPE_PARTICULAR);
                      } else {
                        /* caso o particular seja desabilitado o professional vai ser habilitado */
                        filterStore.selectVendorType(VENDOR_TYPE_PROFESSIONAL);
                      }
                    } else {
                      filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                      color: filterStore.isTypeParticular
                          ? Colors.blueAccent[700]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: filterStore.isTypeParticular
                            ? Colors.blueAccent[700]
                            : Colors.grey,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Particular",
                      style: TextStyle(
                        color: filterStore.isTypeParticular
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    if (filterStore.isTypeProfessional) {
                      /* caso os dois estejam habilitados */
                      if (filterStore.isTypeParticular) {
                        filterStore.resetVendorType(VENDOR_TYPE_PROFESSIONAL);
                      } else {
                        /* caso o particular seja desabilitado o particular vai ser habilitado */
                        filterStore.selectVendorType(VENDOR_TYPE_PARTICULAR);
                      }
                    } else {
                      filterStore.setVendorType(VENDOR_TYPE_PROFESSIONAL);
                    }
                  },
                  child: Container(
                    width: 135,
                    height: 50,
                    decoration: BoxDecoration(
                      color: filterStore.isTypeProfessional
                          ? Colors.blueAccent[700]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: filterStore.isTypeProfessional
                            ? Colors.blueAccent[700]
                            : Colors.grey,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Professional",
                      style: TextStyle(
                        color: filterStore.isTypeProfessional
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
