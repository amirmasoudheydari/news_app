import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/features/daily_news/domain/entities/article.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_event.dart';

class ArticleDetailView extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
            onPressed: () => _onFloatingActionButtonPressed(context),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: Colors.lightBlue,
            child: const Icon(Icons.bookmark, color: Colors.white)),
        body: _view(context));
  }

  Widget _view(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(article.title ?? '',
              style:
                  textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
          Text('- ${article.name ?? ''}',
              style:
                  textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(children: [
            const Icon(Icons.schedule, size: 15),
            const SizedBox(width: 5),
            Text(
              article.publishedAt!,
            )
          ]),
          const SizedBox(height: 3),
          CachedNetworkImage(
              imageUrl: article.urlToImage ?? '',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                      width: double.maxFinite,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(child: Text('loading...'))),
              imageBuilder: (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      width: double.maxFinite,
                      height: screenHeight / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)))),
              errorWidget: (context, error, widget) =>
                  const Center(child: Text('error'))),
          const SizedBox(height: 10),
          Text(article.description!,
              textAlign: TextAlign.justify,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          const SizedBox(height: 20),
          Text(article.content ?? '',
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
        ]));
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticlesBloc>(context).add(SaveArticle(article));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
        behavior: SnackBarBehavior.floating,
        content: Text('Article Saved Successfully')));
  }
}
