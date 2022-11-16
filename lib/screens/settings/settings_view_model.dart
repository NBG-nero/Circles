import 'dart:developer';
import 'dart:io';

// import 'package:circles/screens/base_model.dart';
import 'package:circles/models/user_chat.dart';
import 'package:circles/screens/home/home_view_model.dart';
import 'package:circles/utilities/constants/constants.dart';
import 'package:circles/utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsViewModel extends HomeViewModel {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  String id = "";
  String nickname = "";
  String aboutMe = "";
  String photoUrl = "";
  String phoneNumber = "";

  bool isloading = false;
  File? avatarImageFile;

  final FocusNode focusNickname = FocusNode();
  final FocusNode focusAboutMe = FocusNode();

  String dialoCodedigits = "+243";
  TextEditingController? nickCtrl;
  TextEditingController? aboutMeCtrl;

  final TextEditingController pController = TextEditingController();
  setName(val) {
    nickname = val;
    notifyListeners();
  }

  setAboutMe(val) {
    aboutMe = val;
    notifyListeners();
  }

  setdialCodes(val) {
    dialoCodedigits = val;
    notifyListeners();
  }

  Future<String?> getprefs(String key) async {
    await initPrefs();
    return prefs?.getString(key);
  }

  Future<bool?> setPrefs(String key, String value) async {
    await initPrefs();
    return await prefs?.setString(key, value);
  }

  UploadTask upload(File image, String filename) {
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

  void readLocal() async {
    await initPrefs();
    id = prefs?.getString(FirestoreConstants.id) ?? "";
    nickname = prefs?.getString(FirestoreConstants.nickname) ?? "";
    aboutMe = prefs?.getString(FirestoreConstants.aboutMe) ?? "";
   

    getprefs(FirestoreConstants.photoUrl).then((value) {
      photoUrl = value!;
    });
    notifyListeners();

    getprefs(FirestoreConstants.phoneNumber).then((value) {
      phoneNumber = value!;
    });
    notifyListeners();

    nickCtrl = TextEditingController(text: nickname);
    log(nickname);
    notifyListeners();

    aboutMeCtrl = TextEditingController(text: aboutMe);
    log(aboutMe);
    notifyListeners();

    log(photoUrl);
    notifyListeners();
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickdFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((err) {
      showErrorToast(err.toString());
    });
    File? image;
    if (pickdFile != null) {
      image = File(pickdFile.path);
    }
    if (image != null) {
      avatarImageFile = image;
      isloading = true;
      notifyListeners();
      uploadFile();
    } else {
      isloading = false;
      notifyListeners();
    }
  }

  Future uploadFile() async {
    String fileName = id;
    UploadTask uploadTask = upload(avatarImageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      photoUrl = await snapshot.ref.getDownloadURL();

      UserChat updateInfo = UserChat(
        id: id,
        nickname: nickname,
        aboutMe: aboutMe,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
      );
      updateDataFirestore(
              FirestoreConstants.pathUserCollection, id, updateInfo.toJson())
          .then((data) async {
        await setPrefs(FirestoreConstants.photoUrl, photoUrl);
        isloading = false;
        notifyListeners();
      });
    } on FirebaseException catch (e) {
      isloading = false;
      notifyListeners();
      showErrorToast(e.toString());
    } catch (err) {
      isloading = false;
      notifyListeners();
      showErrorToast(err.toString());
    }
  }

  void handleUpdateData() {
    focusNickname.unfocus();
    focusAboutMe.unfocus();
    isloading = true;
    if (dialoCodedigits != "00" && pController.text != "") {
      phoneNumber = dialoCodedigits + pController.text.toString();
    }
    notifyListeners();
    UserChat updateInfo = UserChat(
      id: id,
      nickname: nickname,
      aboutMe: aboutMe,
      photoUrl: photoUrl,
      phoneNumber: phoneNumber,
    );

    updateDataFirestore(
            FirestoreConstants.pathUserCollection, id, updateInfo.toJson())
        .then((data) async {
      await setPrefs(FirestoreConstants.nickname, nickname);
      await setPrefs(FirestoreConstants.aboutMe, aboutMe);
      await setPrefs(FirestoreConstants.photoUrl, photoUrl);
      await setPrefs(FirestoreConstants.phoneNumber, phoneNumber);
      isloading = false;
      notifyListeners();
      showToast("Update success");
    }).catchError((err) {
      isloading = false;
      notifyListeners();
      showErrorToast(err.toString());
    });
  }
}
