import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:teeeemj_test/core/network/dio_settings.dart';
import 'package:teeeemj_test/data/repositories/github_repository.dart';
import 'package:teeeemj_test/generated/l10n.dart';
import 'package:teeeemj_test/presentation/bloc/users_bloc.dart';
import 'package:teeeemj_test/presentation/check_internet_cubit/check_internet_cubit.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UsersBloc(
              repository: RepositoryProvider.of<GithubRepository>(context),
            )..add(GetUsersEvent()),
          ),
          BlocProvider(
            create: (context) => InternetCubit(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            // locale: Locale('en'),
            home: const SplashScreen()),
      ),
    );
  }
}
