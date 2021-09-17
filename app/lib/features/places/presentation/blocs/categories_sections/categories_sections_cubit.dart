import 'package:bloc/bloc.dart';
import 'package:mozin/features/places/data/models/session_model.dart';
import 'package:mozin/features/places/presentation/blocs/categories_sections/categories_sections_state.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class CategoriesSectionsCubit extends Cubit<CategoriesSectionsState> {
  CategoriesSectionsCubit() : super(CategoriesSectionsState.initial());
  void loadPrimary(bool loadSessions) {
    var _result = loadSessions ? _loadSessions() : <SessionModel>[];

    emit(
      state.copyWith(
        sessions: _result,
      ),
    );
  }

  void selectedSession(SessionModel item) {
    List<SessionModel> _list = state.sessions!.map((e) {
      e.selected = e.type == item.type;
      return e;
    }).toList();

    emit(
      state.copyWith(sessions: _list, sessionSelected: item),
    );
  }

  List<SessionModel>? _loadSessions() {
    if (state.sessions!.length == 0) {
      return [
        SessionModel(
            type: InterestEnum.Place, selected: false, text: 'Lugares'),
        SessionModel(
            type: InterestEnum.SuggestedByUsers,
            selected: false,
            text: 'Sugerido'),
      ];
    }

    return state.sessions;
  }
}
