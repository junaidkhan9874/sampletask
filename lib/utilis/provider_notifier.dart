import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turing_task/utilis/user_model.dart';

class ProviderNotifier extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void checkVisible() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  File _selectedImage = File("");

  File get selectedImage => _selectedImage;

  void setImage(String imagePath) {
    _selectedImage = File(imagePath);
    notifyListeners();
  }

  final List<UserModel> _userList = [];

  List<UserModel> get userList => _userList;

  Future<void> getUsers() async {
    _userList.clear();
    var snapshot = await FirebaseFirestore.instance.collection('Users').get();
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        var model = UserModel.fromJson(element.data(), element.id);
        _userList.add(model);
      }
    }
    notifyListeners();
  }

  void getRealTimeUsers() {
    FirebaseFirestore.instance.collection("Users").snapshots().listen((event) {
      if (userList.isNotEmpty) {
        UserModel updatedUser =
            UserModel.fromJson(event.docChanges.first.doc.data()!, event.docChanges.first.doc.id);
        int index = userList.indexWhere((element) => element.userId == updatedUser.userId);
        userList[index] = updatedUser;
        notifyListeners();
      }
    });
  }

  Future<void> updateUserName(String snapShotId, String name) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(snapShotId)
        .update({"name": name}).then((value) async {
    });
  }
}
