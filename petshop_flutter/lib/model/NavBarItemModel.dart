import 'package:flutter/material.dart';

class BottomBarItem {
  final IconData icon;
  final Color? activeColor;
  final Color? inactiveColor;
  final String title;

  BottomBarItem({
    required this.title,
    required this.icon,
    this.activeColor,
    this.inactiveColor,
  });
}
