import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/order/OrderResponseModel.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';

import 'components/OrderItemWidget.dart';

class OrderListScreen extends StatefulWidget {
  static String tag = '/OrderListScreen';

  @override
  OrderListScreenState createState() => OrderListScreenState();
}

class OrderListScreenState extends State<OrderListScreen> {
  late Future<List<OrderResponseModel>> _orderList;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    _orderList = getOrders();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: appBarWidget(language!.orders, color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white),
      body: Stack(
        children: [
          FutureBuilder<List<OrderResponseModel>>(
            future: _orderList,
            builder: (context, snap) {
              if (snap.hasData) {
                afterBuildCreated(() {
                  appStore.setLoading(false);
                });
                return snap.data!.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.only(
                          left: 8,
                          top: 8,
                          right: 8,
                        ),
                        itemCount: snap.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (_, index) => OrderItemWidget(
                            mOrder: snap.data![index],
                            onCall: () {
                              setState(() {
                                init();
                              });
                            }),
                      )
                    : Text("No Data Found", style: primaryTextStyle()).center();
              }
              return snapWidgetHelper(snap);
            },
          ),
          Observer(builder: (_) => Loader().visible(appStore.isLoading))
        ],
      ),
    );
  }
}
