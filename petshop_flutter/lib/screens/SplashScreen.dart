import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pet_shop_flutter/components/SplashWidget.dart';
import 'package:pet_shop_flutter/screens/DashboardScreen.dart';
import 'package:pet_shop_flutter/screens/WalkThroughScreen.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';
import 'package:pet_shop_flutter/utils/AppImages.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snap) {
          if (snap.hasData) {
            return SplashWidget(
              appName: appName,
              imagePath: appLogo,
              appVersion: 'v${snap.data!.version.validate()}',
              onAnimationEnd: () {
                if (getBoolAsync(IS_FIRST_TIME, defaultValue: true)) {
                  WalkThroughScreen().launch(context, isNewTask: true);
                } else {
                  DashboardScreen().launch(context, isNewTask: true);
                }
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
