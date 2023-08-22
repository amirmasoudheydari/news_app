import 'package:equatable/equatable.dart';
import 'package:untitled1/features/daily_news/domain/entities/article.dart';

abstract class LocalArticlesState extends Equatable {
  const LocalArticlesState();
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading() : super();

  @override
  List<Object?> get props => [];
}

class LocalArticleDone extends LocalArticlesState {
  final List<ArticleEntity> articles;

  const LocalArticleDone(this.articles) : super();

  @override
  List<Object?> get props => [articles];
}
