part of 'users_bloc.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class UsersSuccess extends UsersState {
  final List<UsersListModel> usersList;
  final int currentPage;

  UsersSuccess({required this.usersList, required this.currentPage});
}

final class UsersFailure extends UsersState {
  final String errorText;

  UsersFailure({required this.errorText});
}
