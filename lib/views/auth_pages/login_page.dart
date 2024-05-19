import 'package:efishfarmapp/app_constants/app_assets.dart';
import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/auth_pages/forgot_password_page.dart';
import 'package:efishfarmapp/views/auth_pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: AppColors.blue,
                image: DecorationImage(
                  image: AssetImage("assets/img/app_bg.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              width: size.width * 0.99,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/img/app_logo.png", height: 100),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "E-FISH\n FARM",
                      style: TextStyle(
                        fontSize: 57,
                        height: 1,
                        wordSpacing: 0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Text(
                      "Hoşgeldiniz",
                      style: TextStyle(
                        fontSize: 27,
                        height: 1,
                        wordSpacing: 0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20.0,
                        left: 20.0,
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.contains("@") == false) {
                            return "Lütfen geçerli bir e-posta giriniz";
                          }
                          return null;
                        },
                        controller: emailController,
                        cursorColor: Colors.white,
                        cursorWidth: 3,
                        onChanged: (String value) {},
                        style: TextStyle(color: AppColors.white),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: AppColors.white),
                          filled: true,
                          fillColor: AppColors.white.withOpacity(0.3),
                          hintText: "E-Posta",
                          prefixIcon: Icon(
                            Icons.mail,
                            color: AppColors.white,
                          ),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Şifre alanı boş geçilemez.";
                          }
                          return null;
                        },
                        controller: passwordController,
                        cursorColor: Colors.white,
                        cursorWidth: 3,
                        onChanged: (String value) {},
                        style: TextStyle(color: AppColors.white),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: AppColors.white,
                          ),
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            size: 20,
                            color: AppColors.white,
                          ),
                          hintStyle: TextStyle(color: AppColors.white),
                          filled: true,
                          fillColor: AppColors.white.withOpacity(0.3),
                          hintText: "Şifre",
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ref.read(loginRiverpod).email =
                                      emailController.text;
                                  ref.read(loginRiverpod).password =
                                      passwordController.text;

                                  ref.read(loginRiverpod).login();
                                } else {
                                  Grock.toast(
                                      text: "Lütfen bilgileri kontrol ediniz.",
                                      backgroundColor: AppColors.red);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                              ),
                              child: Text(
                                "Giriş Yap",
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1,
                                  wordSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20.0,
                        left: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Grock.to(ForgotPasswordPage());
                            },
                            child: Text(
                              "Şifremi Unuttum",
                              style: TextStyle(
                                fontSize: 15,
                                height: 1,
                                wordSpacing: 0,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Grock.to(RegisterPage());
                            },
                            child: Text(
                              "Bize Katıl",
                              style: TextStyle(
                                fontSize: 15,
                                height: 1,
                                wordSpacing: 0,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
