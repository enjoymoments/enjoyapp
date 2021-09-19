import 'package:flutter/material.dart';
import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:mozin/features/suggestions/presentation/pages/widgets/suggestion_category_item_badge.dart';

@Deprecated('DUPLICATE FROM \'interest_category_item_details.dart\'')
class SuggestionCategoryItemDetails extends StatelessWidget {
  const SuggestionCategoryItemDetails(
      {Key? key, required this.item, required this.callbackSelected})
      : super(key: key);

  final CategoriesModel item;
  final Function(SubCategoriesModel) callbackSelected;

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
          item.name!.title(
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
    return item.subCategories!.map((element) {
      return SuggestionCategoryItemBadge(
        item: element as SubCategoriesModel,
        callbackSelected: callbackSelected,
      );
    }).toList();
  }
}
