part of 'user_details_storage_bloc.dart';

sealed class UserDetailsStorageEvent extends Equatable {
  const UserDetailsStorageEvent();

  @override
  List<Object> get props => [];
}

class UserDetailsStore extends UserDetailsStorageEvent {
  final UserModel userModel;

  UserDetailsStore({required this.userModel});
}

class UserDetailsLogout extends UserDetailsStorageEvent {}
