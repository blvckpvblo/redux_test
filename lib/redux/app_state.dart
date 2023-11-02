import 'package:redux_test/model/catalog.dart';

class AppState {
  final Catalog catalog;

  AppState({this.catalog = const Catalog()});

  AppState copyWith({Catalog? catalog}) {
    return AppState(catalog: catalog ?? this.catalog);
  }
}
