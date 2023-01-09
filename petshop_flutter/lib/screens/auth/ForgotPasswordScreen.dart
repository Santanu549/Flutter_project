import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  FocusNode emailFocus = FocusNode();

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
        'email': emailController.text.trim(),
      };
      appStore.setLoading(true);

      await forgotPassword(req).then((value) {
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
      appBar: appBarWidget('', elevation: 0, color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 16, right: 16, left: 16),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(language!.forgotPassword, style: boldTextStyle(size: 22)),
                  8.height,
                  Text(language!.resetPassword, style: secondaryTextStyle()),
                  32.height,
                  AppTextField(
                    controller: emailController,
                    errorThisFieldRequired: language!.fieldRequired,
                    textFieldType: TextFieldType.EMAIL,
                    decoration: buildInputDecoration(language!.email),
                    focus: emailFocus,
                  ),
                  32.height,
                  AppButton(
                    width: context.width(),
                    text: language!.submit,
                    textStyle: boldTextStyle(),
                    onTap: () {
                      submit();
                    },
                  ),
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
