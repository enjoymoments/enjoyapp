part of 'intro_bloc.dart';

abstract class IntroState extends DefaultState {  
  @override
  List<Object> get props => [];
}

class IntroInitial extends IntroState {}

class RedirectOnboarding extends IntroState {}

class RedirectHome extends IntroState {}
