import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/enum/default_menu_enum.dart';

class DefaultMenu extends StatefulWidget {
  final Function(DEFAULT_MENU_ENUM) onTap;

  const DefaultMenu({Key key, this.onTap}) : super(key: key);

  @override
  _DefaultMenuState createState() => _DefaultMenuState();
}

class _DefaultMenuState extends State<DefaultMenu> {
  int _currentIndex = 0;
  double _sizeIcon = 18;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) {
        _currentIndex = index;
        widget.onTap(DEFAULT_MENU_ENUM.values[_currentIndex]);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(AppIcons.home, size: _sizeIcon),
          title: Text('Início'),
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.people_carry, size: _sizeIcon),
          title: Text('Casal'),
        ),
        BottomNavigationBarItem(
          icon: Container(
            height: SizeConfig.sizeByPixel(45.0),
            width: SizeConfig.sizeByPixel(45.0),
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  widget.onTap(DEFAULT_MENU_ENUM.SEARCH);
                },
                child: Image.asset(
                  'assets/icons/icon.png',
                  fit: BoxFit.fill,
                ),
                elevation: 2.0,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          title: SizedBox.shrink(),
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.user, size: _sizeIcon),
          title: Text('Eu'),
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.bell, size: _sizeIcon),
          title: Text('Alertas'),
        ),
      ],
    );
  }
}
