import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class HomeModel {
  final _picker = ImagePicker();

  Future<void> updateProfileImage() async {
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
    
    if(xFile != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('user/${FirebaseAuth.instance.currentUser?.uid}/profile/${DateTime.now().millisecondsSinceEpoch}.png');

      // 이미지 url 받기
      await imageRef.putFile(File(xFile.path));

      final downloadUrl = await imageRef.getDownloadURL();

      FirebaseAuth.instance.currentUser?.updatePhotoURL(downloadUrl);
    }
  }

  String getEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? 'No E-mail';
  }

  String getNickName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? 'No NickName';
  }

  String getProfileImageUrl() {
    return FirebaseAuth.instance.currentUser?.photoURL ?? 'https://blog.kakaocdn.net/dn/drkKUz/btrKzPmA6Xi/cLjppsVnQYYF2dggTuvCf0/img.png';
  }
}