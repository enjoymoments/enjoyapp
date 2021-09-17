import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/user_action/data/models/user_action_model.dart';
import 'package:mozin/modules/shared/general/models/response_default_model.dart';

abstract class UserActionRepository {
  Future<Either<ResponseDefaultModel, Exception>> addUserAction({
    required UserActionModel model
  });
}
