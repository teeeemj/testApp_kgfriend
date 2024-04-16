import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teeeemj_test/data/models/users_list_model.dart';
import 'package:teeeemj_test/data/repositories/github_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GithubRepository repository;
  UsersBloc({required this.repository}) : super(UsersInitial()) {
    on<GetUsersEvent>((event, emit) async {
      emit(UsersLoading());
      try {
        final result = await repository.getUsers();
        emit(UsersSuccess(usersList: result, currentPage: 1));
      } catch (e) {
        emit(UsersFailure(errorText: e.toString()));
      }
    });

    on<GetNextPageEvent>((event, emit) async {
      final currentstate = state;
      if (currentstate is UsersSuccess) {
        try {
          final lastUserId = currentstate.usersList.last.id;
          final nextPageUsers =
              await repository.getUsers(since: lastUserId ?? 0);
          final List<UsersListModel> usersList = [
            ...currentstate.usersList,
            ...nextPageUsers
          ];
          emit(UsersSuccess(
              usersList: usersList, currentPage: currentstate.currentPage + 1));
        } catch (e) {
          emit(UsersFailure(errorText: e.toString()));
        }
      }
    });
  }
}
