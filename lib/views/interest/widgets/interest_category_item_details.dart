import 'package:flutter/material.dart';
import 'package:mozin/views/interest/widgets/interest_category_item_badges.dart';
import 'package:mozin/views/shared/extension.dart';

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
        "Alimentação".label(
          context,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 10,
          children: [
            InterestCategoryItemBadges(
              model: model,
              callbackSelected: callbackSelected,
            ),
            InterestCategoryItemBadges(
              model: model,
              callbackSelected: callbackSelected,
            ),
            InterestCategoryItemBadges(
              model: model,
              callbackSelected: callbackSelected,
            ),
            InterestCategoryItemBadges(
              model: model,
              callbackSelected: callbackSelected,
            ),
          ],
        ),
      ],
    );
  }
}
