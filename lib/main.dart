import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_test/model/item.dart';
import 'package:redux_test/redux/app_state.actions.dart';
import 'package:redux_test/redux/app_state.dart';
import 'package:redux_test/redux/app_state.reducers.dart';
import 'package:redux_test/screen/cart.dart';
import 'package:redux_test/model/catalog.dart';

void main() {
  final store = Store<AppState>(appStateReducer, initialState: AppState());

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Redux Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Redux Demo"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Cart()));
              },
              icon: const Icon(Icons.shopping_bag),
            )
          ],
        ),
        body: StoreConnector<AppState, Catalog>(
          converter: (store) => store.state.catalog,
          builder: (context, catalog) => ListView.builder(
            itemCount: catalog.list.length,
            itemBuilder: (BuildContext context, int index) {
              return SwitchListTile(
                title: Text(catalog.list[index].label),
                value: catalog.list[index].value,
                onChanged: (bool value) {
                  Item currItem = catalog.list[index];

                  List<Item> newCatalog = catalog.list
                      .map((Item e) => e.label == currItem.label
                          ? Item(
                              label: catalog.list[index].label,
                              value: !catalog.list[index].value)
                          : e)
                      .toList();

                  StoreProvider.of<AppState>(context)
                      .dispatch(UpdateCatalogAction(newCatalog));
                },
              );
            },
          ),
        ));
  }
}
