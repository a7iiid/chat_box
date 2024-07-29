import 'package:chat_app/feturs/home/data/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DbService {
  static DbService instance = DbService();
  FirebaseFirestore _db;
  FirebaseStorage _storage;
  FirebaseAuth _authUser;
  String _collectionName = 'users';

  DbService()
      : _db = FirebaseFirestore.instance,
        _authUser = FirebaseAuth.instance,
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

  Future<UserModel> loadUserData() async {
    var user = await FirebaseFirestore.instance
        .collection(_collectionName)
        .doc(_authUser.currentUser!.uid)
        .get();

    return UserModel.fromJson(user.data() as Map<String, dynamic>);
  }
}
