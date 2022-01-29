import 'package:bloc/bloc.dart';
import 'package:mozin/features/feedback/data/models/feedback_model.dart';
import 'package:mozin/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit({
    required FeedbackRepository feedbackRepository,
    required UserWrapper userWrapper,
  })  : assert(feedbackRepository != null),
        _feedbackRepository = feedbackRepository,
        assert(userWrapper != null),
        _userWrapper = userWrapper,
        super(FeedbackState.initial());

  final FeedbackRepository _feedbackRepository;
  final UserWrapper _userWrapper;

  void save(FeedbackModel model) async {
    if (model.description == null || model.description == "") {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Informe uma descrição',
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ));
      return;
    }

    if (model.feedbackType == null || model.feedbackType == 0) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Selecione o motivo',
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ));
      return;
    }

    var _user = _userWrapper.getUser;
    model.userEmail = _user == UserAppModel.empty() ? null : _user!.email;

    var _response = await _feedbackRepository.addFeedback(model);

    _response.fold(
      (value) {
        emit(
          state.copyWith(
            isError: false,
            isSuccess: true,
            forceRefresh: StateUtils.generateRandomNumber() as int?,
          ),
        );
      },
      (error) {
        emit(
          state.copyWith(
            isError: true,
            isSuccess: false,
            errorMessage: 'Ops... houve um erro. Tente novamente!',
            forceRefresh: StateUtils.generateRandomNumber() as int?,
          ),
        );
      },
    );
  }
}
