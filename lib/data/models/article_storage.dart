import 'package:hive/hive.dart';

import 'article_model.dart';

part 'article_storage.g.dart';

@HiveType(typeId:1)
class ArticleStorage {
  @HiveField(0)
  String? author;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? url;
  @HiveField(4)
  String? urlToImage;
  @HiveField(5)
  String? publishedAt;
  @HiveField(6)
  String? content;
  ArticleStorage({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content
});
}