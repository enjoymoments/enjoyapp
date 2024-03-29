import 'package:auto_route/auto_route.dart';
import 'package:custom_view/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:mozin/features/suggestions/presentation/bloc/suggestions_cubit.dart';
import 'package:mozin/features/suggestions/presentation/pages/widgets/suggestion_category_item_details.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/custom_view_migrate/rounded_loading_button.dart';

class AddSuggestionScreen extends StatefulWidget {
  const AddSuggestionScreen({Key? key}) : super(key: key);

  @override
  _AddSuggestionScreenState createState() => _AddSuggestionScreenState();
}

class _AddSuggestionScreenState extends State<AddSuggestionScreen> {
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  TextEditingController? _urlController;

  RoundedLoadingButtonController? _actionButtoncontroller;
  SuggestionsCubit? _suggestionsCubit;

  @override
  void initState() {
    _suggestionsCubit = getItInstance<SuggestionsCubit>()..loadCategories();

    _actionButtoncontroller = RoundedLoadingButtonController();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _urlController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _suggestionsCubit!.close();
    _titleController!.dispose();
    _descriptionController!.dispose();
    _urlController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar() as AppBar,
      bottomNavigationBar: null,
    );
  }

  Widget _buildBody() {
    return BlocConsumer<SuggestionsCubit, SuggestionsState>(
      bloc: _suggestionsCubit,
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
              textInputType: TextInputType.text,
              hintText: 'Título',
              labelText: 'Título',
              maxLines: 1,
              validate: (String? value) {},
            ),
            SpacerBox.v16,
            CustomTextFormField(
              controller: _descriptionController,
              textInputType: TextInputType.text,
              hintText: 'Descrição',
              labelText: 'Descrição',
              maxLines: 10,
              validate: (String? value) {},
            ),
            SpacerBox.v16,
            CustomUrlFormField(
              controller: _urlController,
              validate: (String? value) {},
            ),
            SpacerBox.v16,
            ..._buildCards(state),
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
        if (_titleController!.text.isNotEmpty) {
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
        color: Theme.of(context).appBarTheme.iconTheme!.color,
      ),
      onPressed: () {
        _save();
      },
    );
  }

  List<Widget> _buildCards(SuggestionsState state) {
    return state.categories.map((element) {
      return SuggestionCategoryItemDetails(
        item: element,
        callbackSelected: (SubCategoriesModel item) {
          _suggestionsCubit!.selectedSubCategorie(element, item);
        },
      );
    }).toList();
  }

  void _save() {
    _suggestionsCubit!.save(_titleController!.text,
        _descriptionController!.text, _urlController!.text);
  }

  void _discardPost(BuildContext context) async {
    showModalBottomSheet(
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
              AutoRouter.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
