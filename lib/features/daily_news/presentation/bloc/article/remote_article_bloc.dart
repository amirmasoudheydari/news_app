import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/core/resources/data_state.dart';
import 'package:untitled1/features/daily_news/domain/use_cases/get_article.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/article/remote_article_event.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/article/remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticleBloc(this._getArticleUseCase)
      : super(const RemoteArticleLoading()) {
    on<GetArticle>(onGetArticle);
  }

  Future<void> onGetArticle(
      RemoteArticleEvent event, Emitter<RemoteArticleState> emit) async {
    final responseState = await _getArticleUseCase();

    if (responseState is DataSuccess && responseState.data!.isNotEmpty) {
      emit(RemoteArticleDone(responseState.data!));
    }

    if (responseState is DataFailed) {
      emit(RemoteArticleError(responseState.error!));
    }
  }
}

//
