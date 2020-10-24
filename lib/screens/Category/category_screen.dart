import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:olx_mobx/models/Category.dart';
import 'package:olx_mobx/stores/category_store.dart';

class CategoryScreen extends StatelessWidget {
  /*  se não colocar nada no show all  o padrão será mostrar todas as categorias  (por isso o true, para mostrar todas as categorias)*/
  CategoryScreen({this.showAll = true, this.selected});
  final Category selected;
  final bool showAll;

  final CategoryStore categoryStore = GetIt.I<CategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.fromLTRB(32, 12, 32, 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Observer(
            builder: (_) {
              if (categoryStore.error != null) {
                return Text(
                  "${categoryStore.error}",
                  style: TextStyle(color: Colors.red),
                );
              } else if (categoryStore.categoryList.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                /* caso nao tenha erro e caso esteja carregando vamos exibir a lista de categorias */
                final categories = showAll
                    ? categoryStore.allCategoryList
                    : categoryStore.categoryList;
                return ListView.separated(
                  separatorBuilder: (_, __) {
                    return Divider(
                      height: 0.1,
                      color: Colors.green,
                    );
                  },
                  itemCount: categories.length,
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop(category);
                      },
                      child: Container(
                        height: 50,
                        color: category.id == selected?.id
                            ? Colors.blueAccent[700].withAlpha(50)
                            : null,
                        alignment: Alignment.center,
                        child: Text(
                          category.description,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: category.id == selected?.id
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
