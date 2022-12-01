import 'package:firebase_auth/firebase_auth.dart';

class DetailPostModel {
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