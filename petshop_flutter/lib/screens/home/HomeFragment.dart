import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/model/dashboard/DashboardResponse.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/screens/home/components/BannerSliderWidget.dart';
import 'package:pet_shop_flutter/screens/home/components/ProductListWidget.dart';
import 'package:pet_shop_flutter/screens/home/components/TopBarWidget.dart';

class HomeFragment extends StatefulWidget {
  static String tag = '/HomeFragment';

  @override
  HomeFragmentState createState() => HomeFragmentState();
}

class HomeFragmentState extends State<HomeFragment> {
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
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        await 2.seconds.delay;
        return Future.value(true);
      },
      child: SnapHelperWidget<DashboardResponse>(
        future: dashboardApi(),
        onSuccess: (data) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBarWidget(catResList: data.category.validate()),
                8.height,
                if (data.banner!.isNotEmpty) BannerSliderViewWidget(bannerList: data.banner),
                8.height,
                ProductListWidget(dashboardResponse: data, saleBanner: data.salebanner),
              ],
            ),
          );
        },
      ),
    );
  }
}
