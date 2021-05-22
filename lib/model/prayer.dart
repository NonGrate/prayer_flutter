class Prayer {
  final String authorId;
  final String content;
  final int follows;

  Prayer({required this.authorId, required this.content, required this.follows});

  factory Prayer.fromJson(Map<String, dynamic> json) {
    return Prayer(
      authorId: json["author_id"],
      content: json["content"],
      follows: json["follows"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "author_id": this.authorId,
      "content": this.content,
      "follows": this.follows,
    };
  }

  @override
  String toString() {
    return 'Prayer{authorId: $authorId, content: $content, follows: $follows}';
  }
}