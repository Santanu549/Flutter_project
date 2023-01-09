import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/order/OrderTracking.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/dashed_ract.dart';

class OrderNoteWidget extends StatelessWidget {
  final OrderTracking mOrderTrackingModel;

  OrderNoteWidget({required this.mOrderTrackingModel});

  @override
  Widget build(BuildContext context) {
    Widget mData(OrderTracking orderTracking) {
      Tracking tracking;
      try {
        var x = jsonDecode(orderTracking.note!) as Map<String, dynamic>;
        tracking = Tracking.fromJson(x);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Text(tracking.status.validate(), style: boldTextStyle()), Text(tracking.message.validate(), style: secondaryTextStyle())],
        );
      } on FormatException catch (e) {
        log(e);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(language!.byAdmin, style: boldTextStyle()),
            Text(orderTracking.note.validate(), style: secondaryTextStyle(size: 16)),
          ],
        );
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
              height: 10,
              width: 10,
              decoration: BoxDecoration(color: primaryColor, borderRadius: radius(16)),
            ),
            SizedBox(height: 100, child: DashedRect(gap: 2, color: primaryColor)),
          ],
        ),
        8.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            mData(mOrderTrackingModel),
            8.height,
            Text(convertDate(mOrderTrackingModel.dateCreated.validate()), style: secondaryTextStyle()),
          ],
        ).expand()
      ],
    );
  }
}
