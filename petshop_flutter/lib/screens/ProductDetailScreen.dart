import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/components/ProductDetailWidget.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/cart/CartModel.dart';
import 'package:pet_shop_flutter/model/product/ProductDetailModel.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/screens/carts/CartFragment.dart';
import 'package:pet_shop_flutter/screens/productByCategory/components/PriceWidget.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class ProductDetailScreen extends StatefulWidget {
  final int? productID;

  ProductDetailScreen({this.productID});

  @override
  ProductDetailScreenState createState() => ProductDetailScreenState();
}

class ProductDetailScreenState extends State<ProductDetailScreen> with TickerProviderStateMixin {
  ProductDetailModel? product;
  List<ProductDetailModel> productVariants = [];
  PageController controller = PageController();

  bool mIsLike = false;
  bool mIsAddToCart = false;
  bool mIsReadMore = false;

  int selectColor = 1;

  @override
  void initState() {
    super.initState();
    init();
    afterBuildCreated(() {
      appStore.setLoading(true);
    });
  }

  void init() async {
    setStatusBarColor(Colors.transparent, statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark);
    await getProductDetail(productId: widget.productID).then((value) {
      if (value.validate().isNotEmpty) {
        productVariants = value;
        product = value.first;

        setState(() {});
      }
    }).catchError((e) {
      toast(e.toString());
    });
    appStore.setLoading(false);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(appStore.isDarkMode ? Colors.black : Colors.white);
    super.dispose();
  }

  void addToCart(ProductDetailModel data) {
    CartData cart = CartData();

    cart.thumbnail = data.images!.first.src.validate();
    cart.name = data.name;
    cart.pro_id = data.id;
    cart.ps_product_type = data.ps_product_type;
    cart.regular_price = data.regular_price;
    cart.sale_price = data.sale_price;
    cart.price = data.price;
    cart.description = data.description;
    cart.stock_status = data.in_stock! ? "instock" : "";
    cart.gallery = data.images!.map((e) => e.src!).toList();
    cart.quantity = '1';

    cartStore.addToCart(cart);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        children: [
          if (product != null)
            SingleChildScrollView(
              padding: EdgeInsets.only(top: kToolbarHeight, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.height() * 0.5,
                    width: context.width(),
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: controller,
                          itemCount: product!.images.validate().length,
                          itemBuilder: (_, index) {
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(boxShadow: defaultBoxShadow()),
                                  child: commonCacheImage(product!.images![index].src.validate(), fit: BoxFit.cover, height: 400, width: context.width()),
                                ),
                              ],
                            );
                          },
                        ),
                        Positioned(
                          right: 8,
                          left: 8,
                          bottom: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              product!.images.validate().length > 1
                                  ? Container(
                                      decoration: indicatorDecoration(),
                                      padding: EdgeInsets.symmetric(horizontal: 4),
                                      child: DotIndicator(
                                        pageController: controller,
                                        pages: product!.images.validate(),
                                        indicatorColor: primaryColor,
                                        currentDotSize: 10,
                                        dotSize: 6,
                                      ),
                                    )
                                  : SizedBox(),
                              Container(
                                margin: EdgeInsets.all(4),
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: indicatorDecoration(),
                                child: Text(product!.in_stock.validate() == true ? language!.available : language!.outOfStock, style: boldTextStyle(color: Colors.green, size: 12)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(top: context.statusBarHeight),
                  8.height,
                  Container(
                    padding: EdgeInsets.all(8),
                    width: context.width(),
                    color: context.cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(product!.name.validate(), style: boldTextStyle(size: 20), maxLines: 2, overflow: TextOverflow.ellipsis).flexible(),
                            if (product!.on_sale.validate())
                              Container(
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                margin: EdgeInsets.only(left: 8),
                                child: Text(language!.sale, style: boldTextStyle(color: white, size: 12)),
                              ),
                          ],
                        ),
                        8.height,
                        Row(
                          children: [
                            PriceWidget(salePrice: product!.sale_price, regularPrice: product!.regular_price),
                            8.width,
                            if (product!.sale_price!.isNotEmpty)
                              Container(
                                padding: EdgeInsets.only(left: 4, top: 4, right: 4, bottom: 2),
                                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(defaultRadius)),
                                child: Text(discountText(product!.regular_price.validate(), product!.sale_price.validate()), style: primaryTextStyle(color: Colors.white, size: 12)),
                              ),
                          ],
                        ),
                        8.height,
                        Text(parseHtmlString(product!.short_description.validate()), style: primaryTextStyle()).visible(product!.short_description.validate().isNotEmpty),
                      ],
                    ),
                  ),
                  if (productVariants.length != 1)
                    HorizontalList(
                      itemCount: productVariants.length,
                      itemBuilder: (_, index) {
                        ProductDetailModel variant = productVariants[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            variant.images.validate().isNotEmpty
                                ? Container(
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border: variant.id == product!.id ? Border.all(color: context.primaryColor, width: 1) : null,
                                    ),
                                    child: commonCacheImage(variant.images!.first.src.validate(), fit: BoxFit.cover),
                                  )
                                : Container(color: Colors.grey.shade100, height: 40, width: 40),
                            Container(
                              width: 60,
                              margin: EdgeInsets.only(top: 4),
                              child: Text(variant.name.validate(), style: primaryTextStyle(size: 10), overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ).onTap(() {
                          product = variant;
                          setState(() {});
                        }, highlightColor: context.cardColor, splashColor: context.cardColor);
                      },
                    ),
                  Divider(color: Colors.grey.withOpacity(0.7)),
                  2.height,
                  Observer(
                    builder: (_) => Row(
                      children: [
                        AppButton(
                          padding: EdgeInsets.all(12),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(wishListStore.isItemInWishlist(product!.id!) ? Icons.favorite : Icons.favorite_border, color: primaryColor),
                              4.width,
                              Text(language!.wishList.toUpperCase(), style: boldTextStyle(color: primaryColor)),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          textStyle: boldTextStyle(color: primaryColor),
                          onTap: () async {
                            addItemToWishlist(product!);
                          },
                        ).expand(),
                        AppButton(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart_outlined, color: appButtonColorDark),
                              4.width,
                              Text(cartStore.isItemInCart(widget.productID.validate()) ? language!.goToCart.toUpperCase() : language!.addTOCart.toUpperCase(),
                                  style: boldTextStyle(color: appButtonColorDark)),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          onTap: () async {
                            setStatusBarColor(appStore.isDarkMode ? Colors.black : Colors.white);
                            if (cartStore.isItemInCart(widget.productID.validate())) {
                              await CartFragment(mIsBack: true).launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
                              setStatusBarColor(Colors.transparent, statusBarIconBrightness: appStore.isDarkMode ? Brightness.light : Brightness.dark);
                            } else {
                              addToCart(product!);
                            }
                          },
                        ).expand(),
                      ],
                    ),
                  ),
                  4.height,
                  if (product!.description.validate().isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(parseHtmlString(product!.description.validate()), style: primaryTextStyle(), maxLines: !mIsReadMore ? 2 : null),
                        TextButton(
                          onPressed: () {
                            mIsReadMore = !mIsReadMore;
                            setState(() {});
                          },
                          child: Text(mIsReadMore ? language!.readLess : language!.readMore),
                        ),
                      ],
                    ).paddingOnly(left: 8, right: 8),
                  Divider(color: Colors.grey.withOpacity(0.7)),
                  16.height,
                  if (product!.upsell_id != null) ProductDetailWidget(upSellData: product!.upsell_id)
                ],
              ),
            ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: context.width(),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: context.statusBarHeight),
                padding: EdgeInsets.symmetric(vertical: 8),
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: appStore.isDarkMode ? Colors.black12 : Colors.white12, blurRadius: 5, spreadRadius: 3),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: (() {
                    finish(context);
                  }),
                ),
              ),
            ),
          ),
          Observer(builder: (_) => Loader().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
