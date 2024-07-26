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
  Future<String> uploadUserImage(String _uid, File _image) async {
    try {
      var uplod =
          await _reference.child('Profile_Image').child(_uid).putFile(_image);
      return uplod.ref.getDownloadURL();
    } on Exception catch (e) {
      return "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png";
    }
  }
}
