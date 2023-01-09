import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';
import 'package:pet_shop_flutter/model/AttributeModel.dart';
import 'package:pet_shop_flutter/network/RestApis.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';

class FilterByWidget extends StatelessWidget {
  final List<String> filterTitles = ['Categories', 'Sizes', 'Brands', 'Colors', 'Weight'];
  int index = 0;
  List<dynamic> list = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.cardColor,
      child: SizedBox(
        height: context.height() * 0.9,
        child: FutureBuilder<AttributeModel>(
          future: getAttributes(),
          builder: (context, snap) {
            if (snap.hasData) {
              list.addAll([snap.data!.categories, snap.data!.sizes, snap.data!.brands, snap.data!.colors, snap.data!.pa_weight]);
              return StatefulBuilder(
                builder: (ctx, setState) {
                  return Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(language!.filterBy, style: secondaryTextStyle(size: 16)).expand(),
                              Text(language!.clear, style: secondaryTextStyle(size: 16)),
                            ],
                          ).paddingAll(16),
                          Divider(height: 0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  height: context.height(),
                                  decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.grey.shade300)), color: context.cardColor),
                                  child: ListView.separated(
                                    itemCount: filterTitles.length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        padding: EdgeInsets.all(16),
                                        color: index == i ? primaryColor.withOpacity(0.2) : Colors.transparent,
                                        child: Text(filterTitles[i].validate(), style: primaryTextStyle()),
                                      ).onTap(() {
                                        setState(() {
                                          index = i;
                                        });
                                      });
                                    },
                                    separatorBuilder: (_, index) => Divider(height: 0),
                                  ),
                                ),
                              ).expand(flex: 2),
                              Container(
                                height: context.height(),
                                color: context.cardColor,
                                child: list[index] != null
                                    ? ListView.builder(
                                        itemCount: list[index].length,
                                        itemBuilder: (context, e) {
                                          return Row(
                                            children: [
                                              Checkbox(value: true, onChanged: (val) {}),
                                              Text(list[index][e].firstName, style: primaryTextStyle()).expand(),
                                              Text('122', style: secondaryTextStyle()).paddingOnly(right: 8),
                                            ],
                                          ).onTap(() {
                                            //
                                          });
                                        },
                                      )
                                    : SizedBox(
                                        child: Text(language!.noAttributesYet, style: primaryTextStyle()),
                                      ).center(),
                              ).expand(flex: 3),
                            ],
                          ).expand(),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: context.cardColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(language!.close, style: secondaryTextStyle(size: 16)).paddingSymmetric(horizontal: 16, vertical: 16).onTap(() {
                                finish(context);
                              }),
                              Container(
                                width: 1,
                                height: 25,
                                color: Colors.grey.shade300,
                              ),
                              Text(language!.apply, style: boldTextStyle(color: primaryColor)).paddingSymmetric(horizontal: 16, vertical: 16).onTap(() {
                                //
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return snapWidgetHelper(snap);
          },
        ),
      ),
    );
  }
}
