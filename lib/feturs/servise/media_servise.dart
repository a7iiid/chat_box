import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

enum MediaStatus {
  InitMedia,
  LoadingImage,
  UploadImage,
  FailedLoad,
  SuccessLoad
}

class MediaService with ChangeNotifier {
  static MediaService instance = MediaService();
  MediaStatus status = MediaStatus.InitMedia;
  File? image;

  Future<void> getImageFromLibrary() async {
    final ImagePicker picker = ImagePicker();
    status = MediaStatus.LoadingImage;
    notifyListeners();

    try {
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      if (photo != null) {
        image = File(photo.path);
        status = MediaStatus.SuccessLoad;
      } else {
        status = MediaStatus.FailedLoad;
      }
    } catch (e) {
      status = MediaStatus.FailedLoad;
    }
    notifyListeners();
  }
}
