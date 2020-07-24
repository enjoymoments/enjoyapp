import 'package:flutter/material.dart';
import 'package:mozin/views/more/more_screen.dart';
import 'package:mozin/views/notifications/notifications_screen.dart';
import 'package:mozin/views/shared/enum/default_menu_enum.dart';

class DefaultMenu extends StatefulWidget {
  final Function(DEFAULT_MENU_ENUM) onTap;

  const DefaultMenu({Key key, this.onTap}) : super(key: key);

  @override
  _DefaultMenuState createState() => _DefaultMenuState();
}

class _DefaultMenuState extends State<DefaultMenu> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) {
        _currentIndex = index;
        widget.onTap(DEFAULT_MENU_ENUM.values[_currentIndex]);
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
