import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/screens/DashboardScreen.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userLoginController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  FocusNode firstnameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode userLoginFocus = FocusNode();
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

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      appStore.setLoading(true);

      await signUpApi(
        firstName: firstnameController.text.trim(),
        lastName: lastNameController.text.trim(),
        userLogin: userLoginController.text.trim(),
        userEmail: emailController.text.validate(),
        password: passWordController.text.validate(),
      ).then((value) async {
        appStore.setLoading(false);
        DashboardScreen().launch(context, isNewTask: true);
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: kToolbarHeight, right: 16, left: 16),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(language!.register, style: boldTextStyle(size: 22)),
                  8.height,
                  Text(language!.signUpAccount, style: primaryTextStyle()),
                  32.height,
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    errorThisFieldRequired: language!.fieldRequired,
                    decoration: buildInputDecoration(language!.firstName),
                    controller: firstnameController,
                    focus: firstnameFocus,
                    nextFocus: lastNameFocus,
                  ),
                  32.height,
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    errorThisFieldRequired: language!.fieldRequired,
                    decoration: buildInputDecoration(language!.firstName),
                    controller: lastNameController,
                    focus: lastNameFocus,
                    nextFocus: userLoginFocus,
                  ),
                  32.height,
                  AppTextField(
                    textFieldType: TextFieldType.USERNAME,
                    errorThisFieldRequired: language!.fieldRequired,
                    decoration: buildInputDecoration(language!.userName),
                    controller: userLoginController,
                    focus: userLoginFocus,
                    nextFocus: emailFocus,
                  ),
                  32.height,
                  AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    errorThisFieldRequired: language!.fieldRequired,
                    decoration: buildInputDecoration(language!.email),
                    controller: emailController,
                    focus: emailFocus,
                    nextFocus: passwordFocus,
                  ),
                  32.height,
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    errorThisFieldRequired: language!.fieldRequired,
                    decoration: buildInputDecoration(language!.password),
                    controller: passWordController,
                    focus: passwordFocus,
                  ),
                  32.height,
                  AppButton(
                    width: context.width(),
                    text: language!.accountCreate,
                    textStyle: boldTextStyle(color: Colors.white),
                    onTap: () {
                      submit();
                    },
                  ),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(language!.alreadyAccount, style: primaryTextStyle()),
                      TextButton(
                        onPressed: () {
                          finish(context);
                        },
                        child: Text(language!.signIn, style: boldTextStyle(color: primaryColor)),
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
