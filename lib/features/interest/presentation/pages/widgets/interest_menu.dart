import 'package:flutter/material.dart';
import 'package:mozin/features/interest/presentation/pages/widgets/enums/interest_menu_enum.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_icon.dart';

class InterestMenu extends StatefulWidget {
  final Function(INTEREST_MENU_ENUM) onTap;

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
        widget.onTap(INTEREST_MENU_ENUM.values[_currentIndex]);
      },
      items: [
        BottomNavigationBarItem(
          icon: CustomIcon(icon: AppIcons.search),
          title: new Text('Pesquisar'),
        ),
        BottomNavigationBarItem(
          icon: CustomIcon(icon: AppIcons.filter),
          title: new Text('Mudar Filtro'),
        ),
      ],
    );
  }
}
