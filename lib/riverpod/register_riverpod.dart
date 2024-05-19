import 'package:efishfarmapp/models/company_model.dart';
import 'package:efishfarmapp/models/user_model.dart';
import 'package:efishfarmapp/services/db_services.dart';
import 'package:efishfarmapp/views/menu_pages/farm_page.dart';
import 'package:efishfarmapp/views/other_pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class RegisterRiverpod extends ChangeNotifier {
  final dbServices = DbServices();
  MyUser? newUser;
  Company? newCompany;

  addUser() => dbServices.addUser(myUser: newUser);
  searchCompany(String? keyword) => dbServices.searchCompany(keyword: keyword);
  addCompany() => dbServices
      .addCompany(company: newCompany)
      .then((value) => Grock.toRemove(const LandingPage()));

  updateCompany() => dbServices
      .addCompany(company: newCompany)
      .then((value) => Grock.toRemove(const FarmPage()));
  getCurrentUserId() => dbServices.currentUser();
  getUser({String? userId}) => dbServices.getUser(userId: userId);
}
