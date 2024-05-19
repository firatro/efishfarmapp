import 'package:efishfarmapp/app_constants/e_fish_farm_app_icons.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum TabItem { Tab1, Tab2, Tab3, Tab4, Tab5 }

class TabItemData {
  final String title;
  final IconData icon;

  TabItemData({required this.title, required this.icon});
  static Map<TabItem, TabItemData> tumTablar = {
    TabItem.Tab1: TabItemData(title: "Profilim", icon: Icons.person_outline),
    TabItem.Tab2: TabItemData(title: "Çiftlik", icon: EFishFarmApp.farm_logo),
    TabItem.Tab3: TabItemData(title: "Anasayfa", icon: Icons.home),
    TabItem.Tab4: TabItemData(title: "Şirketler", icon: EFishFarmApp.company_logo),
    TabItem.Tab5: TabItemData(title: "Mesajlar", icon: Icons.mail_outline),
  };
}
