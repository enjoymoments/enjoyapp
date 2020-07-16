import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class DefaultState extends Equatable {
  DefaultState([List props = const []]) : super();

  @override
  List<Object> get props => null;
}

class Initial extends DefaultState {
  @override
  String toString() => 'Initial';
}

class Loading extends DefaultState {
  @override
  String toString() => 'Loading';
}

class Empty extends DefaultState {
  @override
  String toString() => 'Empty';
}

class Error extends DefaultState {

  final String error;

  Error({@required this.error}) : super([error]);

  @override
  String toString() => 'Error { errorMessage: $error }';
}