

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../hive/boxes.dart';
import '../models/article_model.dart';
import '../models/article_storage.dart';
import 'api/api.dart';
class NewsRepository {



  static Future<List<ArticleModel>> fetchNews() async {
    // await dotenv.load();
    String apiKey = dotenv.get('API_KEY',fallback: "");
    String baseUrl = dotenv.get('BASE_URL', fallback: "");
    String link = '$baseUrl/technology?country=in&apiKey=$apiKey';

    try {
      print(link);
      var response = await FetchNews.fetchNews(link);
      Hive.registerAdapter(ArticleStorageAdapter());
      boxArticles = await Hive.openBox<ArticleStorage>('articlesBox');
      var data = jsonDecode(response.body) ;
      List<dynamic> dataArticle = data['articles'];
      List<ArticleModel> refinedData = dataArticle.map((newsMap) => ArticleModel.fromJson(newsMap)).toList();
      for (int i = 0 ; i< refinedData.length; i++) {
        if (refinedData[i].title == null || refinedData[i].urlToImage ==null || refinedData[i].url == null || refinedData[i].description == null || refinedData[i].content == null) {
          refinedData.remove(refinedData[i]);
        }
        if(i<10) {
          boxArticles.put('article_$i', ArticleStorage( author: refinedData[i].author, title: refinedData[i].title, description: refinedData[i].description, url: refinedData[i].url, urlToImage: refinedData[i].urlToImage, publishedAt: refinedData[i].publishedAt, content: refinedData[i].content));
        }
      }
      // print('samosa');
      // ArticleStorage articleStorage = boxArticles.getAt(0);
      // print(articleStorage.title);
      return refinedData;
    }
    catch(ex) {
      // print("News can't be fetched");
      throw Exception(ex.toString());
    }
  }

  static Future<List<ArticleStorage>> getNewsFromHive() async{
    List<ArticleStorage> news = [];
    Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(ArticleStorageAdapter());
    }
    boxArticles = await Hive.openBox<ArticleStorage>('articlesBox');
    for (int i = 0; i< 10; i++) {
      ArticleStorage articleStorage = boxArticles.get('article_$i');
      news.add(articleStorage);
    }
    return news;
}
}