import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/components/bottom_nav_bar/SliddingClipNavbar.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/NavBarItemModel.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Observer(
        builder: (_) => AppScaffold(
          body: IndexedStack(
            children: appStore.dashboardScreeList,
            index: appStore.index,
          ),
          bottomNavigationBar: AnimatedBottomNavBar(
            backgroundColor: context.cardColor,
            barItems: [
              BottomBarItem(title: language!.home, icon: Icons.cottage_outlined),
              BottomBarItem(title: language!.category, icon: Icons.now_widgets_outlined),
              BottomBarItem(title: language!.cart, icon: Icons.shopping_cart_outlined),
              BottomBarItem(title: language!.wishList, icon: Icons.favorite_border_rounded),
              BottomBarItem(title: language!.profile, icon: Icons.person_outline_rounded),
            ],
            selectedIndex: appStore.index,
            onButtonPressed: appStore.setBottomNavigationIndex,
            activeColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
