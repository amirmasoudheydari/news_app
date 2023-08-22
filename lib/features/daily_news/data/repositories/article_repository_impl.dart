import 'dart:io';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:untitled1/core/constant/constants.dart';
import 'package:untitled1/core/resources/data_state.dart';
import 'package:untitled1/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:untitled1/features/daily_news/data/data_sources/local/news_article_local.dart';
import 'package:untitled1/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:untitled1/features/daily_news/data/models/article.dart';
import 'package:untitled1/features/daily_news/domain/entities/article.dart';
import 'package:untitled1/features/daily_news/domain/repositories/articles_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    final internetConnectionStatus =
        await InternetConnectionChecker().connectionStatus;

    if (internetConnectionStatus == InternetConnectionStatus.connected) {
      try {
        final httpResponse = await _newsApiService.getNewsArticles(
            country: countryQuery,
            category: categoryQuery,
            apiKey: apiKeyQuery);

        if (httpResponse.response.statusCode == HttpStatus.ok) {
          return DataSuccess(httpResponse.data);
        } else {
          return DataFailed(DioException(
              requestOptions: httpResponse.response.requestOptions,
              response: httpResponse.response,
              error: httpResponse.response.statusMessage));
        }
      } on DioException catch (e) {
        return DataFailed(e);
      }
    } else {
      final List<ArticleModel> articles =
          newsArticleLocal.map((e) => ArticleModel.fromJson(e)).toList();
      return Future.value(DataSuccess(articles));
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() async {
    return _appDatabase.articleDAO.getSavedArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDAO
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) async {
    _appDatabase.articleDAO.insertArticle(ArticleModel.fromEntity(article));
  }
}
