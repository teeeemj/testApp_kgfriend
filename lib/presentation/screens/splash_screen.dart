import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teeeemj_test/presentation/check_internet_cubit/check_internet_cubit.dart';
import 'package:teeeemj_test/presentation/screens/no_internet_screen.dart';
import 'package:teeeemj_test/presentation/screens/users_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late InternetCubit internetCubit;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    internetCubit = context.read<InternetCubit>();
    internetCubit.trackConnectivityChange();
    internetCubit.stream.listen((state) {
      setState(() {
        isConnected = state.status == ConnectivityStatus.connected;
      });
    });
    _navigateToUsersListScreen();
  }

  @override
  void dispose() {
    internetCubit.close();
    super.dispose();
  }

  void _navigateToUsersListScreen() {
    Timer(
      const Duration(seconds: 3),
      () {
        if (isConnected) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const UsersListScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NoInternetScreen()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Image.asset(
            'assets/pngs/logo.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
