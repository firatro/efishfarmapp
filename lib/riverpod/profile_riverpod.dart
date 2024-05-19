import 'package:efishfarmapp/services/db_services.dart';
import 'package:flutter/material.dart';

class ProfileRiverpod extends ChangeNotifier {
  final dbServices = DbServices();

  signOut() => dbServices.signOut();
}
