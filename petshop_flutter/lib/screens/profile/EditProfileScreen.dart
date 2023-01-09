import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/addressModel/Countries.dart';
import 'package:pet_shop_flutter/model/addressModel/ShippingModel.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/screens/profile/components/BillingWidget.dart';
import 'package:pet_shop_flutter/screens/profile/components/ShippingWidget.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> with TickerProviderStateMixin {
  GlobalKey<FormState> _billingFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _shippingFormKey = GlobalKey<FormState>();
  late TabController controller;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailNameController = TextEditingController(text: appStore.userEmail);

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  XFile? image;

  bool mIsExpandedBilling = false;
  bool mIsExpandedShipping = false;
  bool mIsCheck = false;

  List<Country> billingCountryList = [];
  List<CountryState> billingStateList = [];
  List<CountryState> shippingStateList = [];

  Country? selectedBillingCountry;
  CountryState? selectedBillingState;
  Country? selectedShippingCountry;
  CountryState? selectedShippingState;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    controller = TabController(length: 2, vsync: this);

    firstName.text = appStore.firstName;
    lastName.text = appStore.lastName;

    getCustomerData();
  }

  Widget profileImage() {
    if (image != null) {
      return Image.file(File(image!.path), height: 100, width: 100, fit: BoxFit.cover, alignment: Alignment.center).cornerRadiusWithClipRRect(50).center();
    } else {
      return commonCacheImage(appStore.userImage.validate(), fit: BoxFit.cover, height: 100, width: 100).cornerRadiusWithClipRRect(50).center();
    }
  }

  Future<XFile?> getImg() async {
    return ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 100);
  }

  void shippingAddress() async {
    if (appStore.billingAddress != null && appStore.shippingAddress != null) {
      Map req = {
        'email': emailNameController.text.trim(),
        'first_name': firstName.text.trim(),
        'last_name': lastName.text.trim(),
        'billing': appStore.billingAddress!.toJson(),
        'shipping': appStore.shippingModel.toJson(),
      };
      appStore.setLoading(true);

      await updateCustomer(req: req, id: appStore.userId).then((value) async {
        snack(language!.saveSuccessfully);
        appStore.setLoading(false);

        await appStore.setFirstName(value.first_name.validate());
        await appStore.setLastName(value.last_name.validate());

        if (value.shipping != null) await appStore.setShippingAddress(value.shipping!);
        if (value.billing != null) await appStore.setBillingAddress(value.billing!);

        finish(context);
      }).catchError((e) {
        appStore.setLoading(false);
        snack(e.toString());
      });
    } else {
      snack('Please enter data');
    }
    appStore.isAddressSame = false;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  setCountryStateData(List<dynamic> value) {
    var txtBillingCountry = appStore.billingAddress!.country;
    var txtBillingState = appStore.billingAddress!.state;
    var txtShippingCountry = appStore.shippingAddress!.country;
    var txtShippingState = appStore.shippingAddress!.state;

    Iterable list = value;
    var countries = list.map((model) => Country.fromJson(model)).toList();
    setState(() {
      appStore.setLoading(false);
      billingCountryList.addAll(countries);
      if (billingCountryList.isNotEmpty) {
        selectedBillingCountry = billingCountryList[0];
        selectedShippingCountry = billingCountryList[0];
        if (txtBillingCountry != null || txtShippingCountry != null) {
          billingCountryList.forEach((element) {
            if (txtBillingCountry != null && txtBillingCountry.toString().isNotEmpty && element.code == txtBillingCountry) {
              selectedBillingCountry = element;
            }
            if (txtShippingCountry != null && txtShippingCountry.toString().isNotEmpty && element.code == txtShippingCountry) {
              selectedShippingCountry = element;
            }
          });
        }
        billingStateList.clear();
        shippingStateList.clear();
        billingStateList.addAll(selectedBillingCountry!.states!);
        shippingStateList.addAll(selectedShippingCountry!.states!);
        selectedBillingState = billingStateList.isNotEmpty ? billingStateList[0] : null;
        selectedShippingState = shippingStateList.isNotEmpty ? shippingStateList[0] : null;

        if (txtBillingState != null) {
          billingStateList.forEach((element) {
            if (txtBillingState != null && txtBillingState.toString().isNotEmpty && element.code == txtBillingState) {
              selectedBillingState = element;
            }
          });
        }

        if (txtShippingState != null) {
          shippingStateList.forEach((element) {
            if (txtShippingState != null && txtShippingState.toString().isNotEmpty && element.code == txtShippingState) {
              selectedShippingState = element;
            }
          });
        }
      }
    });
  }

  Future getCustomerData() async {
    afterBuildCreated(() {
      appStore.setLoading(true);
    });
    await getCountries().then((value) async {
      setCountryStateData(value);
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => AppScaffold(
        appBar: appBarWidget(language!.editProfile, color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 70, left: 16, right: 16, top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      profileImage(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 50, left: 80),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: primaryColor),
                          child: IconButton(
                            onPressed: () async {
                              image = await getImg();
                              if (image != null) {
                                showConfirmDialog(context, language!.confirmImage, onAccept: () {
                                  updateProfileImage(file: File(image!.path.validate())).then((value) {
                                    snack(language!.saveSuccessfully);
                                  });
                                });
                              }
                            },
                            icon: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  16.height,
                  AppTextField(
                    controller: firstName,
                    textFieldType: TextFieldType.NAME,
                    decoration: buildInputDecoration(language!.firstName),
                  ),
                  16.height,
                  AppTextField(
                    controller: lastName,
                    textFieldType: TextFieldType.NAME,
                    decoration: buildInputDecoration(language!.lastName),
                  ),
                  16.height,
                  AppTextField(
                    controller: emailNameController,
                    textFieldType: TextFieldType.EMAIL,
                    readOnly: true,
                    decoration: buildInputDecoration(language!.email),
                  ),
                  16.height,
                  SizedBox(
                    height: 700,
                    width: context.width(),
                    child: Column(
                      children: [
                        TabBar(
                          indicatorColor: primaryColor,
                          controller: controller,
                          padding: EdgeInsets.only(bottom: 8),
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: [
                            Text(language!.shippingAddress, style: boldTextStyle()),
                            Text(language!.billingAddress, style: boldTextStyle()),
                          ],
                        ),
                        TabBarView(
                          controller: controller,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            ShippingWidget(
                              selectedShippingState: selectedShippingState,
                              shippingStateList: shippingStateList,
                              billingCountryList: billingCountryList,
                              selectedShippingCountry: selectedShippingCountry,
                              onTap: (shipping) {
                                _shippingFormKey = shipping;
                              },
                            ),
                            BillingWidget(
                              billingCountryList: billingCountryList,
                              billingStateList: billingStateList,
                              selectedBillingCountry: selectedBillingCountry,
                              selectedBillingState: selectedBillingState,
                              onTap: (val, billingKey) {
                                _billingFormKey = billingKey;
                              },
                            ),
                          ],
                        ).expand(),
                        Observer(
                          builder: (_) => CheckboxListTile(
                            value: appStore.isAddressSame,
                            onChanged: (v) {
                              appStore.setAddress(v.validate());
                              if (v.validate()) {
                                appStore.setBillingAddress(appStore.shippingModel);
                                LiveStream().emit(StreamBillingAddressChanged, true);
                              } else {
                                appStore.setBillingAddress(ShippingModel());
                                LiveStream().emit(StreamBillingAddressChanged, false);
                              }
                            },
                            title: Text(language!.sameAsShippingAddress, style: primaryTextStyle()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Observer(builder: (_) => Loader().visible(appStore.isLoading))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save, color: white),
          onPressed: () {
            hideKeyboard(context);
            shippingAddress();
          },
        ),
      ),
    );
  }
}
