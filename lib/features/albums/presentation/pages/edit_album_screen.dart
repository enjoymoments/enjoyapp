import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/albums/data/models/album_item_model.dart';
import 'package:mozin/features/albums/presentation/blocs/edit_album/edit_album_cubit.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/image_items.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/base_image_model.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_item_modal_fit.dart';
import 'package:mozin/package_view/custom_modal_fit.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/custom_text_form_field.dart';
import 'package:mozin/package_view/rounded_loading_button.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class EditAlbumScreen extends StatefulWidget {
  const EditAlbumScreen({Key key, @required this.album}) : super(key: key);

  final AlbumItemModel album;

  @override
  _EditAlbumScreenState createState() => _EditAlbumScreenState();
}

class _EditAlbumScreenState extends State<EditAlbumScreen> {
  TextEditingController _titleController;
  RoundedLoadingButtonController _actionButtoncontroller;

  EditAlbumCubit _editAlbumCubit;
  int _currentIndex = 0;
  List<BaseImageModel> _images;

  bool get readOnlyMode => true;

  @override
  void initState() {
    _editAlbumCubit = getItInstance<EditAlbumCubit>();

    _actionButtoncontroller = RoundedLoadingButtonController();
    _images = [];

    _titleController = TextEditingController();

    initValues();

    super.initState();
  }

  @override
  void dispose() {
    _editAlbumCubit.close();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(),
      bottomNavigationBar: null,
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Criar Álbum',
      context: context,
      onPressedBack: () {
        // if (_images.length > 0 ||
        //     (_titleController.text != null &&
        //         _titleController.text.isNotEmpty)) {
        //   _discardPost(context);
        //   return;
        // }

        Navigator.of(context).pop();
      },
      actions: <Widget>[
        _buildActionButton(),
      ],
    );
  }

  Widget _buildBody() {
    return BlocConsumer<EditAlbumCubit, EditAlbumState>(
      cubit: _editAlbumCubit,
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

  Widget _buildAlbumImages(EditAlbumState state) {
    if (state.album != null && state.album.medias.length > 0) {
      return ImageItems(
        sourceType: SourceTypeEnum.Url,
        onRemoveCallback: (model) {
          _editAlbumCubit.mapRemoveMediaToState(model);
        },
        images: state.album.medias.toGalleryImages(),
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildNewImages(EditAlbumState state) {
    if (state.newImages.length > 0) {
      return ImageItems(
        sourceType: SourceTypeEnum.File,
        onRemoveCallback: (model) {
          _editAlbumCubit.mapRemoveMediaToState(model);
        },
        images: state.newImages,
      );
    }

    return SizedBox.shrink();
  }

  Widget _buildActionButton() {
    if (readOnlyMode) {
      return _buildActionButtonConfig(AppIcons.ellipsis_h, _options);
    }

    return _buildActionButtonConfig(AppIcons.check, _save);
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

  // Widget _buildBottomMenu() {
  //   return BottomNavigationBar(
  //     type: BottomNavigationBarType.fixed,
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //       });

  //       _addAlbumCubit.mapOpenCameraToState(ImageSource.values[index]);
  //     },
  //     items: [
  //       BottomNavigationBarItem(
  //         icon: CustomIcon(icon: AppIcons.camera),
  //         title: new Text('Câmera'),
  //       ),
  //       BottomNavigationBarItem(
  //         icon: CustomIcon(icon: AppIcons.film),
  //         title: new Text('Galeria'),
  //       ),
  //     ],
  //   );
  // }

  void _options() {
    showMaterialModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) => CustomModalFit(
        items: [
          CustomItemModalFit(
            text: 'Editar álbum',
            iconData: AppIcons.edit,
            onTap: () {
              _actionButtoncontroller.stop();
            },
          ),
          CustomItemModalFit(
            text: 'Deletar álbum',
            iconData: AppIcons.trash,
            onTap: () {
              _remove();
            },
          ),
        ],
      ),
    );
  }

  void _remove() {
    showMaterialModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) => CustomModalFit(
        items: [
          CustomItemModalFit(
            text: 'Não quero deletar',
            iconData: AppIcons.ad,
            onTap: () {
              _actionButtoncontroller.stop();
            },
          ),
          CustomItemModalFit(
            text: 'Sim, quero deletar',
            iconData: AppIcons.trash,
            onTap: () {
              _editAlbumCubit.deleteAlbum(widget.album);
            },
          ),
        ],
      ),
    );
  }

  void initValues() {
    _titleController.text = widget.album.titleAlbum;
    _editAlbumCubit.setAlbum(widget.album);
  }

  void _discardPost(BuildContext context) async {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => CustomModalFit(
        items: [
          CustomItemModalFit(
            text: 'Não quero descartar',
            iconData: AppIcons.ad,
            onTap: () {},
          ),
          CustomItemModalFit(
            text: 'Sim, quero descartar',
            iconData: AppIcons.trash,
            onTap: () {
              ExtendedNavigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _save() {
    _editAlbumCubit.mapSaveToState(_titleController.text);
  }
}