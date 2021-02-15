import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_activity_cubit/add_activity_cubit.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_calendar_cubit/add_calendar_cubit.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_dialog.dart';
import 'package:mozin/package_view/custom_divider.dart';
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
  Future<TimeOfDay> _selectedTime;
  Future<DateTime> _selectedDate;

  TextEditingController _titleController;
  TextEditingController _descriptionController;

  AddCalendarCubit _addCalendarCubit;
  AddActivityCubit _activityCubit;

  @override
  void initState() {
    _addCalendarCubit = getItInstance<AddCalendarCubit>();
    _activityCubit = getItInstance<AddActivityCubit>()..getActivities();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    _titleController.addListener(() {});
    _descriptionController.addListener(() {});

    super.initState();
  }

  @override
  void dispose() {
    _addCalendarCubit.close();
    _activityCubit.close();

    _titleController.dispose();
    _descriptionController.dispose();

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
          onPressed: () {},
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
        if (state.isError) {
          consumerContext.showSnackBar(
              state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        }

        if (state.isSuccess) {
          //TODO:calendar reload here
          //getItInstance<TimelineBloc>()..add(LoadPosts());
          ExtendedNavigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return _buildContent(state);
      },
    );
  }

  Widget _buildContent(AddCalendarState state) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTextFormField(
              controller: _titleController,
              textInputType: TextInputType.text,
              hintText: 'Título do evento',
              labelText: 'Título do evento',
              maxLines: 1,
              validate: (String value) {
                if (value == null || value == "") {
                  return 'Informe o título';
                }

                return null;
              },
            ),
            SpacerBox.v16,
            CustomTextFormField(
              controller: _descriptionController,
              textInputType: TextInputType.text,
              hintText: 'Descrição do evento',
              labelText: 'Descrição do evento',
              maxLines: 4,
              validate: (String value) {
                if (value == null || value == "") {
                  return 'Informe a descrição';
                }

                return null;
              },
            ),
            SpacerBox.v34,
            CustomTile(
              iconStart: AppIcons.calendar_day,
              iconEnd: AppIcons.angle_right,
              title: "Data",
              description: "12/08/1994",
              onTap: () {
                _selectedDate = showDatePicker(
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
            CustomDivider(),
            SpacerBox.v16,
            CustomTile(
              iconStart: AppIcons.clock,
              iconEnd: AppIcons.angle_right,
              title: "Hora",
              description: "21:00",
              onTap: () {
                _selectedTime = showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
              },
            ),
            SpacerBox.v16,
            CustomDivider(),
            SpacerBox.v16,
            CustomTile(
              iconStart: AppIcons.tasks,
              iconEnd: AppIcons.angle_right,
              title: "Atividades",
              description:
                  "Escolha aqui quais tipos de atividades pretende realizar",
              onTap: () {
                ExtendedNavigator.of(context).push(
                  Routes.add_activity,
                  arguments: AddActivityScreenArguments(
                    addCalendarCubit: _addCalendarCubit,
                    activityCubit: _activityCubit,
                  ),
                );
              },
            ),
            SpacerBox.v16,
            CustomDivider(),
          ],
        ),
      ),
    );
  }
}
