import 'package:get_it/get_it.dart';
import './core/services/api_firestore.dart';
import './core/viewmodels/CRUDModel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<CRUDModel>(() => CRUDModel());
  locator.registerLazySingleton<ApiFirestoreTransactions>(
      () => ApiFirestoreTransactions());
  locator.registerLazySingleton<ApiFirestoreAccounts>(
      () => ApiFirestoreAccounts());
  locator.registerLazySingleton<ApiFirestoreTransactionTypes>(
      () => ApiFirestoreTransactionTypes());
}
