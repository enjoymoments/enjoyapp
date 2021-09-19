import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/time_line/presentation/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:custom_view/size_config.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_image_items.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_item_modal_fit.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_modal_fit.dart';
import 'package:mozin/modules/shared/custom_view_migrate/rounded_loading_button.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_app_bar.dart';
import 'package:custom_view/custom_circular_progress_indicador.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:custom_view/custom_scaffold.dart';
import 'package:custom_view/custom_text_form_field.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:custom_view/spacer_box.dart';

class AddTimeLineScreen extends StatefulWidget {
  @override
  _AddTimeLineScreenState createState() => _AddTimeLineScreenState();
}

class _AddTimeLineScreenState extends State<AddTimeLineScreen> {
  TextEditingController? _descriptionController;
  RoundedLoadingButtonController? _actionButtoncontroller;

  AddTimeLineBloc? _addTimeLineBloc;
  int _currentIndex = 0;
  List<GalleryImageModel>? _images;

  @override
  void initState() {
    _images = [];
    _actionButtoncontroller = RoundedLoadingButtonController();
    _addTimeLineBloc = getItInstance<AddTimeLineBloc>();
    _descriptionController = TextEditingController();
    _descriptionController!.addListener(() {
      _addTimeLineBloc!.add(TextPost(_descriptionController!.text));
    });

    super.initState();
  }

  @override
  void dispose() {
    _addTimeLineBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar() as AppBar,
      bottomNavigationBar: _buildBottomMenu(),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Criar publicação',
      context: context,
      onPressedBack: () {
        if (_images!.length > 0 ||
            (_descriptionController!.text != null &&
                _descriptionController!.text.isNotEmpty)) {
          _discardPost(context);
          return;
        }

        Navigator.of(context).pop();
      },
      actions: <Widget>[
        RoundedLoadingButton(
          width: SizeConfig.sizeByPixel(50),
          controller: _actionButtoncontroller,
          child: CustomIcon(
            icon: AppIcons.check,
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
          onPressed: () {
            if (_images!.length > 0 ||
                (_descriptionController!.text != null &&
                    _descriptionController!.text.isNotEmpty)) {
              _addTimeLineBloc!.add(SaveTimeLine());
            }

            _actionButtoncontroller!.stop();
          },
        ),
      ],
    );
  }

  void _discardPost(BuildContext context) async {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => CustomModalFit(
        items: [
          CustomItemModalFit(
            text: 'Não quero descartar',
            iconData: AppIcons.ad,
            onTap: () {
            },
          ),
          CustomItemModalFit(
            text: 'Sim, quero descartar',
            iconData: AppIcons.trash,
            onTap: () {
              AutoRouter.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddTimeLineBloc, AddTimeLineState>(
      bloc: _addTimeLineBloc,
      listener: (consumerContext, state) {
        _actionButtoncontroller!.stop();

        if (state.isError!) {
          consumerContext.showSnackBar(
              state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        }

        if (state.isSuccess!) {
          AutoRouter.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state.isLoading!) {
          return CustomCircularProgressIndicator();
        }

        if (state.images != null && state.images!.length > 0) {
          _images = state.images;
          return _buildContent(
            CustomImageItems(
              sourceType: SourceTypeEnum.File,
              onRemoveCallback: (model) {
                _removePhoto(context, model);
              },
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
              validate: (String? value) {},
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

        _addTimeLineBloc!.add(OpenMediaEvent(ImageSource.values[index]));
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

  void _removePhoto(BuildContext context, GalleryImageModel model) async {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => CustomModalFit(
        items: [
          CustomItemModalFit(
            text: 'Não quero remover',
            iconData: AppIcons.ad,
            onTap: () {},
          ),
          CustomItemModalFit(
            text: 'Sim, quero remover',
            iconData: AppIcons.trash,
            onTap: () {
              _addTimeLineBloc!.add(RemoveMedia(model));
            },
          ),
        ],
      ),
    );
  }
}
