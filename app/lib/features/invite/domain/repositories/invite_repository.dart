import 'package:dartz/dartz.dart';
import 'package:mozin/features/invite/data/models/user_sync_info_model.dart';
import 'package:mozin/modules/shared/general/enums.dart';

abstract class InviteRepository {
  Future<Either<String, Exception>> generateShareUrl(DynamicLinksTypeEnum action, String userInternalId);
  Future<Either<UserSyncInfoModel, Exception>> getUserSyncInfo(String userSyncInfoId);
}
