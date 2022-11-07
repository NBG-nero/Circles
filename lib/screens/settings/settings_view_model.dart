import 'dart:io';

// import 'package:circles/screens/base_model.dart';
import 'package:circles/screens/home/home_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingsViewModel extends HomeViewModel {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String?> getprefs(String key) async {
    await initPrefs();
    return prefs?.getString(key);
  }

  Future<bool?> setPrefs(String key, String value) async {
    await initPrefs();
    return await prefs?.setString(key, value);
  }

  UploadTask uploadTask(File image, String filename) {
    Reference reference = firebaseStorage.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateDataFirestore(
      String collectionPath, String path, Map<String, dynamic> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(dataNeedUpdate);
  }
}
