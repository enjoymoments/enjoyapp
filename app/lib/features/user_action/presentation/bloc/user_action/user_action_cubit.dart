import 'package:mozin/features/user_action/domain/repositories/user_action_repository.dart';
import 'package:custom_utilities/custom_utilities.dart';

part 'user_action_state.dart';

class UserActionCubit extends Cubit<UserActionState> {
  UserActionCubit({
    required UserActionRepository userActionRepository,
  })  : assert(userActionRepository != null),
        _userActionRepository = userActionRepository,
        super(UserActionState.initial());

  final UserActionRepository _userActionRepository;
}
