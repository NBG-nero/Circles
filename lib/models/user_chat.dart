import 'dart:developer';

import 'package:circles/utilities/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserChat {
  dynamic id;
  dynamic nickname;
  dynamic photoUrl;
  dynamic aboutMe;
  dynamic phoneNumber;
  UserChat({
    this.id,
    this.nickname,
    this.photoUrl,
    this.aboutMe,
    this.phoneNumber,
  });

  @override
  String toString() {
    return 'UserChat(id: $id, nickname: $nickname, photoUrl: $photoUrl, phoneNumber: $phoneNumber)';
  }

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.nickname: nickname,
      FirestoreConstants.aboutMe: aboutMe,
      FirestoreConstants.photoUrl: photoUrl,
      FirestoreConstants.phoneNumber: phoneNumber
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    dynamic aboutMe = '';
    dynamic photoUrl = '';
    dynamic nickname = '';
    dynamic phoneNumber = '';
    try {
      aboutMe = doc.get(FirestoreConstants.aboutMe);
    } catch (e) {
      log(e.toString());
    }
    try {
      photoUrl = doc.get(FirestoreConstants.photoUrl);
    } catch (e) {
      log(e.toString());
    }
    try {
      nickname = doc.get(FirestoreConstants.nickname);
    } catch (e) {
      log(e.toString());
    }
    try {
      phoneNumber = doc.get(FirestoreConstants.phoneNumber);
    } catch (e) {
      log(e.toString());
    }
    return UserChat(
      id: doc.id,
      photoUrl: photoUrl, 
      nickname: nickname, 
      aboutMe: aboutMe, 
      phoneNumber: phoneNumber
    );
  }
}
