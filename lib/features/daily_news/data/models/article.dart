import 'package:untitled1/features/daily_news/domain/entities/article.dart';
import 'package:floor/floor.dart';

/// source : {"id":"reuters","name":"Reuters"}
/// author : "Kane Wu"
/// title : "Asian stocks slip as China data continues to disappoint - Reuters"
/// description : "Asian stocks stumbled on Wednesday, as more disappointing Chinese economic data and the absence of meaningful stimulus from Beijing continued to weigh on investor sentiment."
/// url : "https://www.reuters.com/markets/global-markets-wrapup-1-2023-08-16/"
/// urlToImage : "https://www.reuters.com/resizer/ip8qer8P1SG6nQSdSAe_7e_D1iE=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/JAQ6SVUAKRKMXCEYFJ5WFEQQXQ.jpg"
/// publishedAt : "2023-08-16T06:16:08Z"
/// content : "HONG KONG, Aug 16 (Reuters) - Asian stocks stumbled on Wednesday, as more disappointing Chinese economic data and the absence of meaningful stimulus from Beijing continued to weigh on investor sentim… [+3311 chars]"

@Entity(tableName: 'article', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel(
      {String? name,
      String? id,
      String? author,
      String? title,
      String? description,
      String? url,
      String? urlToImage,
      String? publishedAt,
      String? content})
      : super(
            name: name,
            id: id,
            author: author,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content);

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      name: json['source']['name'],
      id: json['source']['id'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
        id: entity.id,
        author: entity.author,
        title: entity.title,
        description: entity.description,
        url: entity.url,
        urlToImage: entity.urlToImage,
        publishedAt: entity.publishedAt,
        content: entity.content
    );
  }
}

