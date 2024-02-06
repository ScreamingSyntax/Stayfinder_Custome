import 'package:stayfinder_customer/logic/logic_exports.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnBoardingBloc extends HydratedBloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(OnBoardingState(false)) {
    on<ChangeEvent>((event, emit) {
      emit(OnBoardingState(true));
    });
  }

  @override
  OnBoardingState? fromJson(Map<String, dynamic> json) {
    return OnBoardingState.fromMap(json); // TODO: implement fromJson
  }

  @override
  Map<String, dynamic>? toJson(OnBoardingState state) {
    return state.toMap();
  }
}
