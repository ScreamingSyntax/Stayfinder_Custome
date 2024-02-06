part of 'onboarding_bloc.dart';

sealed class OnBoardingEvent extends Equatable {
  const OnBoardingEvent();

  @override
  List<Object> get props => [];
}

class ChangeEvent extends OnBoardingEvent {}
