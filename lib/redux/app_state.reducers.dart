import 'package:redux_test/model/catalog.dart';
import 'package:redux_test/redux/app_state.actions.dart';
import 'package:redux_test/redux/app_state.dart';

AppState appStateReducer(AppState state, dynamic action) {
  if (action is UpdateCatalogAction) {
    state = AppState()
        .copyWith(catalog: const Catalog().copyWith(list: action.list));
  }

  return state;
}
