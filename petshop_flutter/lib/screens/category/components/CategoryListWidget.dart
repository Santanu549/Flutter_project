import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pet_shop_flutter/model/dashboard/CategoryModel.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class CategoryListWidget extends StatelessWidget {
  final List<CategoryModel>? categoryList;
  final Function(CategoryModel)? onCatTap;

  CategoryListWidget({this.categoryList, this.onCatTap});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: categoryList!.map((e) {
        return FutureBuilder<Color>(
          future: getImagePalette(NetworkImage(e.image.validate())),
          builder: (context, snap) {
            if (snap.hasData) {
              return Container(
                padding: EdgeInsets.all(8),
                width: (context.width() / 3) - 11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  color: snap.data!.withOpacity(0.4),
                ),
                child: Column(
                  children: [
                    commonCacheImage(e.image, height: 100),
                    8.height,
                    Text(e.name.validate(), style: boldTextStyle()),
                  ],
                ),
              ).onTap(() {
                onCatTap!(e);
              });
            }
            return Container(
              height: 120,
              width: (context.width() / 3) - 14,
              color: primaryColor,
            ).cornerRadiusWithClipRRect(defaultRadius);
          },
        );
      }).toList(),
    );
  }

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }
}
