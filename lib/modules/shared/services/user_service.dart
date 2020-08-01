import 'package:mozin/modules/shared/services/local_storage_service.dart';
import 'package:mozin/modules/shared/models/key_value.dart';
import 'package:mozin/modules/shared/models/user_model.dart';
import 'package:mozin/setup.dart';
import 'package:uuid/uuid.dart';

class UserService {
  final UserModel userModel;
  final LocalStorageService localStorageService;

  UserService(this.userModel, this.localStorageService);

  static String _userIdentifierKey = "userIdentifier";

  Future<String> getUniqueIdentifier() async {
    if (userModel.uniqueIdentifier == null) {
      var newIdentifier =
          await localStorageService.get<String, String>(_userIdentifierKey);

      if (newIdentifier == null) {
        var uuid = Uuid();
        newIdentifier = uuid.v1();

        await localStorageService.put(new KeyValue<String, String>(
            key: _userIdentifierKey, value: newIdentifier));
      }

      userModel.uniqueIdentifier = newIdentifier;

      getItInstance.registerSingleton(userModel);
    }

    return Future.value(userModel.uniqueIdentifier);
  }
}
