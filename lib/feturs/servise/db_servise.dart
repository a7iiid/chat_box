import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DbService {
  FirebaseFirestore _db;
  FirebaseStorage _storage;

  DbService()
      : _db = FirebaseFirestore.instance,
        _storage = FirebaseStorage.instance;
  Future<void> creatUserDb(
      String name, String email, String uid, String image) async {
    await _db.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'image': image,
      'lastSeen': DateTime.now().toUtc()
    });
  }
}
