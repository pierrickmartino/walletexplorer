import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ApiFirestoreTransactions {
  final Firestore _db = Firestore.instance;
  CollectionReference ref;

  ApiFirestoreTransactions() {
    ref = _db.collection('transactions');
  }

  Future<QuerySnapshot> getDataCollection() => ref.getDocuments();
  Future<QuerySnapshot> getDataCollectionByAccount(String account) =>
      ref.where('product', isEqualTo: account).getDocuments();
  Future<QuerySnapshot> getDataCollectionByAccountByDateRange(
          String account, DateTime minDate, DateTime maxDate) =>
      ref
          .where('product', isEqualTo: account)
          .where('sortAccountingDate', isGreaterThanOrEqualTo: minDate)
          .where('sortAccountingDate', isLessThan: maxDate)
          .getDocuments();
  Stream<QuerySnapshot> streamDataCollection() =>
      ref.orderBy('sortAccountingDate', descending: true).snapshots();
  Stream<QuerySnapshot> streamDataCollectionByAccount(String account) =>
      ref.where('product', isEqualTo: account).limit(50).snapshots();
  Stream<QuerySnapshot> streamDataCollectionByAccountByType(
          String account, String type) =>
      ref
          .where('product', isEqualTo: account)
          .where('type', isEqualTo: type)
          .limit(50)
          .snapshots();
  Stream<QuerySnapshot> streamDataCollectionByType(String type) =>
      ref.where('type', isEqualTo: type).limit(100).snapshots();
  Future<DocumentSnapshot> getDocumentById(String id) => ref.document(id).get();
  Future<void> removeDocument(String id) => ref.document(id).delete();
  Future<DocumentReference> addDocument(Map data) => ref.add(data);
  Future<void> updateDocument(Map data, String id) =>
      ref.document(id).updateData(data);
}

class ApiFirestoreAccounts {
  final Firestore _db = Firestore.instance;
  CollectionReference ref;

  ApiFirestoreAccounts() {
    ref = _db.collection('accounts');
  }

  Future<QuerySnapshot> getDataCollection() => ref.getDocuments();
  Stream<QuerySnapshot> streamDataCollection() => ref.snapshots();
  Future<DocumentSnapshot> getDocumentById(String id) => ref.document(id).get();
  Future<void> removeDocument(String id) => ref.document(id).delete();
  Future<DocumentReference> addDocument(Map data) => ref.add(data);
  Future<void> updateDocument(Map data, String id) =>
      ref.document(id).updateData(data);
}

class ApiFirestoreTransactionTypes {
  final Firestore _db = Firestore.instance;
  CollectionReference ref;

  ApiFirestoreTransactionTypes() {
    ref = _db.collection('transactionTypes');
  }

  Future<QuerySnapshot> getDataCollection() => ref.getDocuments();
  Stream<QuerySnapshot> streamDataCollection() => ref.snapshots();
  Stream<QuerySnapshot> streamDataCollectionCredit() =>
      ref.where('direction', whereIn: ['in', 'both']).snapshots();
  Stream<QuerySnapshot> streamDataCollectionDebit() =>
      ref.where('direction', whereIn: ['out', 'both']).snapshots();
  Future<DocumentSnapshot> getDocumentById(String id) => ref.document(id).get();
  Future<void> removeDocument(String id) => ref.document(id).delete();
  Future<DocumentReference> addDocument(Map data) => ref.add(data);
  Future<void> updateDocument(Map data, String id) =>
      ref.document(id).updateData(data);
}

class ApiFirestoreStatistics {
  final Firestore _db = Firestore.instance;
  CollectionReference ref;

  ApiFirestoreStatistics() {
    ref = _db.collection('statistics');
  }

  Future<QuerySnapshot> getDataCollection() => ref.getDocuments();
  Stream<QuerySnapshot> streamDataCollection() => ref.snapshots();
  Future<QuerySnapshot> getDataCollectionByAccountByCode(
          String account, String code) =>
      ref
          .where('product', isEqualTo: account)
          .where('code', isEqualTo: code)
          .getDocuments();
  Future<QuerySnapshot> getDataCollectionByYear(String year) =>
      ref.where('year', isEqualTo: year).getDocuments();
  Future<DocumentSnapshot> getDocumentById(String id) => ref.document(id).get();
  Future<void> removeDocument(String id) => ref.document(id).delete();
  Future<DocumentReference> addDocument(Map data) => ref.add(data);
  Future<DocumentReference> setDocument(Map data, String id) =>
      ref.document(id).setData(data);
  Future<void> updateDocument(Map data, String id) =>
      ref.document(id).updateData(data);
}
