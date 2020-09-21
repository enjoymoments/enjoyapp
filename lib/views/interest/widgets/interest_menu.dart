import 'package:flutter/material.dart';
import 'package:mozin/views/shared/enum/default_menu_enum.dart';

class InterestMenu extends StatefulWidget {
  final Function(DEFAULT_MENU_ENUM) onTap;

  const InterestMenu({Key key, this.onTap}) : super(key: key);

  @override
  _InterestMenuState createState() => _InterestMenuState();
}

class _InterestMenuState extends State<InterestMenu> {
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
          icon: new Icon(Icons.search),
          title: new Text('Pesquisar'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.filter),
          title: new Text('Mudar Filtro'),
        ),
      ],
    );
  }
}
