import 'package:flutter/material.dart';
import 'package:mozin/views/interest/widgets/interest_menu.dart';
import 'package:mozin/views/places/widgets/place_card_item.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';

class SearchPlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: InterestMenu(onTap: (itemSelected) {}),
    );
  }

  Widget _buildBody() {
    return CustomContainer(
      child: PlaceCardItem(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: new Text('Sugestões'),
    );
  }
}