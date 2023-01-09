import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/discoutTag.dart';
import 'package:pet_shop_flutter/model/product/UpsellId.dart';
import 'package:pet_shop_flutter/screens/ProductDetailScreen.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class ProductDetailWidget extends StatefulWidget {
  final List<UpsellId>? upSellData;

  ProductDetailWidget({this.upSellData});

  @override
  ProductDetailWidgetState createState() => ProductDetailWidgetState();
}

class ProductDetailWidgetState extends State<ProductDetailWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: widget.upSellData.validate().map(
        (e) {
          return Stack(
            children: [
              Container(
                width: (context.width() / 2) - 12,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5)), borderRadius: BorderRadius.circular(defaultRadius)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    commonCacheImage(
                      e.images!.first.src,
                      width: context.width(),
                      height: 200,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRectOnly(topRight: defaultRadius.toInt(), topLeft: defaultRadius.toInt()),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.4)),
                    8.height,
                    Text(e.name.validate(), style: boldTextStyle(size: 18), maxLines: 1, overflow: TextOverflow.ellipsis).paddingOnly(left: 12, right: 8),
                    4.height,
                    Wrap(
                      clipBehavior: Clip.hardEdge,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('\$${e.price.validate()}', style: boldTextStyle(size: 20)),
                      ],
                    ).paddingOnly(left: 12, right: 8, bottom: 8),
                  ],
                ),
              ),
              if (e.sale_price!.isNotEmpty)
                Positioned(
                  left: 0,
                  top: 20,
                  child: DiscountTag(
                    discount: discountText(e.regular_price!, e.sale_price!),
                  ),
                ),
            ],
          ).onTap(() {
            ProductDetailScreen(productID: e.id).launch(context);
          }, highlightColor: context.cardColor, splashColor: context.cardColor);
        },
      ).toList(),
    ).paddingOnly(left: 8, right: 8);
  }
}
