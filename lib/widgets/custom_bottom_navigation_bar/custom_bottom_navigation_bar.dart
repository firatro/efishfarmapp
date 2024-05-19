import 'package:efishfarmapp/app_constants/app_colors.dart';
import 'package:efishfarmapp/widgets/custom_bottom_navigation_bar/tab_items.dart';
import 'package:flutter/cupertino.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    super.key,
    required this.currentTab,
    required this.onSelectedTab,
    required this.sayfaOlusturucu,
    required this.navigatorKeys,
  });

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> sayfaOlusturucu;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: AppColors.white,
        backgroundColor: AppColors.blue,
        items: [
          _navItemOlustur(TabItem.Tab1),
          _navItemOlustur(TabItem.Tab2),
          _navItemOlustur(TabItem.Tab3),
          _navItemOlustur(TabItem.Tab4),
          _navItemOlustur(TabItem.Tab5),
        ],
        onTap: (index) => onSelectedTab(
          TabItem.values[index],
        ),
      ),
      tabBuilder: (context, index) {
        final gosterilecekItem = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[gosterilecekItem],
          builder: (context) {
            return sayfaOlusturucu[gosterilecekItem]!;
          },
        );
      },
    );
  }

  BottomNavigationBarItem _navItemOlustur(TabItem tabItem) {
    final olusturulacakTab = TabItemData.tumTablar[tabItem];
    return BottomNavigationBarItem(
      activeIcon: Icon(
        olusturulacakTab!.icon,
        size: 35,
      ),
      icon: Icon(olusturulacakTab.icon),
      label: olusturulacakTab.title,
    );
  }
}
