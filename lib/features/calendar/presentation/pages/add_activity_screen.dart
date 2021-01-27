import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/features/calendar/presentation/cubit/add_calendar_cubit.dart';
import 'package:mozin/features/time_line/presentation/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/image_items.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/modules/shared/general/models/gallery_image_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_circular_progress_indicador.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_dialog.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/custom_text_form_field.dart';
import 'package:mozin/package_view/custom_tile.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

class AddActivityScreen extends StatefulWidget {
  final AddCalendarCubit addCalendarCubit;

  const AddActivityScreen({Key key, @required this.addCalendarCubit})
      : super(key: key);

  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  TextEditingController _descriptionController;
  int _currentIndex = 0;

  @override
  void initState() {
    _descriptionController = TextEditingController();
    _descriptionController.addListener(() {
      //_addTimeLineBloc.add(TextPost(_descriptionController.text));
    });

    super.initState();
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
      title: 'Tipos de atividades',
      iconColors: Theme.of(context).backgroundColor,
      onPressedBack: () {
        ExtendedNavigator.of(context).pop();
      },
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddCalendarCubit, AddCalendarState>(
      cubit: widget.addCalendarCubit,
      listener: (consumerContext, state) {
        // if (state.isError) {
        //   consumerContext.showSnackBar(
        //       state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        // }

        // if (state.isSuccess) {
        //   getItInstance<TimelineBloc>()..add(LoadPosts());
        //   ExtendedNavigator.of(context).pop();
        // }
      },
      builder: (context, state) {
        // if (state.isLoading) {
        //   return CustomCircularProgressIndicator();
        // }

        // if (state.images != null && state.images.length > 0) {
        //   _images = state.images;
        //   return _buildContent(
        //     ImageItems(
        //       addTimeLineBloc: _addTimeLineBloc,
        //       images: state.images,
        //     ),
        //   );
        // }

        return _buildContent();
      },
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSection(),
            SpacerBox.v34,
            _buildSection(),
            SpacerBox.v34,
            _buildSection(),
            SpacerBox.v34,
          ],
        ),
      ),
    );
  }

  Widget _buildSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Lazer".label(context),
        Wrap(
          children: [
            _buildIcon(),
            SpacerBox.h16,
            _buildIcon(),
            SpacerBox.h16,
            _buildIcon(),
            SpacerBox.h16,
            _buildIcon(),
            SpacerBox.h16,
            _buildIcon(),
            SpacerBox.h16,
            _buildIcon(),
            SpacerBox.h16,
            _buildIcon(),
          ],
        ),
      ],
    );
  }

  //TODO:review this - create widget
  Widget _buildIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpacerBox.v8,
        Container(
          width: SizeConfig.sizeByPixel(50.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          child: IconButton(
            icon: Icon(AppIcons.google, color: Theme.of(context).primaryColor),
            onPressed: () {},
          ),
        ),
        "Atividade".description(context),
      ],
    );
  }
}
