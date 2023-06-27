import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/blocs/news_bloc/news_bloc.dart';
import '../widgets/news_container.dart';



class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  final NewsBloc newsBloc = NewsBloc();

  @override
  void initState() {
    newsBloc.add(NewsInitialFetchEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NewsBloc, NewsState>(
        bloc: newsBloc,
        listenWhen: (previous, current) => current is NewsActionState,
        buildWhen: (previous, current) => current is !NewsActionState,
        listener: (context, state) {
          if (state.runtimeType is NewsFetchingErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("News Fetching Error"), backgroundColor: Colors.pinkAccent,)
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case NewsFetchingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case NewsFetchedState:
              final successState = state as NewsFetchedState;
              return PageView.builder(
                  controller: PageController(initialPage: 1),
                  scrollDirection: Axis.vertical,
                  itemCount: successState.news.length,
                  itemBuilder: (context, index) {
                    // print(successState.news[index].content!);
                    return NewsContainer(
                        imgUrl: successState.news[index].urlToImage!,
                        newsHead: successState.news[index].title!,
                        newsDes: successState.news[index].description!,
                        newsUrl: successState.news[index].url!,
                        content: successState.news[index].title!
                    );
                  }
              );
            case NewsOfflineState:
              final successState = state as NewsOfflineState;
              return PageView.builder(
                  controller: PageController(initialPage: 0),
                  scrollDirection: Axis.vertical,
                  itemCount: successState.news.length,
                  itemBuilder: (context, index) {
                    return NewsContainer(
                        imgUrl: successState.news[index].urlToImage.toString(),
                        newsHead: successState.news[index].title!,
                        newsDes: successState.news[index].description!,
                        newsUrl: successState.news[index].url!,
                        content: successState.news[index].title!,
                    );
                  }
              );
            default:
              return const Center(child:Text("News Fetching Error"));
          }
        },
      ),
    );;
  }
}

