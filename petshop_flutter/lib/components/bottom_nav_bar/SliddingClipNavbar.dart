import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/bottom_nav_bar/AnimatedButton.dart';
import 'package:pet_shop_flutter/model/NavBarItemModel.dart';

typedef OnButtonPressCallback = void Function(int index);

class AnimatedBottomNavBar extends StatelessWidget {
  final List<BottomBarItem> barItems;
  final int selectedIndex;
  final double iconSize;
  final Color? _activeColor;
  final Color? _inactiveColor;
  final OnButtonPressCallback onButtonPressed;
  final Color backgroundColor;

  AnimatedBottomNavBar({
    required this.barItems,
    required this.selectedIndex,
    required this.onButtonPressed,
    required Color activeColor,
    Color? inactiveColor,
    this.iconSize = 24,
    this.backgroundColor = Colors.white,
  })  : _activeColor = activeColor,
        _inactiveColor = inactiveColor ?? activeColor.withOpacity(0.4),
        assert(barItems.length > 1, 'You must provide minimum 2 Menu items'),
        assert(barItems.length <= 5, 'Maximum menu item count is 5');

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: kBottomNavigationBarHeight,
      decoration: boxDecorationDefault(
        color: backgroundColor,
        borderRadius: radiusOnly(topRight: defaultRadius, topLeft: defaultRadius),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: barItems.map<Widget>(
          (item) {
            final buttonIndex = barItems.indexOf(item);
            return AnimatedButton(
              icon: item.icon,
              size: iconSize,
              title: item.title,
              activeColor: item.activeColor ?? _activeColor!,
              inactiveColor: item.inactiveColor ?? _inactiveColor!,
              index: buttonIndex,
              isSelected: buttonIndex == selectedIndex ? true : false,
              onTap: onButtonPressed,
              slidingCardColor: backgroundColor,
              itemCount: barItems.length,
            );
          },
        ).toList(),
      ),
    );
  }
}
