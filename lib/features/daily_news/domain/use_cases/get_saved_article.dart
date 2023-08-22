import 'package:untitled1/core/usecase/usecase.dart';
import 'package:untitled1/features/daily_news/domain/entities/article.dart';
import 'package:untitled1/features/daily_news/domain/repositories/articles_repository.dart';

class GetSavedArticleUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;

  GetSavedArticleUseCase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}
