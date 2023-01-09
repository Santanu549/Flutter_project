import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/order/OrderResponseModel.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

import '../OrderDescriptionScreen.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderResponseModel mOrder;
  final Function onCall;

  OrderItemWidget({required this.mOrder, required this.onCall});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: radius()),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (mOrder.lineItems!.isNotEmpty.validate())
                    if (mOrder.lineItems![0].productImages![0].src!.isNotEmpty.validate())
                      commonCacheImage(mOrder.lineItems![0].productImages![0].src.validate(), height: 80, width: 80, fit: BoxFit.cover).cornerRadiusWithClipRRect(defaultRadius).paddingAll(8),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      2.height,
                      if (mOrder.lineItems!.isNotEmpty)
                        if (mOrder.lineItems!.length > 1)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mOrder.lineItems![0].name.validate(), maxLines: 1, overflow: TextOverflow.ellipsis, style: boldTextStyle()),
                              4.height,
                              Text(language!.moreItems, style: secondaryTextStyle(color: primaryColor.withOpacity(0.5))),
                            ],
                          )
                        else
                          Text(mOrder.lineItems![0].name.validate(), maxLines: 1, overflow: TextOverflow.ellipsis, style: boldTextStyle())
                      else
                        Text(mOrder.id.toString().validate(), style: primaryTextStyle(size: 18)),
                      2.height,
                      Text(mOrder.status!.toUpperCase().toString(), style: boldTextStyle())
                    ],
                  ).paddingAll(8).expand()
                ],
              ),
            ],
          ),
        ],
      ),
    ).onTap(() async {
      bool? isChanged = await OrderDescriptionScreen(mOrderModel: mOrder).launch(context);
      if (isChanged != null) {
        appStore.setLoading(true);
        onCall.call();
      }
    });
  }
}
