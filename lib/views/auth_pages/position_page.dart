import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/app_constants/e_fish_farm_app_icons.dart';
import 'package:efishfarmapp/models/company_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/other_pages/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PositionPage extends ConsumerStatefulWidget {
  const PositionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PositionPageState();
}

const List<String> positionList = <String>[
  'Seçiniz',
  'Şirket Oluştur',
  'Mevcut Şirkete Katıl',
];

class _PositionPageState extends ConsumerState<PositionPage> {
  TextEditingController searchCompanyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: AppColors.lightBlue,
            height: 4.0,
          ),
        ),
        centerTitle: true,
        title: Text("Mevcut Şirket Bilgileri"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.875,
          child: Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Şirketteki konumunuzu seçin",
                        style: TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      ref.read(registerRiverpod).newUser!.position = "MÜHENDİS";

                      ref.read(registerRiverpod).addUser();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LandingPage()));
                    },
                    leading: Icon(Icons.build),
                    title: Text(
                      "MÜHENDİS",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      ref.read(registerRiverpod).newUser!.position = "BALIKÇI";

                      ref.read(registerRiverpod).addUser();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LandingPage()));
                    },
                    leading: Icon(EFishFarmApp.farm_logo),
                    title: Text(
                      "BALIKÇI",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      ref.read(registerRiverpod).newUser!.position = "KAPTAN";

                      ref.read(registerRiverpod).addUser();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LandingPage()));
                    },
                    leading: Icon(Icons.directions_boat),
                    title: Text(
                      "KAPTAN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      ref.read(registerRiverpod).newUser!.position =
                          "TEDARİKÇİ";

                      ref.read(registerRiverpod).addUser();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LandingPage()));
                    },
                    leading: Icon(Icons.compare_arrows),
                    title: Text(
                      "TEDARİKÇİ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      ref.read(registerRiverpod).newUser!.position = "YETKİLİ";

                      ref.read(registerRiverpod).addUser();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LandingPage()));
                    },
                    leading: Icon(Icons.verified),
                    title: Text(
                      "YETKİLİ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      ref.read(registerRiverpod).newUser!.position =
                          "ÇİFTLİK SAHİBİ";

                      ref.read(registerRiverpod).addUser();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LandingPage()));
                    },
                    leading: Icon(EFishFarmApp.company_logo),
                    title: Text(
                      "ÇİFTLİK SAHİBİ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
