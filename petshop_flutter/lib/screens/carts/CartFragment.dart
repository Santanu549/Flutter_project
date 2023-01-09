import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppBarWidget.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/screens/CheckOutSummaryScreen.dart';
import 'package:pet_shop_flutter/screens/auth/SignInScreen.dart';
import 'package:pet_shop_flutter/screens/carts/components/CartItemWidget.dart';
import 'package:pet_shop_flutter/screens/carts/components/ViewDetailBottomSheet.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';
import 'package:pet_shop_flutter/utils/AppImages.dart';

class CartFragment extends StatefulWidget {
  final bool mIsBack;

  CartFragment({this.mIsBack = false});

  @override
  CartFragmentState createState() => CartFragmentState();
}

class CartFragmentState extends State<CartFragment> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    LiveStream().on(streamRefresh, (v) {
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return SafeArea(
          child: AppScaffold(
            body: Stack(
              children: [
                cartStore.cartList.isNotEmpty
                    ? SizedBox(
                        width: context.width(),
                        height: context.height(),
                        child: ListView.builder(
                          padding: EdgeInsets.only(left: 8, top: 60, right: 8, bottom: 150),
                          controller: _scrollController,
                          itemCount: cartStore.cartList.length,
                          shrinkWrap: true,
                          itemBuilder: (_, index) => CartItemWidget(cartData: cartStore.cartList[index]),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          commonCacheImage(emptyCart, width: 150, height: 120),
                          Text(
                            emptyCartText,
                            style: secondaryTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ).center(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(top: 8),
                    decoration: boxDecorationDefault(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius), color: context.cardColor),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppButton(
                                  child: Icon(Icons.keyboard_arrow_up_rounded, color: appButtonColorDark),
                                  width: 40,
                                  textStyle: boldTextStyle(),
                                  onTap: () {
                                    if (cartStore.cartList.isNotEmpty) {
                                      showModalBottomSheet(context: context, builder: (_) => CartAmountDetailSheet());
                                    }
                                  },
                                ),
                                16.width,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('\$ ${cartStore.cartTotalPayableAmount}', style: boldTextStyle(size: 22)),
                                    Text(language!.totalAmount, style: boldTextStyle()),
                                  ],
                                ),
                              ],
                            ).flexible(),
                            AppButton(
                              child: Text(language!.checkout, style: boldTextStyle(color: appButtonColorDark)),
                              textStyle: boldTextStyle(),
                              onTap: () {
                                if (appStore.isLoggedIn) {
                                  if (appStore.billingAddress!.first_name!.isNotEmpty) {
                                    CheckOutSummaryScreen().launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                                  } else {
                                    toast("Please Add Address");
                                  }
                                } else {
                                  SignInScreen().launch(context);
                                }
                              },
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 16, vertical: 8),
                      ],
                    ),
                  ),
                ).visible(cartStore.cartList.isNotEmpty),
                AppBarWidget(
                  title: Row(
                    children: [
                      if (widget.mIsBack)
                        Icon(Icons.arrow_back_rounded).onTap(() {
                          finish(context);
                        }, splashColor: Colors.transparent, highlightColor: Colors.transparent),
                      16.width.visible(widget.mIsBack),
                      headingTextWidget(language!.cart),
                    ],
                  ),
                  scrollController: _scrollController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
