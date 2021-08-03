import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/calendar/data/models/task_calendar_model.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_activity_cubit/add_activity_cubit.dart';
import 'package:mozin/features/calendar/presentation/blocs/add_calendar_cubit/add_calendar_cubit.dart';
import 'package:mozin/features/calendar/presentation/blocs/cubit/calendar_cubit.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_app_bar.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_divider.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_item_modal_fit.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_modal_fit.dart';
import 'package:custom_view/custom_scaffold.dart';
import 'package:custom_view/custom_text_form_field.dart';
import 'package:custom_view/custom_tile.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:mozin/modules/shared/core_migrate/extension_utils.dart';
import 'package:mozin/modules/shared/custom_view_migrate/rounded_loading_button.dart';
import 'package:custom_view/spacer_box.dart';

class AddCalendarScreen extends StatefulWidget {
  final TaskCalendarModel taskModel;

  const AddCalendarScreen({Key key, this.taskModel}) : super(key: key);

  @override
  _AddCalendarScreenState createState() => _AddCalendarScreenState();
}

class _AddCalendarScreenState extends State<AddCalendarScreen> {
  TimeOfDay _selectedTime;
  DateTime _selectedDate;

  TextEditingController _titleController;
  TextEditingController _descriptionController;
  RoundedLoadingButtonController _actionButtoncontroller;

  AddCalendarCubit _addCalendarCubit;
  AddActivityCubit _activityCubit;

  bool get isNewItem => widget.taskModel == null;

  @override
  void initState() {
    _addCalendarCubit = getItInstance<AddCalendarCubit>();
    _activityCubit = getItInstance<AddActivityCubit>()
      ..getActivities();

    _actionButtoncontroller = RoundedLoadingButtonController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    _initValues();

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

  void _initValues() {
    if (!isNewItem) {
      _addCalendarCubit.setModel(
        taskId: widget.taskModel.taskId,
        title: widget.taskModel.title,
        description: widget.taskModel.description,
        datetime: widget.taskModel.dateTime,
        activities: widget.taskModel.activities,
      );

      _titleController.text = widget.taskModel.title;
      _descriptionController.text = widget.taskModel.description;
    }
  }

  void save() {
    final DateTime _datetimeFormatted = _selectedDate != null
        ? _selectedDate.setTimeOfDay(_selectedTime)
        : null;

    _addCalendarCubit.setModel(
      title: _titleController.text,
      description: _descriptionController.text,
      datetime: _datetimeFormatted,
    );

    _addCalendarCubit.save();
  }

  void remove() {
    showMaterialModalBottomSheet(
      context: context,
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
              _addCalendarCubit.remove();
            },
          ),
        ],
      ),
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
              ExtendedNavigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Criar evento',
      context: context,
      onPressedBack: () {
        if (isNewItem &&
            ((_titleController.text != null &&
                    _titleController.text.isNotEmpty) ||
                (_descriptionController.text != null &&
                    _descriptionController.text.isNotEmpty))) {
          _discardPost(context);
        } else {
          ExtendedNavigator.of(context).pop();
        }
      },
      actions: <Widget>[
        _buildActionButton(),
      ],
    );
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
        callback();
      },
    );
  }

  Widget _buildBody() {
    return BlocConsumer<AddCalendarCubit, AddCalendarState>(
      cubit: _addCalendarCubit,
      listener: (consumerContext, state) {
        _actionButtoncontroller.stop();

        if (state.isError) {
          consumerContext.showSnackBar(
              state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        }

        if (state.isSuccess) {
          getItInstance<CalendarCubit>()..loadTasks();
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
              validate: (String value) => null,
            ),
            SpacerBox.v16,
            CustomTextFormField(
              controller: _descriptionController,
              textInputType: TextInputType.text,
              hintText: 'Descrição do evento',
              labelText: 'Descrição do evento',
              maxLines: 4,
              validate: (String value) => null,
            ),
            SpacerBox.v34,
            CustomTile(
              iconStart: AppIcons.calendar_day,
              iconEnd: AppIcons.angle_right,
              title: "Data",
              description: state.model.dateTime.dateOnlyFormat(),
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: state.model.dateTime,
                  firstDate: DateTime(1940, 1, 1),
                  lastDate: DateTime.now().add(
                    Duration(days: 365),
                  ),
                ).then((value) {
                  _selectedDate = _selectedTime != null
                      ? value.setTimeOfDay(_selectedTime)
                      : value;
                  _addCalendarCubit.setModel(
                    datetime: _selectedDate,
                  );
                });
              },
            ),
            SpacerBox.v16,
            CustomDivider(),
            SpacerBox.v16,
            CustomTile(
              iconStart: AppIcons.clock,
              iconEnd: AppIcons.angle_right,
              title: "Hora",
              description: state.model.dateTime.formattedHourMinute(),
              onTap: () {
                showTimePicker(
                  context: context,
                  initialTime: state.model.dateTime.timeOfDayFromDateTime(),
                ).then((value) {
                  _selectedTime = value;
                  _addCalendarCubit.setModel(
                    datetime: state.model.dateTime.setTimeOfDay(value),
                  );
                });
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
                _activityCubit.setSeleted(widget.taskModel?.activities);
                ExtendedNavigator.of(context).push(
                  Routes.add_activity_screen,
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
