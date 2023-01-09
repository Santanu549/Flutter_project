import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/order/LineItems.dart';
import 'package:pet_shop_flutter/model/order/OrderResponseModel.dart';
import 'package:pet_shop_flutter/model/order/OrderTracking.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';

import 'components/CancelOrderWidget.dart';
import 'components/OrderDescriptionItemWidget.dart';
import 'components/OrderNoteWidget.dart';

class OrderDescriptionScreen extends StatefulWidget {
  static String tag = '/OrderDescriptionScreen';
  final OrderResponseModel? mOrderModel;

  OrderDescriptionScreen({Key? key, this.mOrderModel}) : super(key: key);

  @override
  OrderDescriptionScreenState createState() => OrderDescriptionScreenState();
}

class OrderDescriptionScreenState extends State<OrderDescriptionScreen> {
  List<LineItems> mLineItems = [];
  double mTotalMrpDiscount = 0.0;
  double mTotalMrp = 0.0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void getTotalAmount() {
    for (var i = 0; i < widget.mOrderModel!.lineItems!.length; i++) {
      var mItem = LineItems();
      mItem.proId = widget.mOrderModel!.lineItems![i].productId;
      mItem.quantity = widget.mOrderModel!.lineItems![i].quantity.toString();
      mLineItems.add(mItem);

      mTotalMrp += widget.mOrderModel!.lineItems![i].subtotal.toInt();
      mTotalMrpDiscount -= (mTotalMrp * (mTotalMrp * widget.mOrderModel!.discountTotal.toInt()) / 100);
    }
  }

  Widget mTracking() {
    return FutureBuilder<List<OrderTracking>>(
      future: getOrdersTracking1(widget.mOrderModel!.id),
      builder: (context, snap) {
        if (snap.hasData) {
          return ListView.builder(
            padding: EdgeInsets.only(
              left: 8,
              top: 8,
              right: 8,
            ),
            itemCount: snap.data!.length,
            shrinkWrap: true,
            itemBuilder: (_, index) => OrderNoteWidget(mOrderTrackingModel: snap.data![index]),
          );
        }
        return snapWidgetHelper(snap);
      },
    );
  }

  Widget mOrderDeliveryAddress() {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: radius()),
      margin: EdgeInsets.only(top: 8, bottom: 8),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(language!.deliveryAddress, style: boldTextStyle()),
          8.height,
          Text(widget.mOrderModel!.shipping!.first_name! + " " + widget.mOrderModel!.shipping!.last_name!, style: primaryTextStyle()),
          2.height,
          Text(widget.mOrderModel!.shipping!.address_1! + " " + widget.mOrderModel!.shipping!.city! + " " + widget.mOrderModel!.shipping!.country! + " " + widget.mOrderModel!.shipping!.state!,
              style: secondaryTextStyle()),
        ],
      ),
    );
  }

  Widget mOrderPrice() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: radius()),
      margin: EdgeInsets.only(top: 8, bottom: 8),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                language!.totalOrderPrice,
                style: boldTextStyle(color: greenColor.withOpacity(0.8)),
              ),
              Text('\$${widget.mOrderModel!.total}', style: boldTextStyle()),
            ],
          ),
          6.height,
          Text(widget.mOrderModel!.paymentMethod.toString(), style: primaryTextStyle()),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Text(language!.viewDetails, style: boldTextStyle(size: 14, color: primaryColor)).onTap(() {
          //     showModalBottomSheet(
          //       isScrollControlled: true,
          //       context: context,
          //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //       builder: (BuildContext context) {
          //         return Container(
          //           width: context.width(),
          //           padding: EdgeInsets.all(16),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(language!.paymentDetail, style: boldTextStyle(color: primaryColor)),
          //                   Icon(Icons.close_rounded).onTap(() {
          //                     finish(context);
          //                   }),
          //                 ],
          //               ).paddingOnly(top: 8, bottom: 8),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(language!.totalMrp, style: secondaryTextStyle(size: 16)),
          //                   Text('\$$mTotalMrp', style: boldTextStyle()).expand(),
          //                 ],
          //               ).paddingOnly(top: 8, bottom: 8),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(language!.discountOnMrp, style: secondaryTextStyle(size: 16)),
          //                   Row(
          //                     children: [
          //                       Text("-", style: primaryTextStyle(color: primaryColor)),
          //                       Text('\$$mTotalMrpDiscount', style: boldTextStyle()).expand(),
          //                       // PriceWidget(price: mTotalMrpDiscount, color: primaryColor, size: 16),
          //                     ],
          //                   ),
          //                 ],
          //               ).paddingOnly(top: 8, bottom: 8).visible(mTotalMrpDiscount != 0),
          //               SizedBox(width: context.width(), child: DashedRect(gap: 3, color: Colors.grey)),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(language!.totalAmount, style: boldTextStyle(size: 18, color: greenColor)),
          //                   Text('\$${widget.mOrderModel!.total}',
          //                       style: boldTextStyle(
          //                         size: 18,
          //                       )).expand(),
          //                 ],
          //               ).paddingOnly(top: 16, bottom: 8),
          //               16.height,
          //               Container(
          //                 height: 50,
          //                 padding: EdgeInsets.only(left: 16),
          //                 width: context.width(),
          //                 alignment: Alignment.center,
          //                 decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, border: Border.all(width: 0.2)),
          //                 child: Text(widget.mOrderModel!.paymentMethod.toString(), style: boldTextStyle()),
          //               ).paddingOnly(top: 8, bottom: 8)
          //             ],
          //           ),
          //         );
          //       },
          //     );
          //   }),
          // )
        ],
      ),
    );
  }

  Widget mOrderNotes() {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: radius()),
      margin: EdgeInsets.only(top: 8, bottom: 8),
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          mTracking(),
          CancelOrderWidget(mOrderModel: widget.mOrderModel),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: appBarWidget(language!.orderDetail, color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mOrderDeliveryAddress(),
                mOrderPrice(),
                mOrderNotes(),
                OrderDescriptionItemWidget(mOrderModel: widget.mOrderModel!),
              ],
            ).paddingOnly(left: 16, right: 16),
          ),
          Observer(builder: (_) => Loader().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
