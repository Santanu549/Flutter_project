import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/order/OrderResponseModel.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

class CancelOrderWidget extends StatefulWidget {
  static String tag = '/CancelOrderWidget';
  final OrderResponseModel? mOrderModel;

  CancelOrderWidget({Key? key, this.mOrderModel}) : super(key: key);

  @override
  CancelOrderWidgetState createState() => CancelOrderWidgetState();
}

class CancelOrderWidgetState extends State<CancelOrderWidget> {
  List mCancelList = [
    "Product is being delivered to a wrong address",
    "Product is not required anymore",
    "Cheaper alternative available for lesser price",
    "The price of the product has fallen due to sales/discounts and customer wants to get it at a lesser price",
    "Bad review from friends/relatives after ordering the product.",
    "Order placed by mistake",
  ].toList();

  String? mValue = "";
  int? cancelOrderIndex = 0;

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

  void cancelOrderData(String? mValue) async {
    appStore.setLoading(true);
    var request = {
      "status": "cancelled",
      "customer_note": mValue,
    };
    await cancelOrder(widget.mOrderModel!.id, request).then((res) {
      var request = {
        'customer_note': true,
        'note': "{\n" + "\"status\":\"Cancelled\",\n" + "\"message\":\"Order Canceled by you due to " + mValue! + ".\"\n" + "} ",
      };
      createOrderNotes(widget.mOrderModel!.id, request).then((res) {
        appStore.setLoading(false);
        finish(context, true);
      }).catchError((error) {
        appStore.setLoading(false);
        finish(context, true);
        toast(error.toString());
      });
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error.toString());
      finish(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mOrderModel!.status == COMPLETED ||
        widget.mOrderModel!.status == REFUNDED ||
        widget.mOrderModel!.status == CANCELED ||
        widget.mOrderModel!.status == TRASH ||
        widget.mOrderModel!.status == FAILED) {
      return SizedBox();
    } else {
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            builder: (context) {
              return BottomSheet(
                backgroundColor: context.cardColor,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return Container(
                        padding: EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(language!.cancelOrder, style: boldTextStyle()).expand(),
                                Icon(Icons.close).onTap(() {
                                  finish(context);
                                })
                              ],
                            ),
                            24.height,
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: mCancelList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    mValue = mCancelList[index]!;
                                    print(mValue);
                                    setState(() {
                                      // appStore.setCancelItemIndex(index);
                                      cancelOrderIndex = index;
                                    });
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          decoration: boxDecorationWithRoundedCorners(
                                            borderRadius: radius(4),
                                            border: Border.all(color: primaryColor),
                                            backgroundColor: cancelOrderIndex == index ? primaryColor : context.cardColor,
                                          ),
                                          width: 16,
                                          height: 16,
                                          child: Icon(Icons.done, size: 12, color: context.cardColor)),
                                      4.width,
                                      Text(mCancelList[index].toString(), style: primaryTextStyle()).paddingLeft(8).expand(),
                                    ],
                                  ).paddingOnly(top: 8, bottom: 8),
                                );
                              },
                            ),
                            24.height,
                            AppButton(
                              width: context.width(),
                              textStyle: primaryTextStyle(color: white),
                              text: language!.cancelOrder,
                              color: primaryColor,
                              onTap: () {
                                Navigator.pop(context);
                                appStore.setLoading(true);
                                cancelOrderData(mValue);
                              },
                            ),
                            20.height,
                          ],
                        ),
                      );
                    },
                  );
                },
                onClosing: () {},
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(language!.cancelOrder, style: primaryTextStyle(color: primaryColor)).expand(),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      );
    }
  }
}
