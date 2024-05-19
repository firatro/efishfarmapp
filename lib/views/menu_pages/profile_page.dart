import 'dart:developer';

import 'package:efishfarmapp/app_constants/app_assets.dart';
import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/core/extensions/l10n_exntesions.dart';
import 'package:efishfarmapp/models/user_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/auth_pages/login_page.dart';
import 'package:efishfarmapp/views/farm_pages/wait_company_workers_page.dart';
import 'package:efishfarmapp/views/profile_pages/dark_mode_page.dart';
import 'package:efishfarmapp/views/profile_pages/language_page.dart';
import 'package:efishfarmapp/views/profile_pages/update_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grock/grock.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final box = GetStorage();
  MyUser? myUser;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    myUser = await ref.read(registerRiverpod).dbServices.getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SizedBox(
          height: 50,
          child: AppAssets.appLogo,
        ),
        actions: [
          Container(
            height: 40,
            width: 100,
            decoration: const BoxDecoration(
                color: Color(0xff074173),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                )),
            child: Center(
              child: Text(
                context.translate.profile,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 25)
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/app_bg.jpg"),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                color: ref.read(appRiverpod).isDarkMode == true
                    ? AppColors.black
                    : AppColors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                )),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            child: GestureDetector(
                              onTap: () {},
                              child: CircleAvatar(
                                radius: 40.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 35.0,
                                  backgroundImage: const AssetImage(
                                      "assets/img/no-profile-picture.png"),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.blue,
                                      radius: 12.0,
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 15.0,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Column(
                        children: [
                          Text(
                            myUser == null ? "" : "${myUser!.name} ${myUser!.surname} ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ref.read(appRiverpod).isDarkMode == true
                                  ? AppColors.white
                                  : AppColors.black.withOpacity(0.7),
                            ),
                          ),
                          Text(
                             myUser == null ? "" : "${myUser!.email} ",
                            style: TextStyle(
                              color: ref.read(appRiverpod).isDarkMode == true
                                  ? AppColors.white
                                  : AppColors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: ref.read(appRiverpod).isDarkMode == true
                            ? AppColors.lightBlue
                            : AppColors.lightGrey,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                context.translate.general_settings,
                                style: TextStyle(
                                  color:
                                      ref.read(appRiverpod).isDarkMode == true
                                          ? AppColors.white
                                          : AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Grock.to(DarkPage());
                        },
                        leading: Icon(
                          Icons.dark_mode,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                        title: Text(
                          context.translate.dark_mode,
                          style: TextStyle(
                            color: ref.read(appRiverpod).isDarkMode == true
                                ? AppColors.white
                                : AppColors.black.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      ListTile(
                        onTap: () {Grock.to(UpdateProfilePage());},
                        leading: Icon(
                          Icons.info,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                        title: Text(
                          context.translate.update_information,
                          style: TextStyle(
                            color: ref.read(appRiverpod).isDarkMode == true
                                ? AppColors.white
                                : AppColors.black.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.key,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                        title: Text(
                          context.translate.update_password,
                          style: TextStyle(
                            color: ref.read(appRiverpod).isDarkMode == true
                                ? AppColors.white
                                : AppColors.black.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Grock.to(LanguagePage());
                        },
                        leading: Icon(
                          Icons.language,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                        title: Text(
                          context.translate.language,
                          style: TextStyle(
                            color: ref.read(appRiverpod).isDarkMode == true
                                ? AppColors.white
                                : AppColors.black.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: ref.read(appRiverpod).isDarkMode == true
                            ? AppColors.lightBlue
                            : AppColors.lightGrey,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                context.translate.other_settings,
                                style: TextStyle(
                                  color:
                                      ref.read(appRiverpod).isDarkMode == true
                                          ? AppColors.white
                                          : AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                       ListTile(
                        onTap: () {
                          Grock.to(WaitCompanyWorkersPage());
                        },
                        leading: Icon(
                          Icons.notifications,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                        title: Text(
                          "Bekleyen Talepler",
                          style: TextStyle(
                            color: ref.read(appRiverpod).isDarkMode == true
                                ? AppColors.white
                                : AppColors.black.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                      ),
                   
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.info,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                        title: Text(
                          context.translate.about_us,
                          style: TextStyle(
                            color: ref.read(appRiverpod).isDarkMode == true
                                ? AppColors.white
                                : AppColors.black.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.description_sharp,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                        title: Text(
                          context.translate.terms_and_conditions,
                          style: TextStyle(
                            color: ref.read(appRiverpod).isDarkMode == true
                                ? AppColors.white
                                : AppColors.black.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.security,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                        title: Text(
                          context.translate.privacy,
                          style: TextStyle(
                            color: ref.read(appRiverpod).isDarkMode == true
                                ? AppColors.white
                                : AppColors.black.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.share,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                        title: Text(
                          context.translate.rate_us,
                          style: TextStyle(
                            color: ref.read(appRiverpod).isDarkMode == true
                                ? AppColors.white
                                : AppColors.black.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          ref.read(profileRiverpod).signOut();
                          Grock.to(const LoginPage());
                        },
                        leading: Icon(
                          Icons.logout,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                        title: Text(
                          context.translate.log_out,
                          style: TextStyle(
                            color: ref.read(appRiverpod).isDarkMode == true
                                ? AppColors.white
                                : AppColors.black.withOpacity(0.7),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ref.read(appRiverpod).isDarkMode == true
                              ? AppColors.white
                              : AppColors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
