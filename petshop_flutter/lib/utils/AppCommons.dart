import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/model/product/ProductDetailModel.dart';
import 'package:pet_shop_flutter/model/wishlist/WishListModel.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';
import 'package:pet_shop_flutter/utils/AppImages.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

Widget placeholderWidget() => Image.asset(petLogo, color: primaryColor.withOpacity(0.5));

Widget Function(BuildContext, String) placeholderWidgetFn() => (_, s) => placeholderWidget();

Widget commonCacheImage(String? url, {double? width, BoxFit? fit, double? height, Color? color}) {
  if (url!.validate().isEmpty) {
    return Image.asset(loadImage, height: height, width: width, fit: fit);
  }
  if (url.validate().startsWith('http')) {
    if (isMobile || isWeb) {
      return CachedNetworkImage(
        placeholder: placeholderWidgetFn(),
        imageUrl: '$url',
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    } else {
      return Image.network(url, height: height, width: width, fit: fit);
    }
  } else {
    return Image.asset(url, height: height, width: width, fit: fit);
  }
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

List<Color> suggestionCardColorList = [
  Color(0xFFCD5D7D),
  Color(0xFF6155A6),
  Color(0xFF557571),
  Color(0xFF383E56),
  Color(0xFF75B79E),
  Color(0xFF32AFA9),
];

Widget sectionHeadingText({String title = '', double fontSize = 32}) {
  return Column(
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          commonCacheImage(petRight, width: 20, height: 20),
          4.width,
          Text(
            title,
            style: primaryTextStyle(
              size: fontSize.toInt(),
              fontFamily: GoogleFonts.jost().fontFamily,
            ),
          ),
          4.width,
          commonCacheImage(petLeft, width: 20, height: 20),
        ],
      ),
    ],
  ).paddingOnly(left: 8, top: 8, right: 8, bottom: 8);
}

Widget headingTextWidget(String title, {String? subTitle, int titleTextSize = 20}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(title, style: boldTextStyle(size: titleTextSize)),
      if (subTitle.validate().isNotEmpty) Text(subTitle.validate(), style: secondaryTextStyle(size: 12)),
    ],
  );
}

Widget orderData({String? title, String? subtitle, Color? color}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title!, style: primaryTextStyle(size: 20)),
      Text(subtitle!, style: primaryTextStyle(color: color, size: 20)),
    ],
  ).paddingSymmetric(vertical: 4, horizontal: 16);
}

InputDecoration buildInputDecoration(String name) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 16, top: 16, right: 8),
    labelText: name,
    labelStyle: primaryTextStyle(color: grey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: appStore.isDarkMode ? Colors.white : black, width: 0.5)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: appStore.isDarkMode ? Colors.white : black, width: 0.5)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(color: appStore.isDarkMode ? Colors.white : black, width: 0.5)),
  );
}

Color getColor(String? colors) {
  if (colors == 'Black') {
    return Colors.black;
  } else if (colors == 'Blue') {
    return Colors.blue;
  } else if (colors == 'Green') {
    return Colors.green;
  } else {
    return Colors.black;
  }
}

String discountText(String regularPrice, String salePrice) {
  return '${(((regularPrice.toInt() - salePrice.toInt()) * 100) ~/ regularPrice.toInt()).toInt()}% off';
}

BoxDecoration indicatorDecoration() {
  return BoxDecoration(
    color: Colors.white.withOpacity(0.5),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.grey.shade300),
  );
}

Widget appSettingData({double? width, String? title, String? subTitle, IconData? icon, VoidCallback? onTap, BuildContext? context}) {
  return Container(
    height: 106,
    padding: EdgeInsets.all(16),
    width: width,
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.4)), borderRadius: BorderRadius.circular(defaultRadius)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title.validate(), style: boldTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis).expand(),
            Icon(icon),
          ],
        ),
        subTitle != null ? 8.height : SizedBox(),
        subTitle != null ? Text(subTitle.validate(), style: secondaryTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis) : SizedBox()
      ],
    ),
  ).onTap(() {
    onTap!.call();
  }, borderRadius: BorderRadius.circular(defaultRadius), highlightColor: primaryColor.withOpacity(0.3));
}

void addItemToWishlist(ProductDetailModel data) {
  WishListModel wishlist = WishListModel();

  wishlist.thumbnail = data.images!.first.src.validate();
  wishlist.name = data.name;
  wishlist.pro_id = data.id;
  wishlist.regular_price = data.regular_price;
  wishlist.sale_price = data.sale_price;
  wishlist.price = data.price;
  wishlist.gallery = data.images!.map((e) => e.src!).toList();
  wishlist.ps_product_type = data.ps_product_type;

  wishListStore.addToWishList(wishlist);
}

void snack(String text) {
  snackBar(
    getContext,
    behavior: SnackBarBehavior.floating,
    title: text,
    margin: EdgeInsets.all(4),
    backgroundColor: primaryColor,
    duration: Duration(milliseconds: 700),
    textColor: Colors.white,
  );
}

Future<void> launchUrl(String url, {bool forceWebView = false}) async {
  await launch(url, forceWebView: forceWebView, enableJavaScript: true).catchError((e) {
    log(e);
    toast('Invalid URL: $url');
  });
}

String storeBaseURL() => isAndroid ? playStoreBaseURL : appStoreBaseUrl;

String convertDate(date) {
  try {
    return date != null ? DateFormat(orderDateFormat).format(DateTime.parse(date)) : '';
  } catch (e) {
    log(e);
    return '';
  }
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'assets/flag/ic_us.png'),
    LanguageDataModel(id: 2, name: 'Hindi', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: 'assets/flag/ic_india.png'),
    LanguageDataModel(id: 3, name: 'Arabic', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: 'assets/flag/ic_ar.png'),
  ];
}
