import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppBarWidget.dart';
import 'package:pet_shop_flutter/screens/wishlist/components/WishlistItemWidget.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';
import 'package:pet_shop_flutter/utils/AppImages.dart';

import '../../main.dart';

class WishlistFragment extends StatefulWidget {
  static String tag = '/WishlistFragment';

  @override
  WishlistFragmentState createState() => WishlistFragmentState();
}

class WishlistFragmentState extends State<WishlistFragment> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    LiveStream().on(streamRefresh, (v) {
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Stack(
          children: [
            wishListStore.wishList.isNotEmpty
                ? SingleChildScrollView(
                    controller: _scrollController,
                    padding: EdgeInsets.only(left: 8, top: 60, right: 8, bottom: 16),
                    child: Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: wishListStore.wishList.map((e) {
                        return WishlistItemWidget(data: e);
                      }).toList(),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonCacheImage(emptyWishlist, width: 150, height: 120),
                      Text(
                        language!.wishListEmpty,
                        style: secondaryTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ).center(),
            AppBarWidget(
              title: headingTextWidget(language!.wishList),
              scrollController: _scrollController,
            ),
            Observer(builder: (_) => Loader().visible(appStore.isLoading))
          ],
        );
      },
    );
  }
}
