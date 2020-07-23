import 'package:flutter/material.dart';

class DefaultMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0, // this will be set when a new tab is tapped
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
