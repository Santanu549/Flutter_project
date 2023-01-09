import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/dashboard/CategoryModel.dart';
import 'package:pet_shop_flutter/screens/productByCategory/ProductListByCategoryScreen.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

class TopBarWidget extends StatefulWidget {
  static String tag = '/TopBarWidget';
  final List<CategoryModel>? catResList;

  TopBarWidget({this.catResList});

  @override
  TopBarWidgetState createState() => TopBarWidgetState();
}

class TopBarWidgetState extends State<TopBarWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        color: context.cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (appStore.userImage.validate().isNotEmpty) commonCacheImage(appStore.userImage.validate(), height: 35, width: 35, fit: BoxFit.cover).cornerRadiusWithClipRRect(60),
                RichTextWidget(
                  list: [
                    TextSpan(text: '${language!.hello}, ', style: primaryTextStyle()),
                    TextSpan(text: appStore.isLoggedIn ? appStore.firstName.validate() : language!.guestUser, style: boldTextStyle()),
                  ],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).paddingOnly(left: 8, right: 8).expand(),
              ],
            ).paddingOnly(left: 16, top: 8, right: 8),
            HorizontalList(
              itemCount: widget.catResList!.length,
              itemBuilder: (context, index) {
                CategoryModel cat = widget.catResList![index];
                return FutureBuilder<Color>(
                    future: getImagePalette(NetworkImage(cat.image.validate())),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: snap.data!.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                          child: Column(
                            children: [
                              commonCacheImage(
                                cat.image.validate(),
                                fit: BoxFit.cover,
                                height: 60,
                                width: 60,
                              ).cornerRadiusWithClipRRect(defaultRadius),
                              8.height,
                              Text(cat.cat_name.validate(), style: boldTextStyle(size: 14))
                            ],
                          ),
                        ).onTap(() {
                          ProductListByCategoryScreen(
                            req: {
                              "text": "",
                              "item_type": "",
                              "attribute": [],
                              "price": [],
                              "category": cat.cat_ID,
                              "product_per_page": postPerPage,
                            },
                          ).launch(context);
                        });
                      }
                      return Container(
                        margin: EdgeInsets.all(4),
                        height: 90,
                        width: 80,
                        color: primaryColor,
                      ).cornerRadiusWithClipRRect(defaultRadius);
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }
}
