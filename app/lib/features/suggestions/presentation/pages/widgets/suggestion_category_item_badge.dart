import 'package:flutter/material.dart';
import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:custom_view/size_config.dart';
import 'package:custom_view/extensions/extension.dart';

@Deprecated('DUPLICATE FROM \'interest_category_item_badge.dart\'')
class SuggestionCategoryItemBadge extends StatelessWidget {
  const SuggestionCategoryItemBadge(
      {Key? key, required this.item, required this.callbackSelected})
      : super(key: key);

  final SubCategoriesModel item;
  final Function(SubCategoriesModel) callbackSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        item.selected = item.selected != null ? !item.selected! : true;
        callbackSelected(item);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.sizeByPixel(10)),
        alignment: Alignment.center,
        width: SizeConfig.sizeByPixel(95),
        decoration: myBoxDecoration(context),
        child: item.name!.label(
          context,
          color: _getTextColor(context),
          maxLines: 1
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: _getBackgroundColor(context),
      border: Border.all(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    return item.selected != null && item.selected!
        ? Theme.of(context).primaryColor
        : Theme.of(context).hintColor;
  }

  Color? _getTextColor(BuildContext context) {
    if (item.selected != null && item.selected!) {
      return Theme.of(context).backgroundColor;
    }

    return null;
  }
}
