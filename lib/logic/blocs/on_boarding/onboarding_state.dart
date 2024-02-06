part of 'onboarding_bloc.dart';

class OnBoardingState extends Equatable {
  final bool change;
  OnBoardingState(this.change);

  @override
  List<Object> get props => [change];
  OnBoardingState copyWith({bool? change}) {
    return OnBoardingState(change ?? this.change);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'change': change};
  }

  factory OnBoardingState.fromMap(Map<String, dynamic> map) {
    return OnBoardingState(map['change'] as bool);
  }
  String toJson() => json.encode(toMap());

  factory OnBoardingState.fromJson(String source) =>
      OnBoardingState.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
