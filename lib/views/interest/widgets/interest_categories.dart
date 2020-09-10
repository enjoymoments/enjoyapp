import 'package:flutter/material.dart';
import 'package:mozin/views/interest/widgets/interest_category_item.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/spacer_box.dart';
import 'package:mozin/views/shared/extension.dart';

class InterestCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      customMargin: EdgeInsets.only(top:0),
      child: Column(
        children: [
          "Selecione os seus interesses".title(context),
          SpacerBox.v34,
          _buildCards(),
        ],
      ),
    );
  }

  Widget _buildCards() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 30,
      children: [
        InterestCategoryItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
        InterestCategoryItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
        InterestCategoryItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
        InterestCategoryItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
        InterestCategoryItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
        InterestCategoryItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
      ],
    );
  }
}