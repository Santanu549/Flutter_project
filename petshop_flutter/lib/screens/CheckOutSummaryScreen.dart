import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/model/addressModel/ShippingModel.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/screens/profile/EditProfileScreen.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';
import 'package:pet_shop_flutter/utils/AppImages.dart';
import 'package:pet_shop_flutter/utils/PaymentUtils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../main.dart';
import 'DashboardScreen.dart';

enum PaymentMethod { Paystack, Razorpay, COD }

class CheckOutSummaryScreen extends StatefulWidget {
  @override
  CheckOutSummaryScreenState createState() => CheckOutSummaryScreenState();
}

class CheckOutSummaryScreenState extends State<CheckOutSummaryScreen> {
  PaymentMethod? _paymentMethod = PaymentMethod.Paystack;
  late Razorpay _razorPay;
  final plugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
    plugin.initialize(publicKey: paystackPublicKey);

    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId!);
    createNativeOrder(context, "RazorPay");
    clearCartItems().then((response) {
      DashboardScreen().launch(context, isNewTask: true);
    }).catchError((error) {
      toast(error.toString());
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "ERROR: " + response.code.toString() + " - " + response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName!);
  }

  void razorPayCheckout() async {
    var mAmount = double.parse(cartStore.cartTotalPayableAmount.toString()) * 100.00;
    var options = {
      'key': razorKey,
      'amount': mAmount,
      'name': appName,
      'theme.color': razorPayColor,
      'description': razorPayDescription,
      'image': 'https://razorpay.com/assets/razorpay-glyph.svg',
      'prefill': {'contact': appStore.billingAddress!.phone, 'email': appStore.billingAddress!.email},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorPay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorPay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: appBarWidget(language!.checkoutSummary, color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white),
      body: Stack(
        children: [
          Container(
            width: context.width(),
            height: context.height(),
            color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.grey.shade200,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  addressWidget(
                    title: language!.billingAddress,
                    address: appStore.billingAddress!,
                  ),
                  addressWidget(
                    title: language!.shippingAddress,
                    address: appStore.shippingAddress!,
                  ),
                  Container(
                    width: context.width(),
                    decoration: BoxDecoration(
                      color: context.cardColor,
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(language!.orderDetail, style: boldTextStyle(size: 20)).paddingAll(16),
                        Divider(height: 0),
                        8.height,
                        orderData(title: language!.totalAmount, subtitle: '\$ ${cartStore.cartTotalAmount}'),
                        orderData(title: language!.youSaved, subtitle: '- \$ ${cartStore.cartSavedAmount}', color: Colors.red),
                        Divider(indent: context.width() * 0.6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(language!.payableAmount, style: boldTextStyle(size: 24)),
                            Text('\$ ${cartStore.cartTotalPayableAmount}', style: boldTextStyle(size: 26)),
                          ],
                        ).paddingAll(16),
                      ],
                    ),
                  ).paddingSymmetric(vertical: 4),
                  Container(
                    decoration: BoxDecoration(color: context.cardColor, borderRadius: BorderRadius.circular(defaultRadius)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(language!.paymentMethod, style: boldTextStyle(size: 20)).paddingAll(16),
                        Divider(height: 0),
                        Row(
                          children: [
                            Radio<PaymentMethod>(
                              value: PaymentMethod.Paystack,
                              groupValue: _paymentMethod,
                              onChanged: (PaymentMethod? value) {
                                setState(() {
                                  _paymentMethod = value;
                                });
                              },
                            ),
                            commonCacheImage(payStackLogo, height: 30, width: 30),
                            8.width,
                            Text(language!.payStack, style: boldTextStyle()),
                          ],
                        ).visible(enablePayStack == true),
                        Row(
                          children: [
                            Radio<PaymentMethod>(
                              value: PaymentMethod.Razorpay,
                              groupValue: _paymentMethod,
                              onChanged: (PaymentMethod? value) {
                                setState(() {
                                  _paymentMethod = value;
                                });
                              },
                            ),
                            commonCacheImage(razorpayLogo, height: 30, width: 30),
                            8.width,
                            Text(language!.razorPay, style: boldTextStyle()),
                          ],
                        ).visible(enableRazorPay == true),
                        Row(
                          children: [
                            Radio<PaymentMethod>(
                              value: PaymentMethod.COD,
                              groupValue: _paymentMethod,
                              onChanged: (PaymentMethod? value) {
                                setState(() {
                                  _paymentMethod = value;
                                });
                              },
                            ),
                            Text(language!.cashOnDelivery, style: boldTextStyle()),
                          ],
                        ).visible(enableCOD == true),
                      ],
                    ),
                  ).paddingSymmetric(vertical: 4),
                  AppButton(
                    width: context.width(),
                    child: Text(language!.cashOnDelivery, style: boldTextStyle(color: Colors.white)),
                    onTap: () {
                      //
                      if (_paymentMethod == PaymentMethod.Paystack)
                        payStackPayment(context, plugin);
                      else if (_paymentMethod == PaymentMethod.Razorpay)
                        razorPayCheckout();
                      else
                        createNativeOrder(context, "Cash On Delivery");
                    },
                  ).paddingOnly(top: 4, bottom: 16),
                ],
              ),
            ),
          ),
          Observer(builder: (_) => Loader().visible(appStore.isLoading)),
        ],
      ),
    );
  }

  Widget addressWidget({String? title, ShippingModel? address}) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: address != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title.validate(value: ''), style: boldTextStyle(size: 18)),
                Divider(),
                Text(address.address_1.validate(), style: primaryTextStyle()),
                4.height,
                Row(
                  children: [
                    Text(address.city.validate(), style: primaryTextStyle()),
                    Text('-', style: primaryTextStyle()),
                    Text(address.postcode.validate(), style: primaryTextStyle()),
                  ],
                ),
              ],
            )
          : AppButton(
              width: context.width(),
              child: Text('${language!.add} $title', style: boldTextStyle(color: Colors.white)),
              onTap: () {
                EditProfileScreen().launch(context);
              },
            ).paddingSymmetric(vertical: 4),
    );
  }
}
