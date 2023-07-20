import 'package:flutter/material.dart';
import 'package:logique_test/features/commons/presentation/widgets/network_image.dart';
import 'package:logique_test/features/commons/presentation/widgets/rounded_container.dart';
import 'package:logique_test/features/user/domain/entities/user.dart';
import 'package:logique_test/shared/extensions/string_extension.dart';

class UserItemUI extends StatelessWidget {
  final VoidCallback onTap;
  final User user;

  const UserItemUI({Key? key, required this.user, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final first = user.firstName;
    final last = user.lastName;
    final title = user.title?.toTitleCase();
    final name = '$title. $first $last';
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        border: Border.all(color: Colors.grey),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            ImageNetworkContainer(
              user.picture,
              radius: 8,
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                name,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${user.id}',
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
