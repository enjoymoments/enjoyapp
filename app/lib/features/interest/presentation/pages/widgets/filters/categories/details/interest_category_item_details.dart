import 'package:flutter/material.dart';
import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/categories/details/interest_category_item_badge.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/extensions/extension.dart';

class InterestCategoryItemDetails extends StatelessWidget {
  const InterestCategoryItemDetails(
      {Key key, @required this.item, @required this.callbackSelected})
      : super(key: key);

  final CategoriesModel item;
  final Function(bool, SubCategoriesModel) callbackSelected;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.sizeByPixel(4.0),
        bottom: SizeConfig.sizeByPixel(4.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item.name.title(
            context,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: SizeConfig.sizeByPixel(10),
            children: _generateItems(),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateItems() {
    return item.subCategories.map((element) {
      return InterestCategoryItemBadge(
        item: element,
        callbackSelected: callbackSelected,
      );
    }).toList();
  }
}
