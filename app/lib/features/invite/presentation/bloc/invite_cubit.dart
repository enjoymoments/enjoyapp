import 'package:dartz/dartz.dart';
import 'package:mozin/features/invite/data/models/user_sync_info_model.dart';
import 'package:mozin/features/invite/domain/repositories/invite_repository.dart';
import 'package:mozin/features/user_action/data/models/user_action_model.dart';
import 'package:mozin/features/user_action/domain/repositories/user_action_repository.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/user/bloc/cubit/user_info_cubit.dart';
import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/modules/shared/general/enums.dart';

part 'invite_state.dart';

class InviteCubit extends Cubit<InviteState> {
  InviteCubit({
    required InviteRepository inviteRepository,
    required UserWrapper userWrapper,
    required ShareService shareService,
    required UserActionRepository userActionRepository,
  })  : assert(userWrapper != null),
        _userWrapper = userWrapper,
        assert(inviteRepository != null),
        _inviteRepository = inviteRepository,
        assert(shareService != null),
        _shareService = shareService,
        assert(userActionRepository != null),
        _userActionRepository = userActionRepository,
        super(InviteState.initial());

  final InviteRepository _inviteRepository;
  final UserWrapper _userWrapper;
  final ShareService _shareService;
  final UserActionRepository _userActionRepository;

  void getUserSyncInfo(String userSyncInfoId) async {
    emit(state.copyWith(
      isLoading: true,
      forceRefresh: StateUtils.generateRandomNumber() as int?,
    ));

    Either<UserSyncInfoModel, Exception> _response =
        await _inviteRepository.getUserSyncInfo(userSyncInfoId);

    _response.fold((model) {
      emit(state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: false,
        userSyncInfoModel: model,
      ));
    }, (error) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        isSuccess: false,
      ));
    });
  }

  void syncUser() async {
    emit(state.copyWith(
      isLoading: true,
      forceRefresh: StateUtils.generateRandomNumber() as int?,
    ));

    Either<ResponseDefaultModel, Exception> _response =
        await _userActionRepository.addUserAction(
      model: UserActionModel(
        notificationType: NotificationTypeEnum.SyncCouple,
        data: state.userSyncInfoModel!.userSyncInfoId,
      ),
    );

    _response.fold((model) {
      if (model.isSuccess!) {
        _userWrapper.setCoupleId(model.data);
      }

      emit(state.copyWith(
        isLoading: false,
        isError: !model.isSuccess!,
        isSuccess: model.isSuccess,
      ));
    }, (error) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        isSuccess: false,
      ));
    });
  }

  void generateShareUrl() async {
    if (state.isLoading!) {
      return;
    }

    //TODO:review this
    getItInstance<UserInfoCubit>().isLoading(true);

    emit(state.copyWith(isLoading: true));

    await Future<void>.delayed(Duration(milliseconds: 750));

    var _shareUrl = await _userWrapper.getShareUrl();
    if (_shareUrl != null) {
      _shareService.share(_shareUrl);

      //TODO:review this
      getItInstance<UserInfoCubit>().isLoading(false);

      emit(state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: true,
        shareUrl: _shareUrl,
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ));
      return;
    }

    var _internalId = await _userWrapper.getInternalId();
    var response = await _inviteRepository.generateShareUrl(
        DynamicLinksTypeEnum.Sync, _internalId);

    response.fold((model) {
      _userWrapper.setShareUrl(model);
      _shareService.share(model!);

      //TODO:review this
      getItInstance<UserInfoCubit>().isLoading(false);

      emit(state.copyWith(
        isLoading: false,
        isError: false,
        isSuccess: true,
        shareUrl: model,
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ));
    }, (error) {
      //TODO:review this
      getItInstance<UserInfoCubit>().isLoading(false);

      emit(state.copyWith(
        isLoading: false,
        isError: true,
        isSuccess: false,
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ));
    });
  }
}
