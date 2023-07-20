import 'package:flutter/material.dart';
import 'package:logique_test/core/error/failure.dart';
import 'package:logique_test/shared/extensions/failure_ext.dart';

import 'my_button.dart';

class FailureUI extends StatelessWidget {
  final String title;
  final String description;

  final VoidCallback onRetry;

  const FailureUI({
    Key? key,
    required this.onRetry,
    required this.title,
    required this.description,
  }) : super(key: key);

  factory FailureUI.showErrorMessage({
    required Failure failure,
    required VoidCallback onRetry,
  }) {
    return FailureUI(
      onRetry: onRetry,
      title: failure.title,
      description: failure.message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '$title\n',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text: description,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          MyButton(
            text: 'Retry',
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
