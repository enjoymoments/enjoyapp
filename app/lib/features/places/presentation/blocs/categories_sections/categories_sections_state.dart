

import 'package:mozin/features/places/data/models/session_model.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

class CategoriesSectionsState extends DefaultState {
  CategoriesSectionsState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.sessions,
    this.sessionSelected,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<SessionModel>? sessions;
  final SessionModel? sessionSelected;
  
  factory CategoriesSectionsState.initial() {
    return CategoriesSectionsState(
      isLoading: false,
      isSuccess: false,
      isEmpty: false,
      isError: false,
      errorMessage: null,
      sessions: [],
      sessionSelected: null,
    );
  }

  CategoriesSectionsState copyWith({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    List<SessionModel>? sessions,
    SessionModel? sessionSelected,
  }) {
    return CategoriesSectionsState(
      isLoading: isLoading ?? this.isLoading,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      sessions: sessions ?? this.sessions,
      sessionSelected: sessionSelected ?? this.sessionSelected,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isEmpty,
        isError,
        isSuccess,
        errorMessage,
        sessions,
        sessionSelected
      ];
}
