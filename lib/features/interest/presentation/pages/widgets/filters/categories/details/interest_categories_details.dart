import 'package:flutter/material.dart';
import 'package:mozin/features/interest/presentation/bloc/interest_bloc.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/categories/details/interest_category_item_details.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

class InterestCategoriesDetails extends StatelessWidget {
  final InterestBloc interestBloc;

  const InterestCategoriesDetails({Key key, @required this.interestBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      customMargin: EdgeInsets.only(top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: "Selecione os seus interesses".title(context),
          ),
          SpacerBox.v34,
          ..._buildCards(),
        ],
      ),
    );
  }

  List<Widget> _buildCards() {
    return interestBloc.state.categoriesSelected.map((element) {
      return InterestCategoryItemDetails(
        item: element,
        callbackSelected: (bool selected) {
          print('selected: ' + selected.toString());
        },
      );
    }).toList();
  }
}
