import 'dart:developer';

import 'package:efishfarmapp/models/user_model.dart';
import 'package:efishfarmapp/riverpod/riverpod_management.dart';
import 'package:efishfarmapp/views/menu_pages/company_page.dart';
import 'package:efishfarmapp/views/menu_pages/home_page.dart';
import 'package:efishfarmapp/views/menu_pages/message_page.dart';
import 'package:efishfarmapp/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:efishfarmapp/widgets/custom_bottom_navigation_bar/tab_items.dart';
import 'package:efishfarmapp/views/menu_pages/profile_page.dart';
import 'package:efishfarmapp/views/menu_pages/farm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  TabItem _currentTab = TabItem.Tab1;
  MyUser? myUser;
  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.Tab1: GlobalKey<NavigatorState>(),
    TabItem.Tab2: GlobalKey<NavigatorState>(),
    TabItem.Tab3: GlobalKey<NavigatorState>(),
    TabItem.Tab4: GlobalKey<NavigatorState>(),
    TabItem.Tab5: GlobalKey<NavigatorState>(),
  };
  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    await ref.read(registerRiverpod).dbServices.currentUser();
    myUser = await ref.read(registerRiverpod).dbServices.getUser();
  }

  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.Tab1: const ProfilePage(),
      TabItem.Tab2: const FarmPage(),
      TabItem.Tab3: HomePage(
      ),
      TabItem.Tab4: CompanyPage(),
      TabItem.Tab5:  MessagePage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: CustomBottomNavigation(
        navigatorKeys: navigatorKeys,
        sayfaOlusturucu: tumSayfalar(),
        currentTab: _currentTab,
        onSelectedTab: (secilenTab) {
          if (secilenTab == _currentTab) {
            navigatorKeys[secilenTab]!
                .currentState!
                .popUntil((route) => route.isFirst);
          } else {
            setState(() {
              _currentTab = secilenTab;
            });
          }

          log("Seçilen Tab Item: ${secilenTab.toString()}");
        },
      ),
    );
  }
}
