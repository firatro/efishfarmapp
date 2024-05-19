import 'package:efishfarmapp/app_constants/app_assets.dart';
import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/app_bg.jpg"),
                    fit: BoxFit.cover),
              ),
              width: size.width * 0.99,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Column(
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
                          SizedBox(height: size.height * 0.03),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 20.0,
                                  left: 20.0,
                                ),
                                child: Text(
                                  'Şifreni mi Unuttun?',
                                  style: TextStyle(
                                    fontSize: 21,
                                    height: 1,
                                    wordSpacing: 0,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.lightBlue,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 20.0,
                                  left: 20.0,
                                ),
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  cursorWidth: 3,
                                  onChanged: (String value) {},
                                  style: TextStyle(color: AppColors.white),
                                  decoration: InputDecoration(
                                    hintStyle:
                                        TextStyle(color: AppColors.white),
                                    filled: true,
                                    fillColor:
                                        AppColors.lightBlue.withOpacity(0.3),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 20.0,
                                  left: 20.0,
                                ),
                                child: SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor:
                                                AppColors.lightBlue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 15),
                                          ),
                                          child: Text(
                                            "Onayla",
                                            style: TextStyle(
                                              fontSize: 21,
                                              height: 1,
                                              wordSpacing: 0,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
/*
      bottomSheet: SizedBox(
        height: size.height * 0.5,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                  left: 20.0,
                ),
                child: Text(
                  'Şifreni mi Unuttun?',
                  style: TextStyle(
                    fontSize: 21,
                    height: 1,
                    wordSpacing: 0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightBlue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                  left: 20.0,
                ),
                child: TextFormField(
                  cursorColor: Colors.white,
                  cursorWidth: 3,
                  onChanged: (String value) {},
                  style: TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: AppColors.white),
                    filled: true,
                    fillColor: AppColors.lightBlue.withOpacity(0.3),
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
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                  left: 20.0,
                ),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppColors.lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          child: Text(
                            "Onayla",
                            style: TextStyle(
                              fontSize: 21,
                              height: 1,
                              wordSpacing: 0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
  */
    );
  }
}
