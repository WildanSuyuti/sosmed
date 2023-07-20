import 'package:flutter/material.dart';
import 'package:logique_test/features/commons/presentation/widgets/network_image.dart';
import 'package:logique_test/features/user/domain/entities/user.dart';
import 'package:logique_test/shared/extensions/date_extension.dart';
import 'package:logique_test/shared/extensions/user_extension.dart';

class UserThumbnailUI extends StatelessWidget {
  final User user;
  final DateTime date;

  const UserThumbnailUI({Key? key, required this.user, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strDate = date.format('dd MMM yyyy HH:mm:ss');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageNetworkContainer(
          width: 40,
          height: 40,
          radius: 40,
          user.picture,
        ),
        const SizedBox(width: 16),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            text: '${user.name}\n',
            children: [
              TextSpan(
                text: strDate,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}