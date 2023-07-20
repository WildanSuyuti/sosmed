import 'package:flutter/material.dart';
import 'package:logique_test/features/comment/domain/entities/comment.dart';
import 'package:logique_test/features/post/presentation/widgets/user_thumbnail_ui.dart';

class CommentItemUI extends StatelessWidget {
  final Comment comment;

  const CommentItemUI({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (comment.owner != null && comment.publishDate != null)
            UserThumbnailUI(
              user: comment.owner!,
              date: comment.publishDate!,
            ),
          const SizedBox(height: 4),
          Text(
            '${comment.message}',
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
