import 'package:flutter/material.dart';
import 'package:logique_test/features/commons/presentation/widgets/network_image.dart';
import 'package:logique_test/features/commons/presentation/widgets/rounded_container.dart';
import 'package:logique_test/features/commons/presentation/widgets/underline_ui.dart';
import 'package:logique_test/features/user/domain/entities/user_detail.dart';
import 'package:logique_test/shared/extensions/date_extension.dart';
import 'package:logique_test/shared/extensions/string_extension.dart';
import 'package:logique_test/shared/extensions/user_extension.dart';

class UserDetailInfoUI extends StatelessWidget {
  final UserDetail data;
  final VoidCallback onTapFollow;
  final bool isFollowed;

  const UserDetailInfoUI({
    Key? key,
    required this.data,
    required this.onTapFollow,
    required this.isFollowed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imageSize = MediaQuery.of(context).size.width * 0.25;

    return SliverList(
        delegate: SliverChildListDelegate([
      const SizedBox(height: 16),
      Row(
        children: [
          Stack(
            children: [
              RoundedContainer(
                margin: const EdgeInsets.only(bottom: 16),
                radius: imageSize,
                border: Border.all(color: Colors.blueGrey, width: 5),
                child: ImageNetworkContainer(
                  data.picture,
                  radius: imageSize,
                  width: imageSize,
                  height: imageSize,
                ),
              ),
              Positioned.fill(
                bottom: 8,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: onTapFollow,
                    child: RoundedContainer(
                      color: isFollowed ? Colors.red.shade900 : Colors.blue,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        isFollowed ? 'Unfollow' : 'Follow',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              _buildInfo('Gender', '${data.gender?.toTitleCase()}'),
              _buildInfo('Date of birth', '${data.dateOfBirth?.format()}'),
              _buildInfo('Join from', '${data.registerDate?.format()}'),
            ],
          )
        ],
      ),
      const SizedBox(height: 24),
      _buildInfo('Email', '${data.email}'),
      _buildInfo('Address', data.address),
      UnderlineUI(margin: EdgeInsets.zero.copyWith(top: 8, bottom: 16)),
    ]));
  }

  _buildInfo(String label, String text, {EdgeInsets? margin}) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          text: '$label: ',
          children: [
            TextSpan(
              text: text,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
