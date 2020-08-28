import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/modules/shared/models/gallery_image_model.dart';
import 'package:mozin/setup.dart';
import 'package:mozin/views/shared/custom_circular_progress_indicador.dart';
import 'package:mozin/views/shared/custom_container.dart';
import 'package:mozin/views/shared/custom_scaffold.dart';
import 'package:mozin/views/shared/extension.dart';
import 'package:mozin/views/time_line/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:mozin/views/time_line/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/views/time_line/components/image_items.dart';

class AddTimeLineScreen extends StatefulWidget {
  @override
  _AddTimeLineScreenState createState() => _AddTimeLineScreenState();
}

class _AddTimeLineScreenState extends State<AddTimeLineScreen> {
  AddTimeLineBloc _addTimeLineBloc;
  int _currentIndex = 0;
  List<GalleryImageModel> _images;

  @override
  void initState() {
    _images = [];
    _addTimeLineBloc = getItInstance<AddTimeLineBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _addTimeLineBloc.close();
    super.dispose();
  }

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
          onPressed: () {
            if (_images.length > 0) {
              _addTimeLineBloc.add(SaveTimeLine(_images));
            }
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddTimeLineBloc, AddTimeLineState>(
      cubit: _addTimeLineBloc,
      listener: (consumerContext, state) {
        if (state.isFailure) {
          consumerContext.showSnackBar('Ops, houve um erro. Tente novamente');
        }

        if (state.isSuccess) {
          getItInstance<TimelineBloc>()..add(LoadPosts());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return CustomCircularProgressIndicator();
        }

        if (state.images != null && state.images.length > 0) {
          _images = state.images;
          return _buildContent(
            ImageItems(
              addTimeLineBloc: _addTimeLineBloc,
              images: state.images,
            ),
          );
        }

        return _buildContent(
          SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildContent(Widget images) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            "Selecione suas fotos".label(context),
            images,
          ],
        ),
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

        _addTimeLineBloc.add(OpenMediaEvent(ImageSource.values[index]));
      },
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.camera_alt),
          title: new Text('Câmera'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.camera_roll),
          title: new Text('Galeria'),
        ),
      ],
    );
  }
}
