import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:mozin/modules/shared/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/config/setup.dart';

part 'root_screen_manager_state.dart';

class RootScreenManagerCubit extends Cubit<RootScreenManagerState> {
  RootScreenManagerCubit() : super(RootScreenManagerInitial());

  StreamSubscription<DocumentSnapshot> _actionSubscription;

  @override
  Future<void> close() {
    unsubscribeActionListener();
    return super.close();
  }

  void executeAction(DocumentSnapshot action) {
    print('ready');
  }

  void subscribeActionListener() {
    var _instance = new FirestoreInstanceProvider();
    var _user =  getItInstance<UserWrapper>().getUser;

    if (getItInstance<UserWrapper>().authenticated && _actionSubscription == null) {
      _actionSubscription = _instance.firestore
          .doc('actionListener/${_user.id}')
          .snapshots()
          .listen(
            (action) => executeAction(action),
          );
    }
  }

  Future<void> unsubscribeActionListener() async {
    await _actionSubscription?.cancel();
    _actionSubscription = null;
  }
}
