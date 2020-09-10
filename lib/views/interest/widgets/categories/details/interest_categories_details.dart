import 'package:flutter/material.dart';
import 'package:mozin/views/interest/widgets/categories/details/interest_category_item_details.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/spacer_box.dart';
import 'package:mozin/views/shared/extension.dart';

class InterestCategoriesDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      customMargin: EdgeInsets.only(top: 0),
      child: Column(
        children: [
          "Selecione os seus interesses".title(context),
          SpacerBox.v34,
          ..._buildCards(),
        ],
      ),
    );
  }

  List<Widget> _buildCards() {
    return [
      InterestCategoryItemDetails(
        model: null,
        callbackSelected: (bool selected) {
          print('selected: ' + selected.toString());
        },
      ),
      SpacerBox.v16,
      InterestCategoryItemDetails(
        model: null,
        callbackSelected: (bool selected) {
          print('selected: ' + selected.toString());
        },
      ),
      SpacerBox.v16,
      InterestCategoryItemDetails(
        model: null,
        callbackSelected: (bool selected) {
          print('selected: ' + selected.toString());
        },
      ),
      SpacerBox.v16,
      InterestCategoryItemDetails(
        model: null,
        callbackSelected: (bool selected) {
          print('selected: ' + selected.toString());
        },
      ),
      SpacerBox.v16,
      InterestCategoryItemDetails(
        model: null,
        callbackSelected: (bool selected) {
          print('selected: ' + selected.toString());
        },
      ),
      SpacerBox.v16,
      InterestCategoryItemDetails(
        model: null,
        callbackSelected: (bool selected) {
          print('selected: ' + selected.toString());
        },
      ),
    ];
  }
}
