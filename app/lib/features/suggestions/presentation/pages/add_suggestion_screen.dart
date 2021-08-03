import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mozin/features/suggestions/presentation/bloc/suggestions_cubit.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/config/size_config.dart';
import 'package:custom_view/AppIcons.dart';
import 'package:custom_view/custom_app_bar.dart';
import 'package:custom_view/custom_circular_progress_indicador.dart';
import 'package:custom_view/custom_container.dart';
import 'package:custom_view/custom_icon.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_item_modal_fit.dart';
import 'package:mozin/modules/shared/custom_view_migrate/custom_modal_fit.dart';
import 'package:custom_view/custom_scaffold.dart';
import 'package:custom_view/custom_text_form_field.dart';
import 'package:custom_view/spacer_box.dart';
import 'package:custom_view/extensions/extension.dart';
import 'package:mozin/modules/shared/custom_view_migrate/rounded_loading_button.dart';

class AddSuggestionScreen extends StatefulWidget {
  const AddSuggestionScreen({Key key}) : super(key: key);

  @override
  _AddSuggestionScreenState createState() => _AddSuggestionScreenState();
}

class _AddSuggestionScreenState extends State<AddSuggestionScreen> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  RoundedLoadingButtonController _actionButtoncontroller;
  SuggestionsCubit _suggestionsCubit;

  @override
  void initState() {
    _suggestionsCubit = getItInstance<SuggestionsCubit>();

    _actionButtoncontroller = RoundedLoadingButtonController();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _suggestionsCubit.close();
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

  Widget _buildBody() {
    return BlocConsumer<SuggestionsCubit, SuggestionsState>(
      cubit: _suggestionsCubit,
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

  Widget _buildContent(SuggestionsState state) {
    return SingleChildScrollView(
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTextFormField(
              controller: _titleController,
              textInputType: TextInputType.visiblePassword,
              hintText: 'Título',
              labelText: 'Título',
              maxLines: 1,
              validate: (String value) {},
            ),
            SpacerBox.v16,
            CustomTextFormField(
              controller: _descriptionController,
              textInputType: TextInputType.visiblePassword,
              hintText: 'Descrição',
              labelText: 'Descrição',
              maxLines: 10,
              validate: (String value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      title: 'Criar Sugestão',
      context: context,
      onPressedBack: () {
        if (
            _titleController.text != null &&
                _titleController.text.isNotEmpty) {
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

  void _save() {
    _suggestionsCubit.save(_titleController.text, _descriptionController.text);
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
