import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/features/daily_news/domain/entities/article.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_event.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_state.dart';
import 'package:untitled1/features/daily_news/presentation/widgets/article_tile.dart';

class SaveArticlePage extends StatelessWidget {
  const SaveArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: _view());
  }

  Widget _view() {
    return BlocBuilder<LocalArticlesBloc, LocalArticlesState>(
      builder: (context, state) {
        if (state is LocalArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is LocalArticleDone) {
          final List<ArticleEntity> saveArticle = state.articles;

          if (saveArticle.isEmpty) {
            return const Center(
                child:
                    Text('No Save Articles', style: TextStyle(fontSize: 18)));
          }

          return ListView.separated(
              itemBuilder: (context, index) {
                return ArticleWidget(
                    article: saveArticle[index],
                    isRemovable: true,
                    onRemove: (article) =>
                        BlocProvider.of<LocalArticlesBloc>(context)
                            .add(RemoveArticle(article)));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: saveArticle.length);
        }
        return const SizedBox();
      },
    );
  }
}
