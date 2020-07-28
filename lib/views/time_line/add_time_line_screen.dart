import 'package:flutter/material.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/extension.dart';

class AddTimeLineScreen extends StatefulWidget {
  @override
  _AddTimeLineScreenState createState() => _AddTimeLineScreenState();
}

class _AddTimeLineScreenState extends State<AddTimeLineScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomMenu(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Adicionar'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBody() {
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          "Selecione suas fotos".label(context),
        ],
      ),
    );
  }

  Widget _buildBottomMenu() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.camera_alt),
          title: new Text('Camera'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.camera_roll),
          title: new Text('Galeria'),
        ),
      ],
    );
  }
}
