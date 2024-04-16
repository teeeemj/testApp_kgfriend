import 'package:flutter/material.dart';
import 'package:teeeemj_test/generated/l10n.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        S.of(context).pageCurrentNPage(currentPage),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
