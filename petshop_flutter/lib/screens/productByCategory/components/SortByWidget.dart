import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';

class SortByWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sort by', style: secondaryTextStyle(size: 18)).paddingAll(16),
        Divider(height: 0),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(5, (index) {
              return Text(language!.price, style: primaryTextStyle()).withWidth(context.width()).paddingAll(16).onTap(() {
                //
              });
            }),
          ),
        ),
      ],
    ).withHeight(context.height() * 0.5);
  }
}
