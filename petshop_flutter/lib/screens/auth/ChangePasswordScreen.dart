import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confNewPassword = TextEditingController();

  FocusNode newPassFocus = FocusNode();
  FocusNode conPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      Map req = {
        'old_password': oldPassword.text.trim(),
        'new_password': newPassword.text.trim(),
      };
      appStore.setLoading(true);

      await changePassword(req).then((value) {
        snackBar(context, title: value.message.validate());

        appStore.setLoading(false);

        finish(context);
      }).catchError((error) {
        appStore.setLoading(false);

        snack(error.toString());
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: appBarWidget(language!.changePassword, elevation: 0, color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                children: [
                  AppTextField(
                    controller: oldPassword,
                    errorThisFieldRequired: language!.fieldRequired,
                    nextFocus: newPassFocus,
                    textFieldType: TextFieldType.PASSWORD,
                    textStyle: primaryTextStyle(color: gray),
                    decoration: buildInputDecoration(language!.oldPassword),
                  ),
                  16.height,
                  AppTextField(
                    controller: newPassword,
                    errorThisFieldRequired: language!.fieldRequired,
                    focus: newPassFocus,
                    nextFocus: conPassFocus,
                    textFieldType: TextFieldType.PASSWORD,
                    textStyle: primaryTextStyle(color: gray),
                    decoration: buildInputDecoration(language!.newPassword),
                  ),
                  16.height,
                  AppTextField(
                    controller: confNewPassword,
                    errorThisFieldRequired: language!.fieldRequired,
                    focus: conPassFocus,
                    textFieldType: TextFieldType.PASSWORD,
                    textStyle: primaryTextStyle(color: gray),
                    validator: (val) {
                      if (val!.isEmpty) return language!.fieldRequired;
                      if (val != newPassword.text) return language!.passwordNotMatch;
                      return null;
                    },
                    decoration: buildInputDecoration(language!.passwordNotMatch),
                  ),
                  16.height,
                  AppButton(
                    text: language!.changePassword,
                    textStyle: boldTextStyle(),
                    width: context.width(),
                    onTap: () {
                      submit();
                    },
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  )
                ],
              ),
            ),
          ),
          Observer(builder: (_) => Loader().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
