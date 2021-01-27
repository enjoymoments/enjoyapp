import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/feedback/domain/repositories/feedback_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc({@required FeedbackRepository feedbackRepository})
      : assert(feedbackRepository != null),
        _feedbackRepository = feedbackRepository,
        super(FeedbackState.initial());

  final FeedbackRepository _feedbackRepository;

  @override
  Stream<FeedbackState> mapEventToState(
    FeedbackEvent event,
  ) async* {
  }
}