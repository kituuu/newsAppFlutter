

part of 'news_bloc.dart';


@immutable
abstract class NewsState{}

abstract class NewsActionState extends NewsState {}

class NewsInitial extends NewsState{}

class NewsFetchingState extends NewsState {}

class NewsFetchingErrorState extends NewsState {}

class NewsFetchedState extends NewsState {
  final List<ArticleModel> news;

  NewsFetchedState({required this.news});
}

class NewsOfflineState extends NewsState {
  final List<ArticleStorage> news;
  NewsOfflineState({required this.news});
}


