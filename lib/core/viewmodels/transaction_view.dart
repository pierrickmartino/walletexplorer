// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart' as _firestore;
// import 'package:walletexplorer/locator.dart';
// import 'package:walletexplorer/core/models/transaction.dart';
// import 'package:walletexplorer/core/services/api_firestore.dart';

// class TransactionView extends ChangeNotifier {
//   ApiFirestore _api = locator<ApiFirestore>();

//   List<Transaction> transactions;

//   Future<List<Transaction>> fetchTransactions() async {
//     var result = await _api.getDataCollection();
//     transactions = result.documents
//         .map((doc) => Transaction.fromMap(doc.data, doc.documentID))
//         .toList();
//     return transactions;
//   }

//   Stream<_firestore.QuerySnapshot> fetchTransactionsAsStream() {
//     return _api.streamDataCollection();
//   }

//   Future<Transaction> getTransactionById(String id) async {
//     var doc = await _api.getDocumentById(id);
//     return Transaction.fromMap(doc.data, doc.documentID);
//   }

//   Future removeTransaction(String id) async {
//     await _api.removeDocument(id);
//     return;
//   }

//   Future updateTransaction(Transaction data, String id) async {
//     await _api.updateDocument(data.toJson(), id);
//     return;
//   }

//   Future addTransaction(Transaction data) async {
//     var result = await _api.addDocument(data.toJson());

//     return;
//   }
// }
