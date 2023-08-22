import 'package:untitled1/core/usecase/usecase.dart';
import 'package:untitled1/features/daily_news/domain/entities/article.dart';
import 'package:untitled1/features/daily_news/domain/repositories/articles_repository.dart';

class SaveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  SaveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) async {
    return _articleRepository.saveArticle(params!);
  }
}
