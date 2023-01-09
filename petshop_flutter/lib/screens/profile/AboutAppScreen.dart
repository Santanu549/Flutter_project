import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

import '../../main.dart';

class AboutAppScreen extends StatefulWidget {
  @override
  AboutAppScreenState createState() => AboutAppScreenState();
}

class AboutAppScreenState extends State<AboutAppScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: appBarWidget(language!.about, color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(appName, style: primaryTextStyle(size: 30)),
              16.height,
              Container(
                decoration: BoxDecoration(color: primaryColor, borderRadius: radius(4)),
                height: 4,
                width: 100,
              ),
              16.height,
              Text(language!.version, style: secondaryTextStyle()),
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (_, snap) {
                  if (snap.hasData) {
                    return Text('${snap.data!.version.validate()}', style: primaryTextStyle());
                  }
                  return SizedBox();
                },
              ),
              16.height,
              Text(
                mAppInfo,
                style: primaryTextStyle(size: 14),
                textAlign: TextAlign.justify,
              ),
              16.height,
              AppButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.contact_support_outlined, color: context.iconColor),
                    8.width,
                    Text(language!.purchase, style: boldTextStyle()),
                  ],
                ),
                onTap: () {
                  launchUrl('mailto:${getStringAsync(CONTACT_PREF)}');
                },
              ),
              16.height,
              AppButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/ic_purchase.png', height: 24, color: context.iconColor),
                    8.width,
                    Text(language!.contactUs, style: boldTextStyle()),
                  ],
                ),
                onTap: () {
                  launchUrl(iqonicURL);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
