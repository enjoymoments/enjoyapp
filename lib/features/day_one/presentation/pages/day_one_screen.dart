import 'package:flutter/material.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_scaffold.dart';

class DayOneScreen extends StatefulWidget {
  @override
  _DayOneScreenState createState() => _DayOneScreenState();
}

class _DayOneScreenState extends State<DayOneScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(),
      bottomNavigationBar: null,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Dia 1'),
    );
  }

  Widget _buildBody() {
    return CustomContainer(
      child: InkWell(
        onTap: () {
          print('tocou');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Dia 1',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 28),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
