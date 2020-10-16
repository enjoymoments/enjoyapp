import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/enums/interest_menu_enum.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/interest_menu.dart';
import 'package:mozin/features/places/presentation/pages/widgets/place_card_item.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class SearchPlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: InterestMenu(onTap: (itemSelected) {
        if(itemSelected == INTEREST_MENU_ENUM.CHANGE_FILTER) {
          //TODO:review this - route 'interest_screen' duplicate in tree
          ExtendedNavigator.of(context).push(Routes.interest_screen);
        }
      }),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          children: [
            PlaceCardItem(),
            SpacerBox.v8,
            PlaceCardItem(),
            SpacerBox.v8,
            PlaceCardItem(),
            SpacerBox.v8,
            PlaceCardItem(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: new Text('Sugestões'),
    );
  }
}
