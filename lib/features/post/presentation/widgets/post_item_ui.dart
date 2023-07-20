import 'package:flutter/material.dart';
import 'package:logique_test/features/comment/presentation/pages/comment_list_ui.dart';
import 'package:logique_test/features/commons/presentation/widgets/my_button.dart';
import 'package:logique_test/features/commons/presentation/widgets/network_image.dart';
import 'package:logique_test/features/commons/presentation/widgets/rounded_container.dart';
import 'package:logique_test/features/commons/presentation/widgets/underline_ui.dart';
import 'package:logique_test/features/post/domain/entities/post.dart';
import 'package:logique_test/features/post/presentation/widgets/user_thumbnail_ui.dart';

class PostItemUI extends StatelessWidget {
  final bool isLike;
  final VoidCallback onTapLike;
  final ValueChanged<String>? onTagPressed;
  final Post post;

  const PostItemUI({
    Key? key,
    this.onTagPressed,
    required this.post,
    required this.onTapLike,
    this.isLike = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.owner != null && post.publishDate != null)
            UserThumbnailUI(
              user: post.owner!,
              date: post.publishDate!,
            ),
          const SizedBox(height: 16),
          ImageNetworkContainer(
            post.image,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          const SizedBox(height: 16),
          if (post.tags != null)
            Wrap(
              direction: Axis.horizontal,
              children: post.tags!.map(
                (e) {
                  return MyButton(
                    text: e,
                    height: 25,
                    fontSize: 12,
                    margin: const EdgeInsets.only(right: 8),
                    onPressed: onTagPressed == null
                        ? null
                        : () {
                            if (onTagPressed != null) onTagPressed!(e);
                          },
                  );
                },
              ).toList(),
            ),
          Text('${post.text}'),
          const SizedBox(height: 4),
          Text(
            '${post.likes} Likes',
            style: const TextStyle(color: Colors.grey),
          ),
          UnderlineUI(margin: EdgeInsets.zero.copyWith(top: 8)),
          Row(
            children: [
              GestureDetector(
                onTap: onTapLike,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    isLike ? Icons.favorite : Icons.favorite_border,
                    size: 25,
                    color: isLike ? Colors.red[900] : Colors.grey,
                  ),
                ),
              ),
              const Text(
                'Like',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontSize: 15),
              ),
              GestureDetector(
                onTap: () => _onTapComment(context),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.comment_outlined,
                    size: 25,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onTapComment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: CommentListUI(post: post),
      ),
    );
  }
}
