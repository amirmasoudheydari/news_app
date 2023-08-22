import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/core/constant/constants.dart';
import 'package:untitled1/features/daily_news/domain/entities/article.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/article/remote_article_bloc.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/article/remote_article_state.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_state.dart';
import 'package:untitled1/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatefulWidget {
  const DailyNews({super.key});

  @override
  State<DailyNews> createState() => _DailyNewsState();
}

class _DailyNewsState extends State<DailyNews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text('Daily News', style: TextStyle(color: Colors.black)),
        actions: [
          BlocBuilder<LocalArticlesBloc, LocalArticlesState>(
            builder: (context, state) {
              if (state is LocalArticlesLoading) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (state is LocalArticleDone) {
                final List<ArticleEntity> saveArticles = state.articles;

                return Stack(children: [
                  IconButton(
                      icon: Icon(Icons.bookmark,
                          color: saveArticles.isNotEmpty ? Colors.red : null),
                      onPressed: () {
                        Navigator.pushNamed(context, saveArticleView,
                            arguments: saveArticles);
                      }),
                  Positioned(
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            saveArticles.length.toString(),
                          ),
                        ),
                      ))
                ]);
              }

              return const Center(child: Text('nothing'));
            },
          )
        ]);
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (_, state) {
      if (state is RemoteArticleLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }

      if (state is RemoteArticleError) {
        return const Center(child: Icon(Icons.refresh));
      }

      if (state is RemoteArticleDone) {
        return ListView.builder(
            itemCount: state.articles!.length,
            itemBuilder: (context, index) {
              return ArticleWidget(
                article: state.articles![index],
                onArticlePressed: (ArticleEntity article) =>
                    _onArticlePressed(context, article),
              );
            });
      }

      return const SizedBox();
    });
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, articleDetailView, arguments: article);
  }
}
