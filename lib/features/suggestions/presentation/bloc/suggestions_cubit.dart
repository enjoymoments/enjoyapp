import 'package:bloc/bloc.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'suggestions_state.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit() : super(SuggestionsState.initial());
}
