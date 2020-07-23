import 'package:flutter/material.dart';
import 'package:mozin/views/day_one/day_one.dart';
import 'package:mozin/views/shared/custom_container.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return CustomContainer(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DayOne()),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Toque aqui para adicionar o dia 1',
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
