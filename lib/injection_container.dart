import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled1/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:untitled1/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:untitled1/features/daily_news/data/repositories/article_repository_impl.dart';
import 'package:untitled1/features/daily_news/domain/repositories/articles_repository.dart';
import 'package:untitled1/features/daily_news/domain/use_cases/get_article.dart';
import 'package:untitled1/features/daily_news/domain/use_cases/get_saved_article.dart';
import 'package:untitled1/features/daily_news/domain/use_cases/remove_article.dart';
import 'package:untitled1/features/daily_news/domain/use_cases/save_article.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/article/remote_article_bloc.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependence() async {
  // database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // dio
  sl.registerSingleton<Dio>(Dio());

  // newsApiService
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  // repository
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  // use_case
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));
  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));
  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));

  // bloc
  sl.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(sl()));
  sl.registerFactory<LocalArticlesBloc>(
      () => LocalArticlesBloc(sl(), sl(), sl()));
}
