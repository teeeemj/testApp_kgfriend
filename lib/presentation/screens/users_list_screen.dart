import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teeeemj_test/generated/l10n.dart';
import 'package:teeeemj_test/presentation/bloc/users_bloc.dart';
import 'package:teeeemj_test/presentation/screens/user_detail.dart';
import 'package:teeeemj_test/presentation/widgets/current_page.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade500,
        centerTitle: true,
        title: Text(
          S.of(context).githubUsers,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UsersSuccess) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: state.usersList.length,
              itemBuilder: (context, index) {
                final currentPage = (index ~/ 10) + 1;
                if (currentPage == state.currentPage) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserDetail(
                            user: state.usersList[index],
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          state.usersList[index].avatarUrl ?? '',
                        ),
                      ),
                      title: Text(
                        state.usersList[index].login ?? '',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
              separatorBuilder: (context, index) {
                final currentPage = (index ~/ 10) + 1;
                if (index != 0 && currentPage == state.currentPage) {
                  return const Divider(
                    color: Colors.black45,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          }
          if (state is UsersFailure) {
            return Center(
              child: Text(state.errorText),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        onPressed: () {
          BlocProvider.of<UsersBloc>(context)
              .add(GetNextPageEvent(lastUserId: 0));
        },
        child: const Icon(
          Icons.next_plan_outlined,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade500,
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            log('Log for NextPage: ${state.toString()}');
            if (state is UsersSuccess) {
              return CurrentPage(
                currentPage: state.currentPage,
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
