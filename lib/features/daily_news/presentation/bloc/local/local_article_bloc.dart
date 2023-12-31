import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/features/daily_news/domain/use_cases/get_saved_article.dart';
import 'package:untitled1/features/daily_news/domain/use_cases/remove_article.dart';
import 'package:untitled1/features/daily_news/domain/use_cases/save_article.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_event.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_state.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticlesBloc(this._getSavedArticlesUseCase, this._saveArticleUseCase,
      this._removeArticleUseCase)
      : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<SaveArticle>(onSaveArticle);
    on<RemoveArticle>(onRemoveArticle);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }

  void onSaveArticle(
      SaveArticle saveArticle, Emitter<LocalArticlesState> emit) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }

  void onRemoveArticle(
      RemoveArticle removeArticle, Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticlesUseCase();
    emit(LocalArticleDone(articles));
  }
}
