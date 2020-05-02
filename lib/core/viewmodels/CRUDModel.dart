import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as _firestore;
import 'package:walletexplorer/core/models/account.dart';
import 'package:walletexplorer/locator.dart';
import 'package:walletexplorer/core/models/transaction.dart';
import 'package:walletexplorer/core/services/api_firestore.dart';

class CRUDModel extends ChangeNotifier {
  ApiFirestoreAccounts _apiAccounts = locator<ApiFirestoreAccounts>();
  ApiFirestoreTransactions _apiTransactions =
      locator<ApiFirestoreTransactions>();

  List<Transaction> transactions;
  List<Account> accounts;

  /* Transactions */
  Future<List<Transaction>> fetchTransactions() async {
    var result = await _apiTransactions.getDataCollection();
    transactions = result.documents
        .map((doc) => Transaction.fromMap(doc.data, doc.documentID))
        .toList();
    return transactions;
  }

  Stream<_firestore.QuerySnapshot> fetchTransactionsAsStream() {
    return _apiTransactions.streamDataCollection();
  }

  Future<Transaction> getTransactionById(String id) async {
    var doc = await _apiTransactions.getDocumentById(id);
    return Transaction.fromMap(doc.data, doc.documentID);
  }

  Future removeTransaction(String id) async {
    await _apiTransactions.removeDocument(id);
    return;
  }

  Future updateTransaction(Transaction data, String id) async {
    await _apiTransactions.updateDocument(data.toJson(), id);
    return;
  }

  Future addTransaction(Transaction data) async {
    var result = await _apiTransactions.addDocument(data.toJson());

    return;
  }

/* Accounts */
  Future<List<Account>> fetchAccounts() async {
    var result = await _apiAccounts.getDataCollection();
    transactions = result.documents
        .map((doc) => Transaction.fromMap(doc.data, doc.documentID))
        .toList();
    return accounts;
  }

  Stream<_firestore.QuerySnapshot> fetchAccountsAsStream() {
    return _apiAccounts.streamDataCollection();
  }

  Future<Account> getAccountById(String id) async {
    var doc = await _apiAccounts.getDocumentById(id);
    return Account.fromMap(doc.data, doc.documentID);
  }

  Future removeAccount(String id) async {
    await _apiAccounts.removeDocument(id);
    return;
  }

  Future updateAccount(Account data, String id) async {
    await _apiAccounts.updateDocument(data.toJson(), id);
    return;
  }

  Future addAccount(Transaction data) async {
    var result = await _apiAccounts.addDocument(data.toJson());

    return;
  }
}
