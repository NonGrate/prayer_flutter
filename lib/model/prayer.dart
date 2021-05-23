import 'package:prayer/logic/auth_manager.dart';
import 'package:uuid/uuid.dart';

class Prayer {
  final String id;
  final String authorId;
  final String content;
  final DateTime createdAt;
  final List<String> follows;
  final bool followed;

  Prayer({
    required this.id,
    required this.authorId,
    required this.content,
    required this.follows,
    required this.followed,
    required this.createdAt,
  });

  factory Prayer.fromJson(Map<String, dynamic> json) {
    List<String> follows = (json["follows"] as List<dynamic>).map((e) => e.toString()).toList();
    return Prayer(
      id: json["id"],
      authorId: json["author_id"],
      content: json["content"],
      follows: follows,
      createdAt: DateTime.parse(json["created_at"].toString()),
      followed: follows.contains(AuthManager.instance.getUser()?.uid ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "author_id": this.authorId,
      "content": this.content,
      "follows": this.follows,
      "created_at": this.createdAt.toString(),
    };
  }

  @override
  String toString() {
    return 'Prayer{id: $id, authorId: $authorId, content: $content, follows: $follows, followed: $followed, createdAt: $createdAt}';
  }
}