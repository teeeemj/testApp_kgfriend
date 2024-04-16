part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

class GetUsersEvent extends UsersEvent {}

class GetNextPageEvent extends UsersEvent {
  final int lastUserId;

  GetNextPageEvent({required this.lastUserId});
}
