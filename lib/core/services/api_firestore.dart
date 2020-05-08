import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ApiFirestoreTransactions {
  final Firestore _db = Firestore.instance;
  CollectionReference ref;

  ApiFirestoreTransactions() {
    ref = _db.collection('transactions');
  }

  Future<QuerySnapshot> getDataCollection() => ref.getDocuments();
  Stream<QuerySnapshot> streamDataCollection() =>
      ref.orderBy('sortAccountingDate', descending: true).snapshots();
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
