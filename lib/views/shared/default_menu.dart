import 'package:flutter/material.dart';
import 'package:mozin/views/more/more.dart';
import 'package:mozin/views/notifications/notifications.dart';

class DefaultMenu extends StatefulWidget {
  @override
  _DefaultMenuState createState() => _DefaultMenuState();
}

class _DefaultMenuState extends State<DefaultMenu> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex, // this will be set when a new tab is tapped
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        if (_currentIndex == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Notifications()),
          );
        }

        if (_currentIndex == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => More()),
          );
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Início'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.linear_scale),
          title: new Text('Linha'),
        ),
        BottomNavigationBarItem(
          icon: Container(
            height: 45.0,
            width: 45.0,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.add,
                  size: 30.0,
                ),
                elevation: 2.0,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          title: Text('Notificações'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          title: Text('Mais'),
        ),
      ],
    );
  }
}
