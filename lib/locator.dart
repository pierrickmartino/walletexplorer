import 'package:get_it/get_it.dart';
import 'package:walletexplorer/core/services/api_firestore.dart';
import 'package:walletexplorer/core/viewModels/transaction_type_view.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ApiFirestore('transactionTypes'));
  locator.registerLazySingleton(() => TransactionTypeView());
}
