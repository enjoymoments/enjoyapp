import 'package:flutter/material.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:custom_view/AppIcons.dart';

class DefaultMenu extends StatefulWidget {
  final Function(DefaultMenuEnum) onTap;

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
      elevation: 0,
      onTap: (index) {
        _currentIndex = index;
        widget.onTap(DefaultMenuEnum(_currentIndex));
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(AppIcons.home, size: _sizeIcon),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.seedling, size: _sizeIcon),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.search, size: _sizeIcon),
          label: ''
        ),
        // BottomNavigationBarItem(
        //   icon: Container(
        //     height: SizeConfig.sizeByPixel(45.0),
        //     width: SizeConfig.sizeByPixel(45.0),
        //     child: FittedBox(
        //       child: FloatingActionButton(
        //         onPressed: () {
        //           widget.onTap(DefaultMenuEnum.Search);
        //         },
        //         child: Image.asset(
        //           'assets/icons/icon.png',
        //           fit: BoxFit.fill,
        //         ),
        //         elevation: 2.0,
        //         backgroundColor: Theme.of(context).primaryColor,
        //       ),
        //     ),
        //   ),
        //   title: SizedBox.shrink(),
        // ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.bell, size: _sizeIcon),
          label: ''
        ),
        BottomNavigationBarItem(
          icon: Icon(AppIcons.user, size: _sizeIcon),
          label: ''
        ),
      ],
    );
  }
}
