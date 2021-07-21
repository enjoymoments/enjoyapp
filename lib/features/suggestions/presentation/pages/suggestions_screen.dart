import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/suggestions/presentation/bloc/suggestions_cubit.dart';
import 'package:mozin/features/suggestions/presentation/pages/widgets/suggestion_item.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/package_view/custom_app_bar.dart';
import 'package:mozin/package_view/custom_container.dart';
import 'package:mozin/package_view/custom_divider.dart';
import 'package:mozin/package_view/custom_scaffold.dart';
import 'package:mozin/package_view/extension.dart';
import 'package:mozin/package_view/spacer_box.dart';

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
    _suggestionsCubit = getItInstance<SuggestionsCubit>();
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
        child: BlocBuilder<SuggestionsCubit, SuggestionsState>(
          cubit: _suggestionsCubit,
          builder: (BuildContext context, SuggestionsState state) {
            return ListView.separated(
              separatorBuilder: (context, index) => _buildSeparator(),
              itemCount: 20,
              itemBuilder: (context, index) => SuggestionItem(),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Sugestões',
      context: context,
      onPressedBack: () => ExtendedNavigator.of(context).pop(),
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
