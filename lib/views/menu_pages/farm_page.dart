import 'dart:developer';

import 'package:efishfarmapp/app_constants/app_assets.dart';
import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/core/extensions/l10n_exntesions.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/auth_pages/existing_company_page.dart';
import 'package:efishfarmapp/views/auth_pages/new_company_page.dart';
import 'package:efishfarmapp/views/farm_pages/cage_page.dart';
import 'package:efishfarmapp/views/farm_pages/company_profile_page.dart';
import 'package:efishfarmapp/views/farm_pages/filo_page.dart';
import 'package:efishfarmapp/views/farm_pages/statistics_page.dart';
import 'package:efishfarmapp/views/farm_pages/task_page.dart';
import 'package:efishfarmapp/views/menu_pages/profile_page.dart';
import 'package:efishfarmapp/views/profile_pages/dark_mode_page.dart';
import 'package:efishfarmapp/views/profile_pages/language_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restart_app/restart_app.dart';

class FarmPage extends ConsumerStatefulWidget {
  const FarmPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FarmPageState();
}

class _FarmPageState extends ConsumerState<FarmPage> {
  bool _selected = false;
  bool _enabled = false;
  final box = GetStorage();
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    registeredCompanyCheck();
    super.initState();
  }

  registeredCompanyCheck() async {
    if (await ref.read(farmRiverpod).dbServices.registeredCompanyCheck()) {
      log("şirket bilgisi var");
    } else {
      log("şirket bilgisi yok");

      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          titleTextStyle: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          contentTextStyle: TextStyle(
            color: AppColors.black,
            fontSize: 18,
          ),
          backgroundColor: AppColors.lightGrey,
          title: const Text('Onaylanmış Şirket Kaydınız Yok'),
          actionsAlignment: MainAxisAlignment.center,
          content: const Text(
              'Şirket profili oluşturmak ya da üyesi olmak ister misiniz?'),
          actions: <Widget>[
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NewCompanyPage()));
                  },
                  child: Text(
                    'Yeni Şirket Oluştur',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ExistingCompanyPage()));
                  },
                  child: Text(
                    'Varolan Şirkete Katıl',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Restart.restartApp();
                  },
                  child: Text('Geri Dön',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              height: 40,
              width: 100,
              decoration: const BoxDecoration(
                  color: Color(0xff074173),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  )),
              child: const Center(
                child: Text(
                  "Çiftlik",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 25)
          ],
          bottom: TabBar(
            labelColor: AppColors.blue,
            isScrollable: true,
            indicatorColor: AppColors.blue,
            tabs: <Widget>[
              Tab(
                text: "Şirket Profili",
              ),
              Tab(
                text: "Görevler",
              ),
              Tab(
                text: "Kafesler",
              ),
              Tab(
                text: "Filo",
              ),
              Tab(
                text: "İstatistikler",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: TabCompany(),
            ),
            Center(
              child: TaskList(),
            ),
            Center(
              child: Cage(),
            ),
            Center(
              child: Filo(),
            ),
            Center(
              child: Statistics(),
            ),
          ],
        ),
      ),
    );
  }
}
