import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_test/model/catalog.dart';
import 'package:redux_test/model/item.dart';
import 'package:redux_test/redux/app_state.actions.dart';
import 'package:redux_test/redux/app_state.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Redux Demo"),
      ),
      body: StoreConnector<AppState, Catalog>(
          converter: (store) => store.state.catalog,
          builder: (context, catalog) {
            List<Item> selectedItems =
                catalog.list.where((element) => element.value).toList();

            return ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(selectedItems[index].label),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Item currItem = selectedItems[index];

                    List<Item> newCatalog = catalog.list
                        .map((Item e) => e.label == currItem.label
                            ? Item(
                                label: selectedItems[index].label,
                                value: !selectedItems[index].value)
                            : e)
                        .toList();

                    StoreProvider.of<AppState>(context)
                        .dispatch(UpdateCatalogAction(newCatalog));
                  },
                ),
              ),
            );
          }),
    );
  }
}
