import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/features/albums/presentation/blocs/add_album/add_album_cubit.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/image_items.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/base_image_model.dart';
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
  const AddAlbumsScreen({Key key, this.album}) : super(key: key);

  final AlbumItemModel album;

  @override
  _AddAlbumsScreenState createState() => _AddAlbumsScreenState();
}

class _AddAlbumsScreenState extends State<AddAlbumsScreen> {
  TextEditingController _titleController;
  RoundedLoadingButtonController _actionButtoncontroller;

  AddAlbumCubit _addAlbumCubit;
  int _currentIndex = 0;
  List<BaseImageModel> _images;

  bool get isNewItem => widget.album == null;

  @override
  void initState() {
    _addAlbumCubit = getItInstance<AddAlbumCubit>();

    _actionButtoncontroller = RoundedLoadingButtonController();
    _images = [];

    _titleController = TextEditingController();

    initValues();

    super.initState();
  }

  @override
  void dispose() {
    _addAlbumCubit.close();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(),
      bottomNavigationBar: isNewItem ? _buildBottomMenu() : null,
    );
  }

  void initValues() {
    if (!isNewItem) {
      _titleController.text = widget.album.titleAlbum;
      _addAlbumCubit.setAlbum(widget.album);
    }
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Criar Álbum',
      context: context,
      onPressedBack: () {
        if (isNewItem &&
            (_images.length > 0 ||
                (_titleController.text != null &&
                    _titleController.text.isNotEmpty))) {
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
        _actionButtoncontroller.stop();

        if (state.isError) {
          consumerContext.showSnackBar(
              state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        }

        if (state.isSuccess) {
          ExtendedNavigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return CustomCircularProgressIndicator();
        }

        if (state.allImages != null && state.allImages.length > 0) {
          _images = state.allImages;
          return _buildContent(
            Column(
              children: [
                _buildAlbumImages(state),
                _buildNewImages(state),
              ],
            ),
          );
        }

        return _buildContent(
          SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildAlbumImages(AddAlbumState state) {
    if (state.album != null && state.album.medias.length > 0) {
      return ImageItems(
        sourceType: SourceTypeEnum.Url,
        onRemoveCallback: (model) {
          _addAlbumCubit.mapRemoveMediaToState(model);
        },
        images: state.album.medias.toGalleryImages(),
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildNewImages(AddAlbumState state) {
    if (state.newImages.length > 0) {
      return ImageItems(
        sourceType: SourceTypeEnum.File,
        onRemoveCallback: (model) {
          _addAlbumCubit.mapRemoveMediaToState(model);
        },
        images: state.newImages,
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildActionButton() {
    if (!isNewItem) {
      return _buildActionButtonConfig(AppIcons.trash, remove);
    }

    return _buildActionButtonConfig(AppIcons.check, save);
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
        if (_images.length > 0 ||
            (_titleController.text != null &&
                _titleController.text.isNotEmpty)) {
          callback();
        }
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
              controller: _titleController,
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

  void remove() {
    var content = Text('Deseja excluir?');

    var actions = [
      FlatButton(
        child: Text(
          'Não',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onPressed: () {
          _actionButtoncontroller.stop();
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
          //_addCalendarCubit.remove();
        },
      ),
    ];

    simpleDialog(context, 'Remover', content, false, actions);
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

  void save() {
    _addAlbumCubit.mapSaveToState(_titleController.text);
  }
}
