import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teeeemj_test/core/network/dio_settings.dart';
import 'package:teeeemj_test/data/repositories/github_repository.dart';
import 'package:teeeemj_test/presentation/bloc/users_bloc.dart';
import 'package:teeeemj_test/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => GithubRepository(
            dio: RepositoryProvider.of<DioSettings>(context).dio,
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => UsersBloc(
          repository: RepositoryProvider.of<GithubRepository>(context),
        )..add(GetUsersEvent()),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
