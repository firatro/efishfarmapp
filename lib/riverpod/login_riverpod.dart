import 'dart:developer';

import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/services/db_services.dart';
import 'package:efishfarmapp/views/other_pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

class LoginRiverpod extends ChangeNotifier {
  String? email;
  String? password;

  final dbServices = DbServices();
  login() => dbServices.login(email: email, password: password).then(
        (value) => {
          if (value == true)
            {
              log("Giriş başarılı"),
              Grock.to(
                LandingPage(),
              ),
            }
          else
            {
              Grock.toast(
                  text: "Bilgilerinizi kontrol ediniz",
                  backgroundColor: AppColors.red)
            }
        },
      );
}
