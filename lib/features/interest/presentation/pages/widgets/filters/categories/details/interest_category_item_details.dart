import 'package:flutter/material.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/categories/details/interest_category_item_badge.dart';
import 'package:mozin/package_view/extension.dart';

class InterestCategoryItemDetails extends StatelessWidget {
  const InterestCategoryItemDetails(
      {Key key, @required this.model, @required this.callbackSelected})
      : super(key: key);

  final dynamic model;
  final Function(bool) callbackSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Alimentação".title(
          context,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 10,
          children: [
            InterestCategoryItemBadge(
              model: model,
              callbackSelected: callbackSelected,
            ),
            InterestCategoryItemBadge(
              model: model,
              callbackSelected: callbackSelected,
            ),
            InterestCategoryItemBadge(
              model: model,
              callbackSelected: callbackSelected,
            ),
            InterestCategoryItemBadge(
              model: model,
              callbackSelected: callbackSelected,
            ),
          ],
        ),
      ],
    );
  }
}
