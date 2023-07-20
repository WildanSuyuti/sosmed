import 'package:flutter/material.dart';
import 'package:logique_test/core/di/injection.dart';
import 'package:m_toast/m_toast.dart';

class Toast {
  static void showSuccess(BuildContext context, String message) {
    getIt<ShowMToast>().successToast(
      context,
      message: message,
      backgroundColor: const Color(0xffd4edda),
      textColor: const Color(0xff155724),
      alignment: Alignment.bottomCenter,
    );
  }

  static void showInfo(BuildContext context, String message) {
    getIt<ShowMToast>().successToast(
      context,
      message: message,
      backgroundColor: const Color(0xffd1ecf1),
      textColor: const Color(0xff0c5460),
      alignment: Alignment.bottomCenter,
      icon: Icons.info,
    );
  }

  static void showError(BuildContext context, String message) {
    getIt<ShowMToast>().errorToast(
      context,
      message: message,
      backgroundColor: const Color(0xfff8d7da),
      textColor: const Color(0xff721c24),
      alignment: Alignment.bottomCenter,
    );
  }
}
