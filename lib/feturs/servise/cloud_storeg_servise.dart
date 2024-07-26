import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class CloudStorageServise {
  static CloudStorageServise instance = CloudStorageServise();
  late FirebaseStorage _storage;
  late Reference _reference;
  String _profileImage = 'Profile_Image';

  CloudStorageServise() {
    _storage = FirebaseStorage.instance;
    _reference = _storage.ref();
  }
  Future<TaskSnapshot?> uploadUserImage(String _uid, File _image) async {
    try {
      return await _reference
          .child('Profile_Image')
          .child(_uid)
          .putFile(_image);
    } on Exception catch (e) {
      return null;
    }
  }
}
