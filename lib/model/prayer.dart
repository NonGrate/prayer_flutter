import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Prayer {
  final Uuid id;
  final String authorId;
  final String content;
  final int follows;
  final DateTime createdAt;
  final bool followed;

  Prayer({
    this.id = const Uuid(),
    required this.authorId,
    required this.content,
    required this.follows,
    required this.followed,
    required this.createdAt,
  });

  factory Prayer.fromJson(Map<String, dynamic> json) {
    print("from json");
    print(json["created_at"].runtimeType);
    print(json["created_at"].toString());
    print(DateTime.parse(json["created_at"].toString()));
    print("=============");
    return Prayer(
      authorId: json["author_id"],
      content: json["content"],
      follows: json["follows"],
      createdAt: DateTime.parse(json["created_at"].toString()),
      followed: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "author_id": this.authorId,
      "content": this.content,
      "follows": this.follows,
      "created_at": this.createdAt.toString(),
      "followed": followed,
    };
  }

  @override
  String toString() {
    return 'Prayer{authorId: $authorId, content: $content, follows: $follows, followed: $followed, createdAt: $createdAt}';
  }
}