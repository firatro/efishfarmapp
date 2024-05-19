import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AppRiverpod extends ChangeNotifier {
  final box = GetStorage();
  final bool isDarkMod = false;

  bool isDarkMode() {
    return bool.parse(box.read("dark_mode"));
  }
}
