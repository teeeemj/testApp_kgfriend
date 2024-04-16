import 'package:flutter/material.dart';
import 'package:teeeemj_test/data/models/users_list_model.dart';
import 'package:teeeemj_test/generated/l10n.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({super.key, required this.user});

  final UsersListModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
        centerTitle: true,
        title: Text(
          S.of(context).userDetailPage,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(user.avatarUrl ?? ''),
                ),
                const SizedBox(height: 50),
                Text(
                  user.login ?? '',
                  style: const TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'User ID:  ${user.id}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
