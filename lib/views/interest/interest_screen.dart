import 'package:flutter/material.dart';
import 'package:mozin/views/interest/widgets/interest_item.dart';
import 'package:mozin/views/search_places/search_places_screen.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/shared/spacer_box.dart';

class InterestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(context),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          "Selecione os seus interesses".title(context),
          SpacerBox.v34,
          _buildCards(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: new Text('Interesses'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.done),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPlacesScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCards() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 30,
      children: [
        InterestItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
        InterestItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
        InterestItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
        InterestItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
        InterestItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
        InterestItem(
          model: null,
          callbackSelected: (bool selected) {
            print('selected: ' + selected.toString());
          },
        ),
      ],
    );
  }
}
