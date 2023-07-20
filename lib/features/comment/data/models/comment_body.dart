class CommentBody {
  final String owner;
  final String post;
  final String message;

  CommentBody({
    required this.owner,
    required this.post,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'owner': owner,
        'post': post,
        'message': message,
      };

  factory CommentBody.fromJson(Map<String, dynamic> json) {
    return CommentBody(
      owner: json['owner'],
      post: json['post'],
      message: json['message'],
    );
  }
}
