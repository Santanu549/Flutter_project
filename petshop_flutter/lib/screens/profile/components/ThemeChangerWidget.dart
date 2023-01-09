import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class ThemeChangerWidget extends StatefulWidget {
  @override
  _ThemeChangerWidgetState createState() => _ThemeChangerWidgetState();
}

class _ThemeChangerWidgetState extends State<ThemeChangerWidget> {
  double themeModeIndex = 3;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    //
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: ((context.width() / 2) - 16) / themeModeIndex,
          height: 106,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(defaultRadius),
              bottomLeft: Radius.circular(defaultRadius),
              topRight: themeModeIndex == 1.0 ? Radius.circular(defaultRadius) : Radius.circular(0),
              bottomRight: themeModeIndex == 1.0 ? Radius.circular(defaultRadius) : Radius.circular(0),
            ),
            color: primaryColor.withOpacity(0.3),
          ),
        ),
        GestureDetector(
          onHorizontalDragUpdate: (s) async {
            double index = (s.localPosition.dx) / ((context.width() / 2) - 16);
            if (index >= 0.0000 && index <= 0.3333) {
              themeModeIndex = 3;
              appStore.setDarkMode(false);
              await setValue(THEME_MODE_INDEX, themeModeIndex);
            } else if (index >= 0.3333 && index <= 0.6666) {
              themeModeIndex = 1.5;
              appStore.setDarkMode(true);
              await setValue(THEME_MODE_INDEX, themeModeIndex);
            } else if (index >= 0.6666 && index <= 0.9999) {
              themeModeIndex = 1;
              appStore.setDarkMode(context.platformBrightness() == Brightness.dark);
              await setValue(THEME_MODE_INDEX, themeModeIndex);
            }

            setState(() {});
          },
          child: appSettingData(
            context: context,
            width: (context.width() / 2) - 16,
            title: '${themeModeIndex == 3.0 ? language!.light : themeModeIndex == 1.5 ? language!.dark : language!.system} ${language!.theme}',
            icon: Icons.dark_mode,
            subTitle: language!.slideThemeMode,
            onTap: () {
              //
            },
          ),
        ),
      ],
    );
  }
}
