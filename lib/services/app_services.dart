import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AppServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference companies =
      FirebaseFirestore.instance.collection('companies');
  User? user = FirebaseAuth.instance.currentUser;
  File? image;

  Future<File?> pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return null;

      final imageTemp = File(image.path);

      this.image = imageTemp;
      return this.image;
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
    return null;
  }

  Future<File?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return null;

      final imageTemp = File(image.path);

      this.image = imageTemp;
      return this.image;
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
    return null;
  }
}
