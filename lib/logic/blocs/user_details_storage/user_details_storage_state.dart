part of 'user_details_storage_bloc.dart';

// ignore: must_be_immutable
class UserDetailsStorageState extends Equatable {
  bool? isLoggedIn;
  UserModel? user;

  UserDetailsStorageState({this.isLoggedIn, this.user});
  UserDetailsStorageState copyWith({bool? isLoggedIn, UserModel? user}) {
    return UserDetailsStorageState(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn, user: user ?? user);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'isLoggedIn': isLoggedIn, 'user': user!.toMap()};
  }

  factory UserDetailsStorageState.fromMap(Map<String, dynamic> map) {
    return UserDetailsStorageState(
      isLoggedIn: map['isLoggedIn'] as bool?,
      user: UserModel.fromMap(map['user']),
    );
  }

  @override
  List<Object> get props {
    if (isLoggedIn != null && user == null) {
      return [isLoggedIn!];
    }
    if (user != null) {
      return [isLoggedIn!, user!];
    }
    return [];
  }
}
