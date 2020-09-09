import 'package:flutter/material.dart';
import 'package:mozin/views/search_places/search_places_screen.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';

class InterestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildBody() {
    return null;
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
}
