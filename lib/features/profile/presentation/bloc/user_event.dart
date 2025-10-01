part of 'user_bloc.dart';

class UserEvent {}

class LoadUserEvent extends UserEvent {}

class UpdateNameEvent extends UserEvent {
  final String name;

  UpdateNameEvent({required this.name});
}
