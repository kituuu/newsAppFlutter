
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/article_model.dart';
import '../../../data/models/article_storage.dart';
import '../../../data/repositories/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsInitialFetchEvent>(newsInitialFetchEvent);
  }

  FutureOr<void> newsInitialFetchEvent(NewsInitialFetchEvent event, Emitter<NewsState> emit) async{
    emit(NewsFetchingState());
    try {
          List<ArticleModel> news = await NewsRepository.fetchNews();
          emit(NewsFetchedState(news: news));

    } catch (e) {
      List<ArticleStorage> news = await NewsRepository.getNewsFromHive();
      emit(NewsOfflineState(news: news));

      // throw(e);
    }


  }
}