import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_item_modal_fit.dart';
import 'package:mozin/package_view/custom_modal_fit.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/custom_text_form_field.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/rounded_loading_button.dart';

class AddAlbumScreen extends StatefulWidget {
  const AddAlbumScreen({Key key}) : super(key: key);

  @override
  _AddAlbumScreenState createState() => _AddAlbumScreenState();
}

class _AddAlbumScreenState extends State<AddAlbumScreen> {
  TextEditingController _titleController;
  RoundedLoadingButtonController _actionButtoncontroller;
  AddAlbumCubit _addAlbumCubit;
  List<BaseImageModel> _images;
  int _currentIndex = 0;

  @override
  void initState() {
    _addAlbumCubit = getItInstance<AddAlbumCubit>();

    _actionButtoncontroller = RoundedLoadingButtonController();

    _images = [];

    _titleController = TextEditingController();

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
      bottomNavigationBar: _buildBottomMenu(),
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

        return _buildContent(state);
      },
    );
  }

  Widget _buildContent(AddAlbumState state) {
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
            _buildNewImages(state),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Criar Álbum',
      context: context,
      onPressedBack: () {
        if (_images.length > 0 ||
            (_titleController.text != null &&
                _titleController.text.isNotEmpty)) {
          _discardPost(context);
          return;
        }

        Navigator.of(context).pop();
      },
      actions: <Widget>[
        _buildActionButtonConfig(),
      ],
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
          title: 'Câmera'.iconWithLabel(context),
        ),
        BottomNavigationBarItem(
          icon: CustomIcon(icon: AppIcons.film),
          title: 'Galeria'.iconWithLabel(context),
        ),
      ],
    );
  }

  Widget _buildActionButtonConfig() {
    return RoundedLoadingButton(
      width: SizeConfig.sizeByPixel(50),
      controller: _actionButtoncontroller,
      child: CustomIcon(
        icon: AppIcons.check,
        color: Theme.of(context).appBarTheme.iconTheme.color,
      ),
      onPressed: () {
        _save();
      },
    );
  }

  Widget _buildNewImages(AddAlbumState state) {
    if (state.allImages.length > 0) {
      return ImageItems(
        sourceType: SourceTypeEnum.File,
        onRemoveCallback: (model) {
          _addAlbumCubit.mapRemoveMediaToState(model);
        },
        images: state.allImages,
      );
    }

    return SizedBox.shrink();
  }

  void _save() {
    _addAlbumCubit.mapSaveToState(_titleController.text);
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
}
