import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_calendar_cubit/add_calendar_cubit.dart';
import 'package:mozin/features/time_line/presentation/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/features/time_line/presentation/pages/widgets/image_items.dart';
import 'package:mozin/modules/config/router.gr.dart';
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

class AddCalendarScreen extends StatefulWidget {
  @override
  _AddCalendarScreenState createState() => _AddCalendarScreenState();
}

class _AddCalendarScreenState extends State<AddCalendarScreen> {
  TextEditingController _descriptionController;

  AddCalendarCubit _addCalendarCubit;
  int _currentIndex = 0;

  @override
  void initState() {
    _addCalendarCubit = getItInstance<AddCalendarCubit>();
    _descriptionController = TextEditingController();
    _descriptionController.addListener(() {
      //_addTimeLineBloc.add(TextPost(_descriptionController.text));
    });

    super.initState();
  }

  @override
  void dispose() {
    _addCalendarCubit.close();
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
      title: 'Criar evento',
      iconColors: Theme.of(context).backgroundColor,
      onPressedBack: () {
        _discardPost(context);
      },
      actions: <Widget>[
        IconButton(
          icon: CustomIcon(icon: AppIcons.check),
          onPressed: () {
            // if (_images.length > 0 ||
            //     (_descriptionController.text != null &&
            //         _descriptionController.text.isNotEmpty)) {
            //   _addTimeLineBloc.add(SaveTimeLine());
            // }
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
    return BlocConsumer<AddCalendarCubit, AddCalendarState>(
      cubit: _addCalendarCubit,
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
            CustomTextFormField(
              controller: _descriptionController,
              textInputType: TextInputType.text,
              hintText: 'Título do evento',
              labelText: 'Título do evento',
              maxLines: 1,
              validate: (String value) {},
            ),
            SpacerBox.v34,
            CustomTile(
              iconStart: AppIcons.calendar_day,
              iconEnd: AppIcons.angle_right,
              title: "Data",
              description: "12/08/1994",
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime(1994, 8, 12),
                  firstDate: DateTime(1940, 1, 1),
                  lastDate: DateTime.now().add(
                    Duration(days: 30),
                  ),
                );
              },
            ),
            SpacerBox.v16,
            Divider(
              color: Theme.of(context).hintColor,
              height: SizeConfig.sizeByPixel(4),
            ),
            SpacerBox.v16,
            CustomTile(
              iconStart: AppIcons.clock,
              iconEnd: AppIcons.angle_right,
              title: "Hora",
              description: "21:00",
              onTap: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now());
              },
            ),
            SpacerBox.v16,
            Divider(
              color: Theme.of(context).hintColor,
              height: SizeConfig.sizeByPixel(4),
            ),
            SpacerBox.v16,
            CustomTile(
              iconStart: AppIcons.tasks,
              iconEnd: AppIcons.angle_right,
              title: "Atividades",
              description:
                  "Escolha aqui quais tipos de atividades pretende realizar",
              onTap: () {
                ExtendedNavigator.of(context)
                            .push(Routes.add_activity,arguments: AddActivityScreenArguments(addCalendarCubit: _addCalendarCubit));
              },
            ),
            SpacerBox.v16,
            Divider(
              color: Theme.of(context).hintColor,
              height: SizeConfig.sizeByPixel(4),
            ),
          ],
        ),
      ),
    );
  }
}
