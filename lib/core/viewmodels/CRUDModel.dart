import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as _firestore;

import '../models/account.dart';
import '../models/transaction_type.dart';
import '../models/transaction.dart';
import '../models/statistic.dart';
import '../services/api_firestore.dart';
import '../../locator.dart';

class CRUDModel extends ChangeNotifier {
  ApiFirestoreAccounts _apiAccounts = locator<ApiFirestoreAccounts>();
  ApiFirestoreTransactions _apiTransactions =
      locator<ApiFirestoreTransactions>();
  ApiFirestoreTransactionTypes _apiTransactionTypes =
      locator<ApiFirestoreTransactionTypes>();
  ApiFirestoreStatistics _apiStatistics = locator<ApiFirestoreStatistics>();

  List<Transaction> transactions;
  List<TransactionType> transactionTypes;
  List<Account> accounts;
  List<Statistic> statistics;

  /* Transactions */
  Future<List<Transaction>> fetchTransactions() async {
    _firestore.QuerySnapshot result =
        await _apiTransactions.getDataCollection();
    transactions = result.documents
        .map((doc) => Transaction.fromMap(doc.data, doc.documentID))
        .toList();
    return transactions;
  }

  Future<List<Transaction>> fetchTransactionsByAccount(String account) async {
    _firestore.QuerySnapshot result =
        await _apiTransactions.getDataCollectionByAccount(account);
    transactions = result.documents
        .map((doc) => Transaction.fromMap(doc.data, doc.documentID))
        .toList();
    return transactions;
  }

  Future<List<Transaction>> fetchTransactionsByAccountByDateRange(
      String account, DateTime minDate, DateTime maxDate) async {
    _firestore.QuerySnapshot result = await _apiTransactions
        .getDataCollectionByAccountByDateRange(account, minDate, maxDate);
    transactions = result.documents
        .map((doc) => Transaction.fromMap(doc.data, doc.documentID))
        .toList();
    return transactions;
  }

  Stream<_firestore.QuerySnapshot> fetchTransactionsAsStream() =>
      _apiTransactions.streamDataCollection();

  Stream<_firestore.QuerySnapshot> fetchTransactionsAsStreamByAccount(
          String account) =>
      _apiTransactions.streamDataCollectionByAccount(account);

  Stream<_firestore.QuerySnapshot> fetchTransactionsAsStreamByAccountByType(
          String account, String type) =>
      _apiTransactions.streamDataCollectionByAccountByType(account, type);

  Stream<_firestore.QuerySnapshot> fetchTransactionsAsStreamByType(
          String type) =>
      _apiTransactions.streamDataCollectionByType(type);

  Future<Transaction> getTransactionById(String id) async {
    _firestore.DocumentSnapshot doc =
        await _apiTransactions.getDocumentById(id);
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
    _firestore.DocumentReference result =
        await _apiTransactions.addDocument(data.toJson());
    return;
  }

/* Accounts */
  Future<List<Account>> fetchAccounts() async {
    _firestore.QuerySnapshot result = await _apiAccounts.getDataCollection();
    transactions = result.documents
        .map((doc) => Transaction.fromMap(doc.data, doc.documentID))
        .toList();
    return accounts;
  }

  Stream<_firestore.QuerySnapshot> fetchAccountsAsStream() =>
      _apiAccounts.streamDataCollection();

  Future<Account> getAccountById(String id) async {
    _firestore.DocumentSnapshot doc = await _apiAccounts.getDocumentById(id);
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
    _firestore.DocumentReference result =
        await _apiAccounts.addDocument(data.toJson());

    return;
  }

/* Transaction Types */
  Future<List<TransactionType>> fetchTransactionTypes() async {
    _firestore.QuerySnapshot result =
        await _apiTransactionTypes.getDataCollection();
    transactionTypes = result.documents
        .map((doc) => TransactionType.fromMap(doc.data, doc.documentID))
        .toList();
    return transactionTypes;
  }

  Stream<_firestore.QuerySnapshot> fetchTransactionTypesAsStream() =>
      _apiTransactionTypes.streamDataCollection();
  Stream<_firestore.QuerySnapshot> fetchTransactionTypesAsStreamDebit() =>
      _apiTransactionTypes.streamDataCollectionDebit();
  Stream<_firestore.QuerySnapshot> fetchTransactionTypesAsStreamCredit() =>
      _apiTransactionTypes.streamDataCollectionCredit();

  Future<TransactionType> getTransactionTypeById(String id) async {
    _firestore.DocumentSnapshot doc =
        await _apiTransactionTypes.getDocumentById(id);
    return TransactionType.fromMap(doc.data, doc.documentID);
  }

  Future removeTransactionType(String id) async {
    await _apiTransactionTypes.removeDocument(id);
    return;
  }

  Future updateTransactionType(TransactionType data, String id) async {
    await _apiTransactionTypes.updateDocument(data.toJson(), id);
    return;
  }

  Future addTransactionType(TransactionType data) async {
    _firestore.DocumentReference result =
        await _apiTransactionTypes.addDocument(data.toJson());

    return;
  }

/* Statistics */
  Future<List<Statistic>> fetchStatistics() async {
    _firestore.QuerySnapshot result = await _apiStatistics.getDataCollection();
    statistics = result.documents
        .map((doc) => Statistic.fromMap(doc.data, doc.documentID))
        .toList();
    return statistics;
  }

  Future<List<Statistic>> fetchStatisticsByAccountByCode(
      String account, String code) async {
    _firestore.QuerySnapshot result =
        await _apiStatistics.getDataCollectionByAccountByCode(account, code);
    statistics = result.documents
        .map((doc) => Statistic.fromMap(doc.data, doc.documentID))
        .toList();
    return statistics;
  }

  Stream<_firestore.QuerySnapshot> fetchStatisticsAsStream() =>
      _apiStatistics.streamDataCollection();

  Future<Statistic> getStatisticById(String id) async {
    _firestore.DocumentSnapshot doc = await _apiStatistics.getDocumentById(id);
    return Statistic.fromMap(doc.data, doc.documentID);
  }

  Future removeStatistic(String id) async {
    await _apiStatistics.removeDocument(id);
    return;
  }

  Future updateStatistic(Statistic data, String id) async {
    await _apiStatistics.updateDocument(data.toJson(), id);
    return;
  }

  Future addStatistic(Statistic data) async {
    _firestore.DocumentReference result =
        await _apiStatistics.addDocument(data.toJson());

    return;
  }

  Future setStatistic(Statistic data, String id) async {
    _firestore.DocumentReference result =
        await _apiStatistics.setDocument(data.toJson(), id);

    return;
  }
}
