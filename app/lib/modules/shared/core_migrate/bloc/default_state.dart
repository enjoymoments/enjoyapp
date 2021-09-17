import 'package:equatable/equatable.dart';

class DefaultState extends Equatable {
  DefaultState({
    this.isLoading,
    this.isSuccess,
    this.isEmpty,
    this.isError,
    this.errorMessage,
  });

  final bool? isLoading;
  final bool? isSuccess;
  final bool? isEmpty;
  final bool? isError;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isError,
        isEmpty,
        errorMessage,
      ];
}
