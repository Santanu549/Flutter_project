import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/screens/DashboardScreen.dart';
import 'package:pet_shop_flutter/screens/auth/ForgotPasswordScreen.dart';
import 'package:pet_shop_flutter/screens/auth/SignUpScreen.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class SignInScreen extends StatefulWidget {
  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  Future<void> signIn() async {
    hideKeyboard(context);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      appStore.setLoading(true);

      Map req = {
        'username': emailController.text.trim(),
        'password': passWordController.text.trim(),
        //"login_type": LoginTypeApp,
      };

      await logInApi(req).then((value) async {
        appStore.setLoading(false);

        DashboardScreen().launch(context, isNewTask: true);
      }).catchError((e) {
        appStore.setLoading(false);

        snack(e.toString());
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
      appBar: appBarWidget('', elevation: 0, showBack: false),
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
                  Text(language!.signIn, style: boldTextStyle(size: 22)),
                  8.height,
                  Text(language!.confirmLogOut, style: primaryTextStyle()),
                  32.height,
                  AppTextField(
                    controller: emailController,
                    errorThisFieldRequired: language!.fieldRequired,
                    textFieldType: TextFieldType.EMAIL,
                    decoration: buildInputDecoration(language!.email),
                    focus: emailFocus,
                    nextFocus: passwordFocus,
                  ),
                  32.height,
                  AppTextField(
                    controller: passWordController,
                    errorThisFieldRequired: language!.fieldRequired,
                    textFieldType: TextFieldType.PASSWORD,
                    decoration: buildInputDecoration(language!.password),
                    focus: passwordFocus,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(language!.forgotPassword, style: boldTextStyle(color: primaryColor)),
                      onPressed: () {
                        ForgotPasswordScreen().launch(context);
                      },
                    ),
                  ),
                  16.height,
                  AppButton(
                    width: context.width(),
                    text: language!.login,
                    textStyle: boldTextStyle(),
                    onTap: () {
                      signIn();
                    },
                  ),
                  16.height,
                  /*AppButton(
                    elevation: 0.5,
                    onTap: () {
                      //
                    },
                    child: GoogleLogoWidget(),
                  ).center(),
                  16.height,*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(language!.noAccount, style: primaryTextStyle()),
                      TextButton(
                        onPressed: () {
                          SignUpScreen().launch(context);
                        },
                        child: Text(language!.register, style: boldTextStyle(color: primaryColor)),
                      )
                    ],
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
