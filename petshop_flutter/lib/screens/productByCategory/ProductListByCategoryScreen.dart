import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/components/AppBarWidget.dart';
import 'package:pet_shop_flutter/components/AppScaffold.dart';
import 'package:pet_shop_flutter/components/ProductCardWidget.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/screens/ProductDetailScreen.dart';
import 'package:pet_shop_flutter/store/api/ApiStore.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

import '../../main.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  static String tag = '/ProductListScreen';
  final Map<String, dynamic>? req;
  final String? title;

  ProductListByCategoryScreen({this.req, this.title});

  @override
  ProductListByCategoryScreenState createState() => ProductListByCategoryScreenState();
}

class ProductListByCategoryScreenState extends State<ProductListByCategoryScreen> {
  ScrollController _scrollController = ScrollController();
  ApiStore apiStore = ApiStore();
  late Map<String, dynamic> request;
  bool loadMore = true;

  @override
  void initState() {
    super.initState();
    request = widget.req!;
    init();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (apiStore.isLoadMore) {
          apiStore.increasePageCount();

          appStore.setLoading(true);

          init();
        }
      }
    });
  }

  Future<void> init() async {
    request["page"] = apiStore.page;
    afterBuildCreated(() {
      appStore.setLoading(true);
    });

    getProducts(request).then((value) {
      appStore.setLoading(false);

      if (apiStore.page == 1) apiStore.clearProductList();

      apiStore.setLoadMore(value.data!.length == postPerPage);

      apiStore.addAllProductInList(value.data!);
    }).catchError((error) {
      appStore.setLoading(false);
      log(error.toString());
    });
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
    log(request);
    return Observer(
      builder: (_) {
        return SafeArea(
          child: AppScaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: context.height(),
                  width: context.width(),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: EdgeInsets.only(left: 8, top: 70, right: 8, bottom: 16),
                    child: Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      children: apiStore.productList.map(
                        (e) {
                          return ProductCardWidget(proDetail: e).onTap(() {
                            ProductDetailScreen(productID: e.id).launch(context);
                          });
                        },
                      ).toList(),
                    ),
                  ),
                ),
                AppBarWidget(
                  title: Row(
                    children: [
                      Icon(Icons.arrow_back_rounded).onTap(() {
                        finish(context);
                      }, splashColor: Colors.transparent, highlightColor: Colors.transparent),
                      16.width,
                      headingTextWidget(widget.title.validate(value: language!.allPets)),
                    ],
                  ),
                  scrollController: _scrollController,
                ),
                /*Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: context.width(),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: context.cardColor,
                      border: Border.all(color: appStore.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 5)],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.import_export_rounded),
                            4.width,
                            Text('Sort by', style: primaryTextStyle()),
                          ],
                        ).onTap(() {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) {
                              return SortByWidget();
                            },
                          );
                        }),
                        Container(
                          width: 1,
                          height: 35,
                          color: Colors.grey.shade300,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.filter_list_rounded),
                            4.width,
                            Text('Filter by', style: primaryTextStyle()),
                          ],
                        ).onTap(() {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) {
                              return FilterByWidget();
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),*/
                Observer(builder: (_) {
                  return Positioned(
                    left: 0,
                    right: 0,
                    top: 80,
                    child: Loader().visible(appStore.isLoading),
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
