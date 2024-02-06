import 'package:stayfinder_customer/data/models/user_model.dart';

import '../../logic_exports.dart';

part 'user_details_storage_event.dart';
part 'user_details_storage_state.dart';

class UserDetailsStorageBloc
    extends HydratedBloc<UserDetailsStorageEvent, UserDetailsStorageState> {
  UserDetailsStorageBloc() : super(UserDetailsStorageState(isLoggedIn: false)) {
    on<UserDetailsStore>((event, emit) {
      return emit(UserDetailsStorageState()
          .copyWith(isLoggedIn: true, user: event.userModel));
    });
    on<UserDetailsLogout>((event, emit) {
      return emit(UserDetailsStorageState(
          isLoggedIn: false,
          user: UserModel(
              email: '', full_name: '', id: null, image: '', token: '')));
    });
  }

  @override
  void onChange(Change<UserDetailsStorageState> change) {
    print(
        "Current State is ${change.currentState} Next State : ${change.nextState}");
    super.onChange(change);
  }

  @override
  UserDetailsStorageState? fromJson(Map<String, dynamic> json) {
    return UserDetailsStorageState.fromMap(json);
    // TODO: implement fromJson
  }

  @override
  Map<String, dynamic>? toJson(UserDetailsStorageState state) {
    // TODO: implement toJson
    return state.toMap();
  }
}
