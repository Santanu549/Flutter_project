import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/model/addressModel/Countries.dart';
import 'package:pet_shop_flutter/model/addressModel/ShippingModel.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

import '../../../main.dart';

class ShippingWidget extends StatefulWidget {
  final Function(GlobalKey<FormState>)? onTap;
  CountryState? selectedShippingState;
  List<CountryState> shippingStateList;
  List<Country> billingCountryList;
  Country? selectedShippingCountry;

  ShippingWidget({this.onTap, this.selectedShippingState, required this.shippingStateList, required this.billingCountryList, required this.selectedShippingCountry});

  @override
  ShippingWidgetState createState() => ShippingWidgetState();
}

class ShippingWidgetState extends State<ShippingWidget> {
  ShippingModel model = ShippingModel();
  final GlobalKey<FormState> shippingFormKey = GlobalKey<FormState>();

  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController cityCont = TextEditingController();
  TextEditingController pinCodeCont = TextEditingController();
  TextEditingController companyCont = TextEditingController();
  TextEditingController stateCont = TextEditingController();
  TextEditingController countryCont = TextEditingController();
  TextEditingController address1Cont = TextEditingController();
  TextEditingController address2Cont = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode cityFocus = FocusNode();
  FocusNode pinCodeFocus = FocusNode();
  FocusNode companyFocus = FocusNode();
  FocusNode stateFocus = FocusNode();
  FocusNode countryFocus = FocusNode();
  FocusNode address1Focus = FocusNode();
  FocusNode address2Focus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (appStore.shippingAddress != null) {
      firstNameCont = TextEditingController(text: appStore.shippingAddress!.first_name.validate());
      lastNameCont = TextEditingController(text: appStore.shippingAddress!.last_name.validate());
      emailCont = TextEditingController(text: appStore.shippingAddress!.email.validate());
      phoneCont = TextEditingController(text: appStore.shippingAddress!.phone.validate());
      cityCont = TextEditingController(text: appStore.shippingAddress!.city.validate());
      pinCodeCont = TextEditingController(text: appStore.shippingAddress!.postcode.validate());
      companyCont = TextEditingController(text: appStore.shippingAddress!.company.validate());
      stateCont = TextEditingController(text: appStore.shippingAddress!.state.validate());
      countryCont = TextEditingController(text: appStore.shippingAddress!.country.validate());
      address1Cont = TextEditingController(text: appStore.shippingAddress!.address_1.validate());
      address2Cont = TextEditingController(text: appStore.shippingAddress!.address_2.validate());
    }
  }

  @override
  void dispose() {
    firstNameCont.dispose();
    lastNameCont.dispose();
    emailCont.dispose();
    phoneCont.dispose();
    cityCont.dispose();
    pinCodeCont.dispose();
    companyCont.dispose();
    stateCont.dispose();
    countryCont.dispose();
    address1Cont.dispose();
    address2Cont.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 16),
      child: Form(
        key: shippingFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Row(
              children: [
                AppTextField(
                  controller: firstNameCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: buildInputDecoration(language!.firstName),
                  focus: firstNameFocus,
                  nextFocus: lastNameFocus,
                  onChanged: (v) {
                    appStore.shippingModel.first_name = firstNameCont.text.trim();
                    widget.onTap!(shippingFormKey);
                  },
                ).expand(),
                8.width,
                AppTextField(
                  controller: lastNameCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: buildInputDecoration(language!.lastName),
                  focus: lastNameFocus,
                  nextFocus: emailFocus,
                  onChanged: (v) {
                    appStore.shippingModel.last_name = lastNameCont.text.trim();
                    widget.onTap!(shippingFormKey);
                  },
                ).expand(),
              ],
            ),
            16.height,
            AppTextField(
              controller: emailCont,
              textFieldType: TextFieldType.EMAIL,
              decoration: buildInputDecoration(language!.email),
              focus: emailFocus,
              nextFocus: cityFocus,
              onChanged: (v) {
                appStore.shippingModel.email = emailCont.text.trim();
                widget.onTap!(shippingFormKey);
              },
            ),
            16.height,
            Row(
              children: [
                AppTextField(
                  controller: cityCont,
                  textFieldType: TextFieldType.NAME,
                  decoration: buildInputDecoration(language!.city),
                  focus: cityFocus,
                  nextFocus: pinCodeFocus,
                  onChanged: (v) {
                    appStore.shippingModel.city = cityCont.text.trim();
                    widget.onTap!(shippingFormKey);
                  },
                ).expand(),
                8.width,
                AppTextField(
                  controller: pinCodeCont,
                  textFieldType: TextFieldType.PHONE,
                  decoration: buildInputDecoration(language!.pinCode),
                  focus: pinCodeFocus,
                  nextFocus: companyFocus,
                  validator: (v) {
                    //
                  },
                  onChanged: (v) {
                    appStore.shippingModel.postcode = pinCodeCont.text.trim();
                    widget.onTap!(shippingFormKey);
                  },
                ).expand(),
              ],
            ),
            16.height,
            AppTextField(
              controller: companyCont,
              textFieldType: TextFieldType.NAME,
              decoration: buildInputDecoration(language!.company),
              focus: companyFocus,
              nextFocus: phoneFocus,
              onChanged: (v) {
                appStore.shippingModel.company = companyCont.text.trim();
                widget.onTap!(shippingFormKey);
              },
            ),
            16.height,
            AppTextField(
              controller: phoneCont,
              textFieldType: TextFieldType.PHONE,
              decoration: buildInputDecoration(language!.phone),
              focus: phoneFocus,
              nextFocus: stateFocus,
              onChanged: (v) {
                appStore.shippingModel.phone = phoneCont.text.trim();
                widget.onTap!(shippingFormKey);
              },
            ),
            16.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: appStore.isDarkMode ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.4)), borderRadius: BorderRadius.circular(defaultRadius)),
                    child: Theme(
                      data: Theme.of(context).copyWith(canvasColor: context.cardColor),
                      child: DropdownButton(
                        value: widget.selectedShippingCountry,
                        isExpanded: true,
                        underline: SizedBox(),
                        onChanged: (Country? value) {
                          widget.selectedShippingCountry = value;
                          widget.shippingStateList.clear();
                          widget.shippingStateList.addAll(widget.selectedShippingCountry!.states!);
                          widget.selectedShippingState = widget.selectedShippingCountry!.states!.isNotEmpty ? widget.shippingStateList[0] : null;

                          appStore.shippingModel.country = widget.selectedShippingCountry != null ? widget.selectedShippingCountry!.code.toString() : "";
                          widget.onTap!(shippingFormKey);
                          setState(() {});
                        },
                        items: widget.billingCountryList.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                value.name != null && value.name.toString().isNotEmpty ? value.name : "NA",
                                style: primaryTextStyle(),
                              ).paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                16.width,
                Expanded(
                  child: widget.selectedShippingState != null
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: appStore.isDarkMode ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.4)), borderRadius: BorderRadius.circular(defaultRadius)),
                          child: Theme(
                            data: Theme.of(context).copyWith(canvasColor: context.cardColor),
                            child: DropdownButton(
                              value: widget.selectedShippingState,
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (CountryState? value) {
                                setState(() {
                                  widget.selectedShippingState = value;
                                  appStore.shippingModel.state = widget.selectedShippingState != null ? widget.selectedShippingState!.code.toString() : "";
                                  widget.onTap!(shippingFormKey);
                                });
                              },
                              items: widget.shippingStateList.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      value.name != null && value.name.toString().isNotEmpty ? value.name : "",
                                      textAlign: TextAlign.center,
                                      style: primaryTextStyle(),
                                    ).paddingOnly(left: 16, right: 16, top: 8, bottom: 8),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      : Text(
                          "NA",
                          style: primaryTextStyle(),
                        ).paddingOnly(top: 12, bottom: 12).center(),
                ),
              ],
            ).visible(widget.billingCountryList.isNotEmpty),
            16.height,
            AppTextField(
              controller: address1Cont,
              textFieldType: TextFieldType.NAME,
              decoration: buildInputDecoration(language!.address1),
              focus: address1Focus,
              nextFocus: address2Focus,
              onChanged: (v) {
                appStore.shippingModel.address_1 = address1Cont.text.trim();
                widget.onTap!(shippingFormKey);
              },
            ),
            16.height,
            AppTextField(
              controller: address2Cont,
              textFieldType: TextFieldType.NAME,
              decoration: buildInputDecoration(language!.address2),
              focus: address2Focus,
              onChanged: (v) {
                appStore.shippingModel.address_2 = address2Cont.text.trim();
                widget.onTap!(shippingFormKey);
              },
            ),
            16.height,
            /* 16.height,
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
                title: Text('Same As Shipping Address'),
              ),
            ),*/
          ],
        ).paddingOnly(left: 8, right: 8),
      ),
    );
  }
}
