// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:walletexplorer/locator.dart';
// import 'package:walletexplorer/core/models/account.dart';
// import 'package:walletexplorer/core/services/api_firestore.dart';

// class AccountView extends ChangeNotifier {
//   ApiFirestore _api = locator<ApiFirestore>();

//   List<Account> accounts;

//   Future<List<Account>> fetchAccounts() async {
//     var result = await _api.getDataCollection();
//     accounts = result.documents
//         .map((doc) => Account.fromMap(doc.data, doc.documentID))
//         .toList();
//     return accounts;
//   }

//   Stream<QuerySnapshot> fetchAccountsAsStream() {
//     return _api.streamDataCollection();
//   }

//   Future<Account> getAccountById(String id) async {
//     var doc = await _api.getDocumentById(id);
//     return Account.fromMap(doc.data, doc.documentID);
//   }

//   Future removeAccount(String id) async {
//     await _api.removeDocument(id);
//     return;
//   }

//   Future updateAccount(Account data, String id) async {
//     await _api.updateDocument(data.toJson(), id);
//     return;
//   }

//   Future addAccount(Account data) async {
//     var result = await _api.addDocument(data.toJson());

//     return;
//   }
// }
