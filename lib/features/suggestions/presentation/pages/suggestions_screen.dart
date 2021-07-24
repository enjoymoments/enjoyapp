import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/suggestions/presentation/bloc/suggestions_cubit.dart';
import 'package:mozin/features/suggestions/presentation/pages/widgets/suggestion_item.dart';
import 'package:mozin/features/suggestions/presentation/pages/widgets/suggestion_loading.dart';
import 'package:mozin/modules/config/router.gr.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/AppIcons.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_divider.dart';
import 'package:mozin/package_view/custom_icon.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/spacer_box.dart';
import 'package:mozin/package_view/extension.dart';

class SuggestionsScreen extends StatefulWidget {
  @override
  _SuggestionsScreenState createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  SuggestionsCubit _suggestionsCubit;

  @override
  void initState() {
    _suggestionsCubit = getItInstance<SuggestionsCubit>()..getSuggestions();
    super.initState();
  }

  @override
  void dispose() {
    _suggestionsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: _buildBody(),
      appBar: _buildAppBar(context),
      bottomNavigationBar: null,
    );
  }

  Widget _buildBody() {
    return CustomContainer(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Theme.of(context).primaryColor,
        onRefresh: () async {},
        child: BlocConsumer<SuggestionsCubit, SuggestionsState>(
          cubit: _suggestionsCubit,
          listener: (BuildContext consumerContext, SuggestionsState state) {
            if (state.isError) {
              consumerContext.showSnackBar(
                  state.errorMessage ?? 'Ops, houve um erro. Tente novamente');
            }
          },
          builder: (BuildContext context, SuggestionsState state) {
            if (state.isLoading) {
              return SuggestionLoading();
            }

            if (state.suggestions.length > 0) {
              return ListView.separated(
                separatorBuilder: (context, index) => _buildSeparator(),
                itemCount: state.suggestions.length,
                itemBuilder: (context, index) => SuggestionItem(
                  item: state.suggestions[index],
                ),
              );
            }

            return _buildEmpty();
          },
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: "Ops...\n não encontramos nada".labelIntro(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Sugestões',
      context: context,
      onPressedBack: () => ExtendedNavigator.of(context).pop(),
      actions: [
        IconButton(
          icon: CustomIcon(icon: AppIcons.plus),
          onPressed: () {
            ExtendedNavigator.of(context).push(Routes.add_suggestions_screen);
          },
        ),
      ]
    );
  }

  Widget _buildSeparator() {
    return Column(
      children: [
        SpacerBox.v16,
        CustomDivider(),
        SpacerBox.v16,
      ],
    );
  }
}
