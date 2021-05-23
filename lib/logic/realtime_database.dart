import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prayer/logic/auth_manager.dart';
import 'package:prayer/model/prayer.dart';

class FirestoreDatabase {
  factory FirestoreDatabase() => instance;
  static final FirestoreDatabase instance = FirestoreDatabase._internal();

  late FirebaseFirestore firestore;

  FirestoreDatabase._internal() {
    firestore = FirebaseFirestore.instanceFor(app: Firebase.app());
  }

  Future<void> addPrayer(Prayer prayer) async {
    await firestore.collection('prayers').doc(prayer.id.toString()).set(prayer.toJson());
  }

  Future<void> followPrayer(Prayer prayer) async {
    User? user = AuthManager.instance.getUser();
    if (user != null) {
      prayer.follows.add(user.uid);
      await firestore.collection('prayers').doc(prayer.id.toString()).update(prayer.toJson());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> get() async {
    return await firestore.collection('prayers').get();
  }
}
