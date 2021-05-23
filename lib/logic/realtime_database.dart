import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prayer/model/prayer.dart';

class FirestoreDatabase {
  factory FirestoreDatabase() => instance;
  static final FirestoreDatabase instance = FirestoreDatabase._internal();

  late FirebaseFirestore firestore;

  FirestoreDatabase._internal() {
    firestore = FirebaseFirestore.instanceFor(app: Firebase.app());
  }

  Future<void> addPrayer(Prayer prayer) async {
    await firestore.collection('prayers').add(prayer.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> get() async {
    return await firestore.collection('prayers').get();
  }
}
