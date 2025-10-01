part of 'user_bloc.dart';

@immutable
class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final UserModel user;

  UserSuccess({required this.user});
}

class UserError extends UserState {
  final String error;

  UserError({required this.error});
}

// Update Name

class UpdateNameLoading extends UserState {}

class UpdateNameSuccess extends UserState {
  final Map<String, dynamic> user;

  UpdateNameSuccess({required this.user});
}

class UpdateNameError extends UserState {
  final String error;

  UpdateNameError({required this.error});
}
