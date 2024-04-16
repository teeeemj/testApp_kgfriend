import 'package:flutter/material.dart';
import 'package:teeeemj_test/generated/l10n.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          S.of(context).noInternet,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
