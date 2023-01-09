import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/screens/auth/ChangePasswordScreen.dart';
import 'package:pet_shop_flutter/screens/auth/SignInScreen.dart';
import 'package:pet_shop_flutter/screens/order/OrderListScreen.dart';
import 'package:pet_shop_flutter/screens/profile/AboutAppScreen.dart';
import 'package:pet_shop_flutter/screens/profile/EditProfileScreen.dart';
import 'package:pet_shop_flutter/screens/profile/components/ThemeChangerWidget.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';
import 'package:share_plus/share_plus.dart';

import '../../main.dart';

class ProfileFragment extends StatefulWidget {
  static String tag = '/ProfileFragment';

  @override
  ProfileFragmentState createState() => ProfileFragmentState();
}

class ProfileFragmentState extends State<ProfileFragment> {
  double themeModeIndex = 3;
  XFile? image;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  Widget profileImage() {
    if (image != null) {
      return Image.file(File(image!.path), height: 50, width: 50, fit: BoxFit.cover, alignment: Alignment.center).cornerRadiusWithClipRRect(25).center();
    } else {
      return commonCacheImage(appStore.userImage.validate(), fit: BoxFit.cover, height: 50, width: 50).cornerRadiusWithClipRRect(25).center();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Observer(builder: (_) => profileImage()),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  4.height,
                  Text(appStore.firstName, style: boldTextStyle()),
                  Text(appStore.userEmail, style: primaryTextStyle(size: 14)),
                ],
              ).expand(),
              IconButton(
                onPressed: () {
                  EditProfileScreen().launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                },
                icon: Icon(Icons.edit, color: primaryColor),
              ),
            ],
          ).paddingOnly(left: 16, top: 16, right: 8, bottom: 8).visible(appStore.isLoggedIn),
          Divider(color: Colors.grey).visible(appStore.isLoggedIn),
          Text(language!.appSetting, style: boldTextStyle()).paddingSymmetric(horizontal: 16, vertical: 8),
          Wrap(
            runSpacing: 8,
            spacing: 16,
            children: [
              ThemeChangerWidget(),
              appSettingData(
                context: context,
                width: (context.width() / 2) - 16,
                title: language!.language,
                icon: FontAwesome.language,
                subTitle: language!.language,
                onTap: () {
                  Scaffold(
                    appBar: appBarWidget(language!.language),
                    body: LanguageListWidget(
                      widgetType: WidgetType.LIST,
                      onLanguageChange: (v) async {
                        await appStore.setLanguage(v.languageCode!);

                        LiveStream().emit(streamRefresh);

                        setState(() {});
                        finish(context);
                      },
                    ).paddingSymmetric(vertical: 16),
                  ).launch(context);
                },
              ),
            ],
          ),
          Text(language!.other, style: boldTextStyle()).paddingSymmetric(horizontal: 16, vertical: 8),
          Wrap(
            runSpacing: 12,
            spacing: 16,
            children: [
              appSettingData(
                  context: context,
                  width: (context.width() / 2) - 16,
                  title: language!.orders,
                  subTitle: language!.getOrder,
                  icon: Ionicons.list,
                  onTap: () {
                    OrderListScreen().launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                  }),
              appSettingData(
                context: context,
                width: (context.width() / 2) - 16,
                title: language!.changePassword,
                subTitle: language!.changePassword,
                icon: Ionicons.key_outline,
                onTap: () {
                  ChangePasswordScreen().launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                },
              ),
              appSettingData(
                context: context,
                width: (context.width() / 2) - 16,
                title: language!.privacyPolicy,
                subTitle: language!.privacyPolicy,
                icon: Icons.assignment_outlined,
                onTap: () {
                  if (PrivacyPolicy.isNotEmpty) {
                    launchUrl(PrivacyPolicy, forceWebView: true);
                  }
                },
              ),
              appSettingData(
                context: context,
                width: (context.width() / 2) - 16,
                title: language!.helpSupport,
                subTitle: language!.helpSupport,
                icon: Icons.support_rounded,
                onTap: () {
                  launchUrl(helpSupport, forceWebView: true);
                },
              ),
              appSettingData(
                context: context,
                width: (context.width() / 2) - 16,
                title: language!.share,
                subTitle: language!.share,
                icon: Icons.share_outlined,
                onTap: () {
                  PackageInfo.fromPlatform().then((value) {
                    String package = '';
                    if (isAndroid) package = value.packageName;

                    Share.share('Share $appName app\n\n${storeBaseURL()}$package');
                  });
                },
              ),
              appSettingData(
                context: context,
                width: (context.width() / 2) - 16,
                title: language!.about,
                subTitle: language!.about,
                icon: Icons.info_outline,
                onTap: () {
                  AboutAppScreen().launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                },
              ),
              appSettingData(
                context: context,
                width: (context.width() / 2) - 16,
                title: appStore.isLoggedIn ? language!.logout : language!.login,
                subTitle: appStore.isLoggedIn ? language!.logout : language!.login,
                icon: Icons.exit_to_app_rounded,
                onTap: () async {
                  if (appStore.isLoggedIn) {
                    await showConfirmDialogCustom(
                      context,
                      primaryColor: primaryColor,
                      title: language!.logoutMsg,
                      onAccept: (c) {
                        logout(context);
                      },
                    );
                  } else {
                    SignInScreen().launch(context);
                  }
                },
              ),
            ],
          ),
          //endregion
        ],
      ).paddingOnly(left: 8),
    );
  }
}
