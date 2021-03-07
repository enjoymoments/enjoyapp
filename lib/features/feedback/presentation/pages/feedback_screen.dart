import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/feedback/data/models/feedback_model.dart';
import 'package:mozin/features/feedback/presentation/cubit/feedback_cubit.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/custom_text_form_field.dart';
import 'package:mozin/package_view/rounded_loading_button.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

enum _FeedbackType { initial, bug, improvement }

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  FeedbackCubit _feedbackCubit;
  RoundedLoadingButtonController _actionButtoncontroller;
  TextEditingController _descriptionController;

  _FeedbackType _feedbackType = _FeedbackType.initial;

  @override
  void initState() {
    super.initState();
    _actionButtoncontroller = RoundedLoadingButtonController();
    _descriptionController = TextEditingController();

    _feedbackCubit = getItInstance<FeedbackCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    _feedbackCubit.close();
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
      title: 'Ajude-nos a melhorar o app',
      iconColors: Theme.of(context).backgroundColor,
      onPressedBack: () {
        Navigator.of(context).pop();
      },
      actions: [
        _buildActionButtonConfig(),
      ],
    );
  }

  Widget _buildBody() {
    return BlocConsumer<FeedbackCubit, FeedbackState>(
      cubit: _feedbackCubit,
      listener: (consumerContext, state) {
        _actionButtoncontroller.stop();

        if (state.isError) {
          consumerContext.showSnackBar(
              state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
        }

        if (state.isSuccess) {
          ExtendedNavigator.of(context).popAndPush(Routes.success_screen);
        }
      },
      builder: (context, state) {
        return _buildContent();
      },
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          children: [
            _CustomTile(
              selected: _feedbackType == _FeedbackType.bug,
              title: 'Quero relatar um problema',
              description: 'bla bla bla',
              iconStart: AppIcons.bug,
              onTap: (selected) {
                setState(() {
                  _feedbackType = _FeedbackType.bug;
                });
              },
            ),
            SpacerBox.v16,
            _CustomTile(
              selected: _feedbackType == _FeedbackType.improvement,
              title: 'Tenho uma sugestão ou elogio',
              description: 'bla bla bla',
              iconStart: AppIcons.star,
              onTap: (selected) {
                setState(() {
                  _feedbackType = _FeedbackType.improvement;
                });
              },
            ),
            SpacerBox.v16,
            CustomTextFormField(
              controller: _descriptionController,
              textInputType: TextInputType.text,
              hintText: 'Diga lá',
              labelText: 'Diga lá',
              maxLines: 18,
              validate: (String value) => null,
            ),
          ],
        ),
      ),
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
        _actionButtoncontroller.start();
        save();
      },
    );
  }

  void save() {
    _feedbackCubit.save(FeedbackModel(
      description: _descriptionController.text,
      feedbackType: _feedbackType.index,
    ));
  }
}

class _CustomTile extends StatelessWidget {
  final bool selected;
  final IconData iconStart;
  final String title;
  final String description;
  final Function(bool) onTap;

  const _CustomTile({
    Key key,
    @required this.selected,
    @required this.iconStart,
    @required this.title,
    @required this.description,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(!selected);
      },
      child: Row(
        children: [
          CustomIcon(
            icon: iconStart,
            color: _getSelectedColor(context),
          ),
          SpacerBox.h16,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.label(
                  context,
                  color: _getSelectedColor(context),
                ),
                description.description(
                  context,
                  color: _getSelectedColor(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getSelectedColor(BuildContext context) {
    if (selected) {
      return Theme.of(context).primaryColor;
    }

    return Theme.of(context).textTheme.headline5.color;
  }
}
