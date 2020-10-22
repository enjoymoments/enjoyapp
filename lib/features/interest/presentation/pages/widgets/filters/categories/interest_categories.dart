import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/interest/presentation/bloc/interest_bloc.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/filters/categories/interest_category_item.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

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
    return BlocBuilder<InterestBloc, InterestState>(
      cubit: interestBloc,
      builder: (context, state) {
        if (state.isLoading) {
          return CustomCircularProgressIndicator();
        }

        if (state.categories.isNotEmpty) {
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 30,
            children: _generateItems(state),
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  List<Widget> _generateItems(InterestState state) {
    return state.categories.map((element) {
      return InterestCategoryItem(
        categorie: element,
        callbackSelected: (bool selected) {
          interestBloc.add(SelectCategorie(itemSelected: element, selected: selected));
        },
      );
    }).toList();
  }
}
