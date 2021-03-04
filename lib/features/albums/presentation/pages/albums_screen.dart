import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/albums/presentation/bloc/albums_bloc.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_dialog.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/custom_text_form_field.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  
  TextEditingController _descriptionController;

  AlbumsCubit _albumsCubit;
  int _currentIndex = 0;
  List<GalleryImageModel> _images;

  @override
  void initState() {
    _images = [];
    _albumsCubit = getItInstance<AlbumsCubit>();
    _descriptionController = TextEditingController();
    _descriptionController.addListener(() {
      //_addTimeLineBloc.add(TextPost(_descriptionController.text));
    });

    super.initState();
  }

  @override
  void dispose() {
    _albumsCubit.close();
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

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Todos os álbums',
      iconColors: Theme.of(context).backgroundColor,
      onPressedBack: () {
        if (_images.length > 0 ||
            (_descriptionController.text != null &&
                _descriptionController.text.isNotEmpty)) {
          _discardPost(context);
          return;
        }

        Navigator.of(context).pop();
      },
      actions: <Widget>[
        IconButton(
          icon: CustomIcon(icon: AppIcons.plus),
          onPressed: () {
            if (_images.length > 0 ||
                (_descriptionController.text != null &&
                    _descriptionController.text.isNotEmpty)) {
              //_addTimeLineBloc.add(SaveTimeLine());
            }
          },
        ),
      ],
    );
  }

  void _discardPost(BuildContext context) async {
    var content = Text('Deseja descartar?');

    var actions = [
      FlatButton(
        child: Text(
          'Não',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          ExtendedNavigator.of(context).pop();
        },
      ),
      FlatButton(
        child: Text(
          'Sim',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          ExtendedNavigator.of(context).pop();
          ExtendedNavigator.of(context).pop();
        },
      ),
    ];

    simpleDialog(context, 'Remover', content, true, actions);
  }

  Widget _buildBody() {
    return BlocConsumer<AlbumsCubit, AlbumsState>(
      cubit: _albumsCubit,
      listener: (consumerContext, state) {
        if (state.isError) {
          consumerContext.showSnackBar(
              state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        }

        if (state.isSuccess) {
          //getItInstance<TimelineBloc>()..add(LoadPosts());
          ExtendedNavigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return CustomCircularProgressIndicator();
        }

        // if (state.images != null && state.images.length > 0) {
        //   _images = state.images;
        //   return _buildContent(
        //     ImageItems(
        //       addTimeLineBloc: _addTimeLineBloc,
        //       images: state.images,
        //     ),
        //   );
        // }

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

        //_addTimeLineBloc.add(OpenMediaEvent(ImageSource.values[index]));
      },
      items: [
        BottomNavigationBarItem(
          icon: CustomIcon(icon: AppIcons.camera),
          title: new Text('Câmera'),
        ),
        BottomNavigationBarItem(
          icon: CustomIcon(icon: AppIcons.film),
          title: new Text('Galeria'),
        ),
      ],
    );
  }
}


