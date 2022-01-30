import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/features/more/domain/repositories/more_repository.dart';

part 'more_event.dart';
part 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  MoreBloc({required MoreRepository moreRepository})
      : assert(moreRepository != null),
        _moreRepository = moreRepository,
        super(MoreState.initial());

  final MoreRepository _moreRepository;

  @override
  Stream<MoreState> mapEventToState(
    MoreEvent event,
  ) async* {}
}
