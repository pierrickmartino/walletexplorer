import 'package:get_it/get_it.dart';
import 'package:walletexplorer/core/services/api_firestore.dart';
import 'package:walletexplorer/core/viewmodels/CRUDModel.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<CRUDModel>(() => CRUDModel());
  locator.registerLazySingleton<ApiFirestoreTransactions>(
      () => ApiFirestoreTransactions());
  locator.registerLazySingleton<ApiFirestoreAccounts>(
      () => ApiFirestoreAccounts());
}
