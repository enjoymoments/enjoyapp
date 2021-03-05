import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/features/albums/presentation/blocs/add_album/add_album_cubit.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/image_items.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
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
import 'package:mozin/package_view/rounded_loading_button.dart';
import 'package:mozin/package_view/spacer_box.dart';

class AddAlbumsScreen extends StatefulWidget {
  @override
  _AddAlbumsScreenState createState() => _AddAlbumsScreenState();
}

class _AddAlbumsScreenState extends State<AddAlbumsScreen> {
  TextEditingController _descriptionController;
  RoundedLoadingButtonController _actionButtoncontroller;

  AddAlbumCubit _addAlbumCubit;
  int _currentIndex = 0;
  List<GalleryImageModel> _images;

  @override
  void initState() {
    _addAlbumCubit = getItInstance<AddAlbumCubit>();

    _actionButtoncontroller = RoundedLoadingButtonController();
    _images = [];

    _descriptionController = TextEditingController();
    _descriptionController.addListener(() {});

    super.initState();
  }

  @override
  void dispose() {
    _addAlbumCubit.close();
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
      title: 'Criar Álbum',
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
        _buildActionButton(),
      ],
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddAlbumCubit, AddAlbumState>(
      cubit: _addAlbumCubit,
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

        if (state.images != null && state.images.length > 0) {
          _images = state.images;
          return _buildContent(
            ImageItems(
              onRemoveCallback: (model) {},
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

  Widget _buildActionButton() {
    // if (widget.taskModel != null) {
    //   return _buildActionButtonConfig(AppIcons.trash, remove);
    // }

    return _buildActionButtonConfig(AppIcons.check, () {});
  }

  Widget _buildActionButtonConfig(IconData icon, void Function() callback) {
    return RoundedLoadingButton(
      width: SizeConfig.sizeByPixel(50),
      controller: _actionButtoncontroller,
      child: CustomIcon(
        icon: icon,
        color: Theme.of(context).appBarTheme.iconTheme.color,
      ),
      onPressed: () {
        _actionButtoncontroller.start();
        callback();
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
              hintText: 'Título do álbum',
              labelText: 'Título do álbum',
              maxLines: 1,
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

        _addAlbumCubit.mapOpenCameraToState(ImageSource.values[index]);
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
}
