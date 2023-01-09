import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/order/OrderResponseModel.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class OrderDescriptionItemWidget extends StatelessWidget {
  final OrderResponseModel mOrderModel;

  OrderDescriptionItemWidget({required this.mOrderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: radius()),
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          8.height,
          Text(language!.otherItems, style: boldTextStyle()),
          4.height,
          Text(language!.orderId + mOrderModel.id.toString(), style: secondaryTextStyle()),
          8.height,
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: mOrderModel.lineItems!.length,
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                decoration: boxDecorationWithShadow(borderRadius: radius(), backgroundColor: context.scaffoldBackgroundColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonCacheImage(
                      mOrderModel.lineItems![i].productImages![0].src.validate(),
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(defaultRadius),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mOrderModel.lineItems![i].name!, style: primaryTextStyle(size: 14), overflow: TextOverflow.ellipsis, maxLines: 5),
                        8.height,
                        Row(
                          children: [
                            Text('\$${mOrderModel.lineItems![i].total.toString()}', style: boldTextStyle()).expand(),
                            4.width,
                            Text(
                              "Qty" + " " + mOrderModel.lineItems![i].quantity.toString(),
                              style: primaryTextStyle(size: 14, color: primaryColor.withOpacity(0.8)),
                            ),
                          ],
                        )
                      ],
                    ).paddingOnly(left: 16, right: 16, top: 4).expand()
                  ],
                ),
              );
            },
          ),
          8.height,
          createRichText(list: [
            TextSpan(text: "You saved" + " ", style: secondaryTextStyle()),
            TextSpan(text: mOrderModel.discountTotal, style: boldTextStyle()),
            TextSpan(text: " " + "On this order", style: secondaryTextStyle()),
          ]).visible(int.parse(mOrderModel.discountTotal.toString()) > 0),
        ],
      ),
    );
  }
}
