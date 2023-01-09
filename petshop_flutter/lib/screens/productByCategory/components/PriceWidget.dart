import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PriceWidget extends StatelessWidget {
  final String? salePrice;
  final String? regularPrice;
  final int priceFontSize;
  final int saleFontSize;

  PriceWidget({this.salePrice, this.regularPrice, this.priceFontSize = 28, this.saleFontSize = 18});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('\$${salePrice!.isNotEmpty ? salePrice.validate(value: "0") : regularPrice.validate(value: "0")}', style: boldTextStyle(size: priceFontSize)),
        4.width,
        if (salePrice!.isNotEmpty) Text('\$${regularPrice.validate(value: "0")}', style: secondaryTextStyle(decoration: TextDecoration.lineThrough, size: saleFontSize)),
      ],
    );
  }
}
