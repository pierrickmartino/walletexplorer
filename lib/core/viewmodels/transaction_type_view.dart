// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:walletexplorer/locator.dart';
// import 'package:walletexplorer/core/models/transaction_type.dart';
// import 'package:walletexplorer/core/services/api_firestore.dart';

// class TransactionTypeView extends ChangeNotifier {
//   ApiFirestore _api = locator<ApiFirestore>();

//   List<TransactionType> transactiontypes;

//   Future<List<TransactionType>> fetchTransactionTypes() async {
//     var result = await _api.getDataCollection();
//     transactiontypes = result.documents
//         .map((doc) => TransactionType.fromMap(doc.data, doc.documentID))
//         .toList();
//     return transactiontypes;
//   }

//   Stream<QuerySnapshot> fetchTransactionTypesAsStream() {
//     return _api.streamDataCollection();
//   }

//   Future<TransactionType> getTransactionTypeById(String id) async {
//     var doc = await _api.getDocumentById(id);
//     return TransactionType.fromMap(doc.data, doc.documentID);
//   }

//   Future removeTransactionType(String id) async {
//     await _api.removeDocument(id);
//     return;
//   }

//   Future updateTransactionType(TransactionType data, String id) async {
//     await _api.updateDocument(data.toJson(), id);
//     return;
//   }

//   Future addTransactionType(TransactionType data) async {
//     var result = await _api.addDocument(data.toJson());

//     return;
//   }
// }
