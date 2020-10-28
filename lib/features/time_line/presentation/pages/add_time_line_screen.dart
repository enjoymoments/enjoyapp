import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/features/time_line/presentation/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/image_items.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/custom_text_form_field.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class AddTimeLineScreen extends StatefulWidget {
  @override
  _AddTimeLineScreenState createState() => _AddTimeLineScreenState();
}

class _AddTimeLineScreenState extends State<AddTimeLineScreen> {
  TextEditingController _descriptionController;

  AddTimeLineBloc _addTimeLineBloc;
  int _currentIndex = 0;
  List<GalleryImageModel> _images;

  @override
  void initState() {
    _images = [];
    _addTimeLineBloc = getItInstance<AddTimeLineBloc>();
    _descriptionController = TextEditingController();
    _descriptionController.addListener(() {
      _addTimeLineBloc.add(TextPost(_descriptionController.text));
    });

    super.initState();
  }

  @override
  void dispose() {
    _addTimeLineBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: CustomScaffold(
        child: _buildBody(),
        appBar: _buildAppBar(),
        bottomNavigationBar: _buildBottomMenu(),
      ),
      onWillPop: () async {
        if (_images.length > 0 ||
            (_descriptionController.text != null &&
                _descriptionController.text.isNotEmpty)) {
          return false;
        }

        return true;
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Criar publicação'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            if (_images.length > 0 || (_descriptionController.text != null &&
                _descriptionController.text.isNotEmpty)) {
              _addTimeLineBloc.add(SaveTimeLine());
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
        if (state.isError) {
          consumerContext.showSnackBar(
              state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        }

        if (state.isSuccess) {
          getItInstance<TimelineBloc>()..add(LoadPosts());
          ExtendedNavigator.of(context).pop();
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
            CustomTextFormField(
              controller: _descriptionController,
              textInputType: TextInputType.visiblePassword,
              hintText: 'No que você está pensando?',
              labelText: 'No que você está pensando?',
              maxLines: 5,
              validate: (String value) {},
            ),
            SpacerBox.v16,
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
