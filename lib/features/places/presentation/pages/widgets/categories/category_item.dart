import 'package:flutter/material.dart';
import 'package:mozin/features/places/domain/entities/places_category.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/extension.dart';

class CategoryItem extends StatelessWidget {

  const CategoryItem({Key key, @required this.category}) : super(key: key);

  final PlacesCategory category;

  @override
  Widget build(BuildContext context) {
    return _buildCardItem(context);
  }

  Widget _buildCardItem(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.sizeByPixel(10)),
        alignment: Alignment.center,
        width: SizeConfig.sizeByPixel(95),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: category.categoryName.label(
          context,
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}