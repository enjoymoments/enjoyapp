import 'package:flutter/material.dart';
import 'package:mozin/features/interest/presentation/bloc/interest_bloc.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/categories/categorie_item_loading.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/categories/interest_category_item.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';

class InterestCategories extends StatelessWidget {
  final InterestBloc interestBloc;

  const InterestCategories({Key key, @required this.interestBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      customMargin: EdgeInsets.only(top: 0),
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
    if (interestBloc.state.isLoading) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 30,
        children: _generateItemsLoading(),
      );
    }

    if (interestBloc.state.categories.isNotEmpty) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 30,
        children: _generateItems(),
      );
    }

    return SizedBox.shrink();
  }

  List<Widget> _generateItems() {
    return interestBloc.state.categories.map((element) {
      return InterestCategoryItem(
        categorie: element,
        callbackSelected: (bool selected) {
          interestBloc
              .add(SelectCategorie(itemSelected: element, selected: selected));
        },
      );
    }).toList();
  }

  List<Widget> _generateItemsLoading() {
    return List.generate(3, (index) => CategorieItemLoading());
  }
}
