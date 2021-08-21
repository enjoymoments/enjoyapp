import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozin/features/listener_manager/data/models/listener_action_model.dart';
import 'package:mozin/features/listener_manager/domain/entities/listener_action_type.dart';
import 'package:mozin/features/listener_manager/presentation/bloc/listener_manager_state.dart';
import 'package:mozin/features/time_line/presentation/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:mozin/modules/shared/firebase/firebase_instance_provider.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/config/setup.dart';

class ListenerManagerCubit extends Cubit<ListenerManagerState> {
  ListenerManagerCubit() : super(ListenerManagerState.initial());

  StreamSubscription<DocumentSnapshot> _actionSubscription;

  @override
  Future<void> close() {
    unsubscribeActionListener();
    return super.close();
  }

  void subscribeActionListener() {
    var _instance = new FirestoreInstanceProvider();
    var _user = getItInstance<UserWrapper>().getUser;

    if (getItInstance<UserWrapper>().authenticated &&
        _actionSubscription == null) {
      _actionSubscription = _instance.firestore
          .doc('actionListener/${_user.id}')
          .snapshots()
          .listen(
        (action) {
          _resolverActions(_parseActions(action));
          _deleteActionRemote(action, _user.id);
        },
      );
    }
  }

  Future<void> unsubscribeActionListener() async {
    await _actionSubscription?.cancel();
    _actionSubscription = null;
  }

  ListenerActionModel _parseActions(DocumentSnapshot action) {
    return ListenerActionModel.fromJson(action.data());
  }

  void _resolverActions(ListenerActionModel model) {
    for (ListenerActionTypeEnum action in model.actions) {
      if (action == ListenerActionTypeEnum.SyncCouple) {
        _forceUpdateTimeline();
      } else if (action == ListenerActionTypeEnum.UnsyncCouple) {
        _forceUpdateTimeline();
      }
    }
  }

  void _forceUpdateTimeline() {
    var user = getItInstance<UserWrapper>().getUser;

    var _newInstance =
        user.copyWith(timelineSelected: null, acceptValueNull: true);
    getItInstance<UserWrapper>().assignment(_newInstance);

    getItInstance<TimelineBloc>().add(LoadPosts());
  }

  void _deleteActionRemote(DocumentSnapshot action, String userId) {
    final FirestoreInstanceProvider _instance = new FirestoreInstanceProvider();
    _instance.firestore.doc('actionListener/$userId').delete();
  }
}
