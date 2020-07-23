import 'package:flutter/material.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Mozin'),
          Row(
            children: <Widget>[],
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return CustomContainer(
      child: Text('Teste'),
    );
  }
}
