import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/shared/custom_circular_progress_indicador.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/time_line/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:mozin/views/time_line/components/image_items.dart';

class AddTimeLineScreen extends StatefulWidget {
  @override
  _AddTimeLineScreenState createState() => _AddTimeLineScreenState();
}

class _AddTimeLineScreenState extends State<AddTimeLineScreen> {
  AddTimeLineBloc _addTimeLineBloc;
  int _currentIndex = 0;

  @override
  void initState() {
    _addTimeLineBloc = getItInstance<AddTimeLineBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: SingleChildScrollView(
        child: _buildBody(),
      ),
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
          _buildImages(),
        ],
      ),
    );
  }

  Widget _buildImages() {
    return BlocBuilder<AddTimeLineBloc, AddTimeLineState>(
      cubit: _addTimeLineBloc,
      builder: (context, state) {
        if (state.isLoading) {
          return CustomCircularProgressIndicator();
        }
        if (state.medias.length > 0) {
          return ImageItems(
            image: state.medias[0],
          );
        }
        return Text('test 2');
      },
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

        _addTimeLineBloc.add(OpenCameraEvent(
            index == 0 ? ImageSource.camera : ImageSource.gallery));
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