import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prayer/model/prayer.dart';

class FirestoreDatabase {
  factory FirestoreDatabase() => instance;
  static final FirestoreDatabase instance = FirestoreDatabase._internal();

  late FirebaseApp app;
  late FirebaseFirestore firestore;
  bool done = false;

  FirestoreDatabase._internal();

  Future<void> initDb() async {
    if (!done) {
      app = await Firebase.initializeApp();
      firestore = FirebaseFirestore.instanceFor(app: app);
      done = true;
    } else {
      print("already inited");
    }
  }

  Future<void> addPrayer(Prayer prayer) async {
    await firestore.collection('prayers').add(prayer.toJson());
  }
}
