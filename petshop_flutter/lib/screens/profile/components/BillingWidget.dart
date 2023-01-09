import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/model/addressModel/Countries.dart';
import 'package:pet_shop_flutter/model/addressModel/ShippingModel.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

import '../../../main.dart';

class BillingWidget extends StatefulWidget {
  final Function(ShippingModel, GlobalKey<FormState>)? onTap;
  final bool? mIsUpdate;
  CountryState? selectedBillingState;
  List<CountryState> billingStateList;
  List<Country> billingCountryList;
  Country? selectedBillingCountry;

  BillingWidget({this.onTap, this.mIsUpdate, this.selectedBillingState, required this.billingStateList, required this.billingCountryList, required this.selectedBillingCountry});

  @override
  BillingWidgetState createState() => BillingWidgetState();
}

class BillingWidgetState extends State<BillingWidget> {
  final GlobalKey<FormState> billingFormKey = GlobalKey<FormState>();

  bool mIsUpdate = false;
  ShippingModel model = ShippingModel();

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
    LiveStream().on(StreamBillingAddressChanged, (val) {
      if (val as bool) {
        firstNameCont.text = appStore.shippingModel.first_name.validate();
        lastNameCont.text = appStore.shippingModel.last_name.validate();
        emailCont.text = appStore.shippingModel.email.validate();
        phoneCont.text = appStore.shippingModel.phone.validate();
        cityCont.text = appStore.shippingModel.city.validate();
        pinCodeCont.text = appStore.shippingModel.postcode.validate();
        companyCont.text = appStore.shippingModel.company.validate();
        stateCont.text = appStore.shippingModel.state.validate();
        countryCont.text = appStore.shippingModel.country.validate();
        address1Cont.text = appStore.shippingModel.address_1.validate();
        address2Cont.text = appStore.shippingModel.address_2.validate();
      } else {
        firstNameCont.text = '';
        lastNameCont.text = '';
        emailCont.text = '';
        phoneCont.text = '';
        cityCont.text = '';
        pinCodeCont.text = '';
        companyCont.text = '';
        stateCont.text = '';
        countryCont.text = '';
        address1Cont.text = '';
        address2Cont.text = '';
      }

      //setState(() { });
    });
    if (appStore.billingAddress != null) {
      firstNameCont = TextEditingController(text: appStore.shippingAddress!.first_name.validate());
      lastNameCont = TextEditingController(text: appStore.shippingAddress!.last_name.validate());
      emailCont = TextEditingController(text: appStore.shippingAddress!.email.validate(value: appStore.userEmail));
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
    LiveStream().dispose(StreamBillingAddressChanged);
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
        key: billingFormKey,
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
                    model.first_name = firstNameCont.text.trim();

                    widget.onTap!(model, billingFormKey);
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
                    model.first_name = lastNameCont.text.trim();

                    widget.onTap!(model, billingFormKey);
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
                model.email = emailCont.text.trim();

                widget.onTap!(model, billingFormKey);
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
                    model.city = cityCont.text.trim();

                    widget.onTap!(model, billingFormKey);
                  },
                ).expand(),
                8.width,
                AppTextField(
                  controller: pinCodeCont,
                  textFieldType: TextFieldType.PHONE,
                  decoration: buildInputDecoration(language!.pinCode),
                  focus: pinCodeFocus,
                  nextFocus: companyFocus,
                  onChanged: (v) {
                    model.postcode = pinCodeCont.text.trim();

                    widget.onTap!(model, billingFormKey);
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
                model.company = companyCont.text.trim();

                widget.onTap!(model, billingFormKey);
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
                model.city = cityCont.text.trim();

                widget.onTap!(model, billingFormKey);
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
                        value: widget.selectedBillingCountry,
                        isExpanded: true,
                        underline: SizedBox(),
                        onChanged: (Country? value) {
                          setState(() {
                            log(" Country:$value");
                            widget.selectedBillingCountry = value;
                            widget.billingStateList.clear();
                            widget.billingStateList.addAll(widget.selectedBillingCountry!.states!);
                            widget.selectedBillingState = widget.selectedBillingCountry!.states!.isNotEmpty ? widget.billingStateList[0] : null;

                            model.country = widget.selectedBillingCountry != null ? widget.selectedBillingCountry!.code.toString() : "";

                            widget.onTap!(model, billingFormKey);
                          });
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
                  child: widget.selectedBillingState != null
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: appStore.isDarkMode ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.4)), borderRadius: BorderRadius.circular(defaultRadius)),
                          child: Theme(
                            data: Theme.of(context).copyWith(canvasColor: context.cardColor),
                            child: DropdownButton(
                              value: widget.selectedBillingState,
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (CountryState? value) {
                                setState(() {
                                  widget.selectedBillingState = value;
                                  model.state = widget.selectedBillingState != null ? widget.selectedBillingState!.code.toString() : "";
                                  widget.onTap!(model, billingFormKey);
                                });
                              },
                              items: widget.billingStateList.map((value) {
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
                model.address_1 = address1Cont.text.trim();

                widget.onTap!(model, billingFormKey);
              },
            ),
            16.height,
            AppTextField(
              controller: address2Cont,
              textFieldType: TextFieldType.NAME,
              decoration: buildInputDecoration(language!.address2),
              focus: address2Focus,
              onChanged: (v) {
                model.address_2 = address2Cont.text.trim();

                widget.onTap!(model, billingFormKey);
              },
            ),
            8.height,
          ],
        ).paddingOnly(left: 8, right: 8),
      ),
    );
  }
}
